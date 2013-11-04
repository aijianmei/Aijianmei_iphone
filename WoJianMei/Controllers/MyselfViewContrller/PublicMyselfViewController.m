//
//  MyselfViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import "PublicMyselfViewController.h"
#import "MyselfViewController.h"
#import "StatusCell.h"
#import "ImageManager.h"
#import "AppDelegate.h"
#import "User.h"
#import <CoreText/CoreText.h>
#import "WorkOutProcessViewController.h"
#import "UserService.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "BaiduMobStat.h"
#import "BMIViewController.h"
#import "UIImage+Scale.h"
#import "PostViewController.h"
#import "PostStatusRespose.h"
#import "PostStatus.h"
#import "PostService.h"
#import "UserInfoPickerViewController.h"
#import "HHNetDataCacheManager.h"
#import "ZJTStatusBarAlertWindow.h"
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


#define USER                          @"user"
#define USER_NAME                     @"screen_name"
#define USER_DESCRIPTION              @"description"
#define USER_AVATAR_IMAGE             @"avatar_large"
#define USER_GENDER                   @"gender"



@interface PublicMyselfViewController ()


@end

@implementation PublicMyselfViewController


-(void)addHeaderView{
    self.myHeaderView  =[[UIView alloc]init];
    [_myHeaderView setFrame: CGRectMake(0, 0, 320, 250)];
    [self.dataTableView setTableHeaderView:self.myHeaderView];
    
}

-(void)addAvatarBGImageView{
    self.backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    [self.backGroundImageView setImageWithURL:[NSURL URLWithString:self.user.avatarBackGroundImage] placeholderImage:[UIImage imageNamed:@"profile_backgroud.png"]];
    [self.myHeaderView addSubview:_backGroundImageView];
}


-(void)addAvtarImageButton{
    
    
    self.headerVImageButton = [[UIButton alloc]init];
    
    CALayer * layer = [self.headerVImageButton layer];
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.borderWidth = 2.0f;
    
    //添加四个边阴影
    _headerVImageButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _headerVImageButton.layer.shadowOffset = CGSizeMake(0, 0);
    _headerVImageButton.layer.shadowOpacity = 0.5;
    _headerVImageButton.layer.shadowRadius = 10.0;
    
    //给iamgeview添加阴影 < wbr > 和边框
    
    //添加两个边阴影
    _headerVImageButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _headerVImageButton.layer.shadowOffset = CGSizeMake(4, 4);
    _headerVImageButton.layer.shadowOpacity = 0.5;
    _headerVImageButton.layer.shadowRadius = 2.0;
    
    
    [_headerVImageButton addTarget:self
                            action:@selector(clickVatarButton:)
                  forControlEvents:UIControlEventTouchUpInside];
    [_headerVImageButton setFrame:CGRectMake(240, 155, 50, 50)];
    [_headerVImageButton setBackgroundColor:[UIColor clearColor]];
    [self.myHeaderView addSubview:_headerVImageButton];
    
}

-(void)addUserNameLabel{
    
    ////// set the Username
    self.userNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(80, 170, 145, 30)];
    _userNameLabel.backgroundColor =[UIColor clearColor];
    [_userNameLabel setTextAlignment:NSTextAlignmentRight];
    _userNameLabel.textColor = [UIColor whiteColor];
    [_userNameLabel setText:@"用户名"];
    [self.myHeaderView addSubview:self.userNameLabel];
}

-(void)addDescriptionBG
{
    //// Descritpin broundground
    UIImageView *descriptionBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"description_bround.png"]];
    [descriptionBG setFrame:CGRectMake(0, 200, 320, 50)];
    [_myHeaderView addSubview:descriptionBG];
    [descriptionBG release];
    
    
}

-(void)addDescriptionLabel{
    
    //初始化label
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 177, 270, 50)];
    //设置自动行数与字符换行
    [descriptionLabel setNumberOfLines:2];
    [descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    // 测试字串
    NSString *s = @"这是一个测试！！！ADSFASDFASDFASDFSADFASDFASFASFASFASDFASDFASDFASFASDFASDFASDFASDFASDFASDFASFASDFASDFASDFASDFASDFASDFA";
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    //设置一个行高上限
    CGSize size = CGSizeMake(230,50);
    
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [descriptionLabel setFrame:CGRectMake(0, 200, labelsize.width, labelsize.height)];
    
    
    self.descriptionLabel = descriptionLabel;
    [self.descriptionLabel setTextAlignment:NSTextAlignmentCenter];
    [self.descriptionLabel setBackgroundColor:[UIColor clearColor]];
    [self.descriptionLabel  setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.myHeaderView addSubview:self.descriptionLabel];
    [_myHeaderView bringSubviewToFront:_headerVImageButton];
    
    
}

-(PostViewController *)initPostViewController{
    
    if (self.postViewController == nil) {
        PostViewController *vc = [[PostViewController alloc]initWithNibName:
                                  @"PostViewController" bundle:nil];
        self.postViewController =vc;
        [vc release];
        
    }
    return _postViewController;
}

-(void)initUI{
    [self addHeaderView];
    [self addAvatarBGImageView];
    [self addAvtarImageButton];
    [self addUserNameLabel];
    [self addDescriptionBG];
    [self addDescriptionLabel];
}



@synthesize headerVImageButton=_headerVImageButton;
@synthesize backGroundImageView = _backGroundImageView;
@synthesize myHeaderView =_myHeaderView;
@synthesize userNameLabel=_userNameLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize sina_userInfo =_sina_userInfo;
@synthesize user =_user;
@synthesize postViewController =_postViewController;
@synthesize myselfViewController =_myselfViewController;


@synthesize imageDictionary =_imageDictionary;
@synthesize avatarDictionary =_avatarDictionary;
@synthesize browserView =_browserView;
@synthesize start =_start;




-(void)dealloc{
    
    [_headerVImageButton release];
    [_backGroundImageView release];
    [_footerVImageV release];
    [_myHeaderView release];
    [_userNameLabel release];
    [_descriptionLabel release];
    [_sina_userInfo release],_sina_userInfo = nil;
    [_user release];
    [_postViewController release];
    [_myselfViewController release];
    
    
    [_avatarDictionary release];
    [_imageDictionary release];
    [_browserView release];
    

    [super dealloc];
}

-(void)viewDidUnload{
    
    [super viewDidUnload];
    self.headerVImageButton =nil;
    self.backGroundImageView =nil;
    self.userNameLabel = nil;
    self.headerVImageButton =nil;
    self.footerVImageV =nil;
    self.myHeaderView =nil;
    self.userNameLabel =nil;
    self.descriptionLabel =nil;
    self.postViewController =nil;
    self.myselfViewController =nil;
    
    [defaultNotifCenter removeObserver:self name:HHNetDataCacheNotification object:nil];

}



-(void)loadUserData{
    
    NSString *uid = [[[UserService defaultService] user] uid];
    User *user =[[UserService defaultService] getUserInfoByUid:uid];
    
    //本地用户数据存在的时候直接读取本地数据;
    if (user) {
        
        User *user = [[UserService defaultService] getUserInfoByUid:uid];
        [[UserService defaultService] setUser:user];

        [self setUser:user];
        [self upgradeUI];
                
        //加载新数据 
        [self loadPublicDatas];

        
    }else{
        //本地数据不存在，用户第一次登陆的时候，就往服务器拉数据
        [[UserService defaultService] fecthUserInfoWithUid:uid delegate:self];
    }
}

- (void)upgradeUI
{
        
    [self.headerVImageButton setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"touxiang_40x40@2x.png"]];
    [self.backGroundImageView setImageWithURL:[NSURL URLWithString:self.user.avatarBackGroundImage] placeholderImage:[UIImage imageNamed:@"profile_backgroud.png"]];
    [self.userNameLabel setText:_user.name];
    [self.descriptionLabel setText:_user.description];
    
    [dataTableView reloadData];
}


//读取本地保存的图片
-(UIImage *) loadImageInDirectory:(NSString *)directoryPath {
    
    NSData *imageData =[NSData dataWithContentsOfFile:directoryPath];
    UIImage *result =[UIImage imageWithData:imageData];
    return result;
}

#pragma mark -
#pragma mark - View lifecycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
      [self loadUserData];
      [self upgradeUI];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"MyselfView"];
    
}
-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"MyselfView"];
}


-(void)setup{
    defaultNotifCenter = [NSNotificationCenter defaultCenter];
    _avatarDictionary = [[NSMutableDictionary alloc] init];
    _imageDictionary = [[NSMutableDictionary alloc] init];
}

-(void)viewDidLoad
{
    self.supportRefreshHeader = YES;
    self.supportRefreshFooter = YES;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //    self.dataList = [NSArray arrayWithObjects:@"性别",@"年龄",@"身高(cm)",@"体重(kg)",@"BMI", nil];
    
    [self setTitle:@"运动圈"];
    
    [self setNavigationRightButton:@"" imageName:@"Camera.png" action:@selector(clickPostStatusButton:)];
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    

    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    [self setup];
    
    [self initUI];
    [self loadUserData];

    [defaultNotifCenter addObserver:self selector:@selector(getAvatar:)         name:HHNetDataCacheNotification object:nil];
    
}

-(void)loadPublicDatas
{

     [self showActivityWithText:@"数据加载中..."];
      _reloading = YES;
      shouldLoad =YES;
    
    int uidPublic = 0;
    //加载的是公共部分
    [[PostService sharedService] loadStatusWithUid:uidPublic
                                         targetUid:0
                                          gymGroup:0
                                             start:0
                                            offSet:5
                                          delegate:self];
}


-(void)clickPostStatusButton:(id)sender {
     UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"照相"
                                              otherButtonTitles:@"相册",nil];
    [share showInView:self.view];
    [share release];
}


#pragma mark --
#pragma mark --actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        {
            [self takePhoto];
        }
            break;
        case 1:
        {
            [self selectPhoto];
            
        }
            break;
        case 2:
            
        {
            NSLog(@"Button index :%d",buttonIndex);
        }
            break;
        default:
            break;
    }
}
#pragma mark -
#pragma mark - ImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image != nil)
    {
    
        [self.navigationController  dismissViewControllerAnimated:NO completion:^{
            
            PostViewController *postVC =  [self initPostViewController];
            [postVC setPostImage:image];
            postVC.delegate =self;
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:postVC];
            
            [self.navigationController presentViewController:navigation animated:YES completion:^{
                
                [self.navigationItem.rightBarButtonItem setEnabled:NO];
                
            }];
            [navigation release];}
         ];
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{

    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
}


#pragma mark - StatusCellDelegate
-(void)cellLikeButtonDidClick:(StatusCell *)theCell{
    if ([theCell.indexPath row] > [self.dataList count]) {
        //        NSLog(@"cellImageDidTaped error ,index = %d,count = %d",[theCell.cellIndexPath row],[statuesArr count]);
        return ;
    }
    
    
    likeIndexPath = theCell.indexPath;
    PostStatus *sts = [self.dataList objectAtIndex:[theCell.indexPath row]];
    int statusId  = [sts._id integerValue];
    [[PostService sharedService] postLikeWithUid:498
                                        StatusId:statusId
                                        delegate:self];
}



-(void)cellAvatarButtonDidClick:(StatusCell *)theCell{
   
    PostStatus *sts = [self.dataList objectAtIndex: theCell.indexPath.row];
    if (self.myselfViewController ==nil) {
        self.myselfViewController = [[MyselfViewController alloc]initWithNibName:@"MyselfViewController" bundle:nil];
    }
    
        self.myselfViewController.targetUid = [sts uid];
       [self.navigationController pushViewController:_myselfViewController animated:YES];
    
}

#pragma mark --
#pragma mark  Reload and LoadMore Method
//加载新的数据
- (void)reloadTableViewDataSource{
    _reloading =YES;
//    [self showActivityWithText:@"数据加载中..."];
    [[PostService sharedService] loadStatusWithUid:0
                                         targetUid:0
                                          gymGroup:0
                                             start:0
                                            offSet:5
                                          delegate:self];
}

//加载更多数据
- (void)loadMoreTableViewDataSource {
    
    _reloading =NO;
//    [self showActivityWithText:@"数据加载中..."];
    [[PostService sharedService] loadStatusWithUid:0
                                         targetUid:0
                                          gymGroup:0
                                             start:_start
                                            offSet:5
                                          delegate:self];

}

-(void)clickVatarButton:(id)sender{

    if (self.myselfViewController ==nil) {
        self.myselfViewController = [[MyselfViewController alloc]initWithNibName:@"MyselfViewController" bundle:nil];
    }
    self.myselfViewController.targetUid = [self.user uid];
    [self.navigationController pushViewController:_myselfViewController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    frame.origin.x = 0;
    frame.origin.y = 0;
    
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
#pragma mark -
#pragma mark - RKObjectLoaderDelegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Response code: %d", [response statusCode]);
    [self hideActivity];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
    [self hideActivity];
    if ([[error localizedDescription] isEqualToString:@"请求超时。"]) {
        PPDebug(@"请求超时");
    }
}

- (void)requestDidStartLoad:(RKRequest *)request
{
    NSLog(@"Start load request...");
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
    
    NSObject *object  = [objects objectAtIndex:0];
    
    //获取用户信息
    if ([object isMemberOfClass:[User class]]) {
        User *user = [objects objectAtIndex:0];
        [[UserService defaultService] setUser:user];
        [[UserService defaultService] storeUserInfoByUid:user.uid];
        self.user =[[UserService defaultService] user];
        [self loadPublicDatas];
        [self upgradeUI];
        [self hideActivity];

    }

    
    
    //获取 status 状态列表
    if ([object isMemberOfClass:[PostStatus class]]){
        PostStatus *postStatus =  [objects objectAtIndex:0];
        PPDebug(@"*****Get Statuses Successfully!!!*****");
        PPDebug(@"******%@******",postStatus._id);
        PPDebug(@"******%@******",postStatus.uid);
        PPDebug(@"******%@******",postStatus.content);
        PPDebug(@"******%@******",postStatus.imageurl);
        PPDebug(@"******%@******",postStatus.create_time);
        NSMutableArray *newDataList =nil;
        
        [self hideActivity];
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
        
        [StatusView hideStatusText];
        [StatusView initialize];
        
        
        [self loadPublicDatas];
    }
    
    
    
    
//    
//    
//    if ([object isMemberOfClass:[PostLikeResponse class]]){
//        PostLikeResponse *postLikeResponse =  [objects objectAtIndex:0];
//        PPDebug(@"*****Post Like Successfully!!!*****");
//        PPDebug(@"*****%@*****",postLikeResponse.uid);
//        PPDebug(@"*****%@*****",postLikeResponse.errorCode);
//        [self.navigationItem.rightBarButtonItem setEnabled:YES];
//        
//        //  10001 参数错误 缺少uid用户id或者缺少文章id
//        //  10002 用户已经赞过
//        //  0 提交成功
//        
//        
//        NSInteger errorCode =  [[postLikeResponse errorCode] integerValue];
//        
//        if (errorCode ==ERROR_SUCCESS)
//        {
//            [self popupHappyMessage:@"赞!" title:nil];
//            
//            //局部修改数据
//            PostStatus *status = [self.dataList objectAtIndex:likeIndexPath.row];
//            int like = 1;
//            NSString *newLike = [NSString stringWithFormat:@"%d",like + [status.like integerValue]];
//            [status setLike:newLike];
//            
//            //局部更新界面
//            NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:likeIndexPath.row inSection:0];
//            NSArray     *arr        = [NSArray arrayWithObject:indexPath];
//            [self.dataTableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
//        
//        }
//        if (errorCode ==LACK_OF_PARAMATERS) {
//            [self popupHappyMessage:@"未知错误" title:nil];
//        }
//        if (errorCode ==REPEATED_POST) {
//            [self popupUnhappyMessage:@"已赞,不可以贪心哦！" title:nil];
//        }
//    }
}



@end
