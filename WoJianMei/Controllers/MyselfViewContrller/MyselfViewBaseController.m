//
//  StatusViewBaseController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/7/13.
//
//

#import "StatusViewBaseController.h"
#import "StatusCell.h"
#import "PostService.h"
#import "PostStatus.h"
#import "PostStatusRespose.h"
#import "PostLikeResponse.h"
#import "HHNetDataCacheManager.h"
#import "User.h"
#import "ImageBrowser.h"
#import "SHKActivityIndicator.h"
#import "GifView.h"
#import "ZJTStatusBarAlertWindow.h"
#import "StatusView.h"


enum ErrorCode
{
    ERROR_SUCCESS =0,
    LACK_OF_PARAMATERS =10001,
    REPEATED_POST =10002
};


#define kTextViewPadding            16.0
#define kLineBreakMode              UILineBreakModeWordWrap

@interface StatusViewBaseController ()

@end

@implementation StatusViewBaseController
@synthesize imageDictionary =_imageDictionary;
@synthesize avatarDictionary =_avatarDictionary;
@synthesize browserView =_browserView;
@synthesize start =_start;


-(void)dealloc{
    [_avatarDictionary release];
    [_imageDictionary release];
    [_browserView release];
    [super dealloc];
}


-(void)setup{
     defaultNotifCenter = [NSNotificationCenter defaultCenter];
     _avatarDictionary = [[NSMutableDictionary alloc] init];
     _imageDictionary = [[NSMutableDictionary alloc] init];
}


-(void)viewDidUnload{
    
    [defaultNotifCenter removeObserver:self name:HHNetDataCacheNotification object:nil];
    [super viewDidUnload];
}
- (void)viewDidLoad
{
    self.supportRefreshHeader = YES;
    self.supportRefreshFooter = YES;
    [super viewDidLoad];
    
    [self setup];
    
    // Do any additional setup after loading the view from its nib.

    [defaultNotifCenter addObserver:self
                           selector:@selector(getAvatar:)         name:HHNetDataCacheNotification object:nil];
    
}


#pragma mark --
#pragma mark  Reload and LoadMore Method
//加载新的数据
- (void)reloadTableViewDataSource{
}
//加载更多数据
- (void)loadMoreTableViewDataSource {
}

//计算text field 的高度。
-(CGFloat)cellHeight:(NSString*)contentText with:(CGFloat)with
{
    UIFont * font=[UIFont  systemFontOfSize:14];
    CGSize size=[contentText sizeWithFont:font constrainedToSize:CGSizeMake(with - kTextViewPadding, 300000.0f) lineBreakMode:kLineBreakMode];
    
    CGFloat height = size.height + 44;
    return height;
}



#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [StatusCell getCellIdentifier];
	StatusCell *cell = (StatusCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [StatusCell createCell:self];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    
    NSData *imageData = [_imageDictionary objectForKey:[NSNumber numberWithInt:[indexPath row]]];
    NSData *avatarData = [_avatarDictionary objectForKey:[NSNumber numberWithInt:[indexPath row]]];

    PostStatus *status = [self.dataList objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    if (status) {
        [cell setupCell:status
        avatarImageData:avatarData
       contentImageData:imageData];
    
    }
    return cell;
}

#pragma mark --
#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger  row = indexPath.row;
    
    if (row >= [self.dataList count]) {
        // NSLog(@"heightForRowAtIndexPath error ,index = %d,count = %d",row,[statuesArr count]);
        return 1;
    }
    PostStatus *status = [self.dataList objectAtIndex:row];
    NSString *url = status.imageurl;
    
    CGFloat height = 0.0f;
    height = [self cellHeight:status.content with:320.0f];
    
    if ( (url && [url length] != 0))
    {
        height = height + 80;
    }

    return height + 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//异步加载图片
-(void)getImages
{
    //得到文字数据后，开始加载图片
    for(int i=0;i<[self.dataList count];i++)
    {
        PostStatus * member=[self.dataList objectAtIndex:i];
        NSNumber *indexNumber = [NSNumber numberWithInt:i];
        
                
        
            //下载头像图片
        [[HHNetDataCacheManager getInstance] getDataWithURL:member.avatarProfileUrl withIndex:i];
       
        //下载正文图片
        if (member.imageurl && [member.imageurl length] != 0)
        {
            [[HHNetDataCacheManager getInstance] getDataWithURL:member.imageurl withIndex:i];
        }
        else
        {
            [_imageDictionary setObject:[NSNull null] forKey:indexNumber];
        }
    }
}

//得到图片
-(void)getAvatar:(NSNotification*)sender
{
    NSDictionary * dic = sender.object;
    NSString * url          = [dic objectForKey:HHNetDataCacheURLKey];
    NSNumber *indexNumber   = [dic objectForKey:HHNetDataCacheIndex];
    NSInteger index         = [indexNumber intValue];
    NSData *data            = [dic objectForKey:HHNetDataCacheData];
    
    //当下载大图过程中，后退，又返回，如果此时收到大图的返回数据，会引起crash，在此做预防。
    if (indexNumber == nil || index == -1) {
        NSLog(@"indexNumber = nil");
        return;
    }
    
    if (index >= [self.dataList count]) {
        //        NSLog(@"statues arr error ,index = %d,count = %d",index,[statuesArr count]);
        return;
    }
    
    PostStatus *sts = [self.dataList objectAtIndex:index];
     

    //得到的是头像图片
    if ([url isEqualToString:sts.avatarProfileUrl])
    {        
        [_avatarDictionary setObject:data
                              forKey:indexNumber];
    }
    
    //得到的是博文图片
    if([url isEqualToString:sts.imageurl])
    {
        [_imageDictionary setObject:data
                             forKey:indexNumber];
    }
    
    //reload table
    NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray     *arr        = [NSArray arrayWithObject:indexPath];
    
    
    [self.dataTableView reloadRowsAtIndexPaths:arr withRowAnimation:NO];
    [self.dataTableView reloadData];

}


#pragma mark --
#pragma mark - StatusCell Delegate

-(void)cellImageDidTaped:(StatusCell *)theCell image:(UIImage *)image
{
    shouldShowIndicator = YES;
    
    if ([theCell.indexPath row] > [self.dataList count]) {
        //        NSLog(@"cellImageDidTaped error ,index = %d,count = %d",[theCell.cellIndexPath row],[statuesArr count]);
        return ;
    }
    
    PostStatus *sts = [self.dataList objectAtIndex:[theCell.indexPath row]];
    
    BOOL isCanShowBigImage = sts && sts.imageurl && sts.bigImageUrl != nil;

    UIApplication *app = [UIApplication sharedApplication];
    
    
     CGRect frame =[[UIScreen mainScreen] bounds];
    
    //Original 
//    CGRect frame = CGRectMake(0, 0, 320, 480);
    
    
    if (_browserView == nil) {
        self.browserView = [[[ImageBrowser alloc]initWithFrame:frame] autorelease];
        [_browserView setUp];
    }
    
    _browserView.image = image;
    _browserView.theDelegate = self;
    
    if (isCanShowBigImage) {
        _browserView.bigImageURL = sts.bigImageUrl;

    }
    [_browserView loadImage];
    
    app.statusBarHidden = YES;
    UIWindow *window = nil;
    for (UIWindow *win in app.windows) {
        if (win.tag == 0) {
            [win addSubview:_browserView];
            window = win;
            [window makeKeyAndVisible];
        }
    }
    
    if (shouldShowIndicator == YES && _browserView) {
        [[SHKActivityIndicator currentIndicator] displayActivity:@"正在载入..." inView:_browserView];        
    }
    else shouldShowIndicator = YES;
}

#pragma mark - StatusCellDelegate

-(void)browserDidGetOriginImage:(NSDictionary*)dic
{
    NSString * url=[dic objectForKey:HHNetDataCacheURLKey];
    if ([url isEqualToString:_browserView.bigImageURL])
    {
        [[SHKActivityIndicator currentIndicator] hide];
         shouldShowIndicator = NO;
        
        UIImage * img=[UIImage imageWithData:[dic objectForKey:HHNetDataCacheData]];
        [_browserView.imageView setImage:img];
        
        NSLog(@"big url = %@",_browserView.bigImageURL);
        if ([_browserView.bigImageURL hasSuffix:@".gif"])
        {
            UIImageView *iv = _browserView.imageView; // your image view
            CGSize imageSize = iv.image.size;
            CGFloat imageScale = fminf(CGRectGetWidth(iv.bounds)/imageSize.width, CGRectGetHeight(iv.bounds)/imageSize.height);
            CGSize scaledImageSize = CGSizeMake(imageSize.width*imageScale, imageSize.height*imageScale);
            CGRect imageFrame = CGRectMake(floorf(0.5f*(CGRectGetWidth(iv.bounds)-scaledImageSize.width)), floorf(0.5f*(CGRectGetHeight(iv.bounds)-scaledImageSize.height)), scaledImageSize.width, scaledImageSize.height);
            
            GifView *gifView = [[GifView alloc]initWithFrame:imageFrame data:[dic objectForKey:HHNetDataCacheData]];
            
            gifView.userInteractionEnabled = NO;
            gifView.tag = GIF_VIEW_TAG;
            [_browserView addSubview:gifView];
            [gifView release];
        }
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    [self dataSourceDidFinishLoadingNewData];
    [self dataSourceDidFinishLoadingMoreData];
    
    if ([objects count] <= 0) {
        [self popupMessage:@"亲,已经没有更多数据了！" title:nil];
        return;
    }

    PPDebug(@"***Load objects count: %d", [objects count]);

    [self hideActivity];
    
       
    NSObject *object  = [objects objectAtIndex:0];
    
    if ([object isMemberOfClass:[PostStatus class]]){
        PostStatus *postStatus =  [objects objectAtIndex:0];
        PPDebug(@"*****Get Statuses Successfully!!!*****");
        PPDebug(@"******%@******",postStatus._id);
        PPDebug(@"******%@******",postStatus.uid);
        PPDebug(@"******%@******",postStatus.content);
        PPDebug(@"******%@******",postStatus.imageurl);
        PPDebug(@"******%@******",postStatus.create_time);
        NSMutableArray *newDataList =nil;
        
        if (_start == 0) {
            self.dataList = objects;
        } else {
            
            newDataList = [NSMutableArray arrayWithArray:self.dataList];
            [newDataList addObjectsFromArray:objects];
            if (_reloading) {
                [newDataList setArray:objects];
                _start =0;
                
            }
        }
        
        self.dataList = newDataList;

        _start += [objects count];
        PPDebug(@"****objects %d******",[self.dataList count]);
        
        [_avatarDictionary  removeAllObjects];
        [_imageDictionary   removeAllObjects];
        
        [self.dataTableView reloadData];
        
        [self getImages];
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    }
    
    
    
    
    if ([object isMemberOfClass:[PostStatusRespose class]]){
        PostStatusRespose *postStatusRespose =  [objects objectAtIndex:0];
        PPDebug(@"*****Post one Status Successfully!!!*****");
        PPDebug(@"*****%@*****",postStatusRespose.uid);
        PPDebug(@"*****%@*****",postStatusRespose.errorCode);
        
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        [[ZJTStatusBarAlertWindow getInstance] hide];
        
        
        }
    
    
    
    
    
    
    if ([object isMemberOfClass:[PostLikeResponse class]]){
        PostLikeResponse *postLikeResponse =  [objects objectAtIndex:0];
        PPDebug(@"*****Post Like Successfully!!!*****");
        PPDebug(@"*****%@*****",postLikeResponse.uid);
        PPDebug(@"*****%@*****",postLikeResponse.errorCode);
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
        
        //  10001 参数错误 缺少uid用户id或者缺少文章id
        //  10002 用户已经赞过
        //  0 提交成功
        
        
        NSInteger errorCode =  [[postLikeResponse errorCode] integerValue];
        
        if (errorCode ==ERROR_SUCCESS)
        {
            [self popupHappyMessage:@"赞!" title:nil];
            
            //局部修改数据
            PostStatus *status = [self.dataList objectAtIndex:likeIndexPath.row];
            int like = 1;
            NSString *newLike = [NSString stringWithFormat:@"%d",like + [status.like integerValue]];
            [status setLike:newLike];
            
            //局部更新界面
            NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:likeIndexPath.row inSection:0];
            NSArray     *arr        = [NSArray arrayWithObject:indexPath];
            [self.dataTableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
            
            
        }
        if (errorCode ==LACK_OF_PARAMATERS) {
            [self popupHappyMessage:@"未知错误" title:nil];
        }
        if (errorCode ==REPEATED_POST) {
            [self popupUnhappyMessage:@"已赞,不可以贪心哦！" title:nil];
        }
    }
}

@end
