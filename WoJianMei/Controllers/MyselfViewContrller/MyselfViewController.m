//
//  MyselfViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import "MyselfViewController.h"
#import "Myself_SettingsViewController.h"
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
#import "HHNetDataCacheManager.h"


#define USER                          @"user"
#define USER_NAME                     @"screen_name"
#define USER_DESCRIPTION              @"description"
#define USER_AVATAR_IMAGE             @"avatar_large"
#define USER_GENDER                   @"gender"


@interface MyselfViewController ()
@end

@implementation MyselfViewController
@synthesize headerVImageButton=_headerVImageButton;
@synthesize backGroundImageView = _backGroundImageView;
@synthesize myHeaderView =_myHeaderView;
@synthesize userNameLabel=_userNameLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize sina_userInfo =_sina_userInfo;
@synthesize user =_user;
@synthesize postViewController =_postViewController;
@synthesize targetUid =_targetUid;
@synthesize settingViewController =_settingViewController;



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
    [_targetUid release];
    [_settingViewController release];
    [super dealloc];
}

-(void)viewDidUnload{
    
    [super viewDidUnload];
    self.headerVImageButton =nil;
    self.backGroundImageView =nil;
    self.userNameLabel = nil;
    self.footerVImageV =nil;
    self.myHeaderView =nil;
    self.userNameLabel =nil;
    self.descriptionLabel =nil;
    self.postViewController =nil;
}



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
    
    
    [_headerVImageButton addTarget:self action:@selector(clickVatarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headerVImageButton setFrame:CGRectMake(240,155,50,50)];
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
    [self.myHeaderView addSubview:descriptionBG];
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

-(void)initPostViewController{
    PostViewController *vc = [[PostViewController alloc]initWithNibName:
                              @"PostViewController" bundle:nil];
    self.postViewController =vc;
    [vc release];
}

-(void)initUI{
    
    [self addHeaderView];
    [self addAvatarBGImageView];
    [self addAvtarImageButton];
    [self addUserNameLabel];
    [self addDescriptionBG];
    [self addDescriptionLabel];
    [self initPostViewController];
}


-(void)loadUserData{
    
    NSString *uid = [[[UserService defaultService] user] uid];
    
    //本地数据存在的时候直接读取本地数据;
    if ([[UserService defaultService] getUserInfoByUid:uid]) {
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

    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    [self setTitle:@"我"];
    [self setNavigationRightButton:@"设置" imageName:@"top_bar_commonButton.png" action:@selector(clickSettingsButton:)];
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
   

    
    
    [self initUI];
    
    
    [self setup];
    
    [defaultNotifCenter addObserver:self selector:@selector(getAvatar:)         name:HHNetDataCacheNotification object:nil];
    
    
    [self loadUserData];

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
            self.postViewController.postImage =image;
            self.postViewController.delegate =self;
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:self.postViewController];
            [self.navigationController presentViewController:navigation animated:YES completion:^{
                [self.navigationItem.rightBarButtonItem setEnabled:NO];

            }];
            [navigation release];}
         ];
    }
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
}



-(void)loadPublicDatas
{
//    [self showActivityWithText:@"数据加载中..."];
    _reloading = YES;
    shouldLoad =YES;
    [[PostService sharedService] loadStatusWithUid:[self.user.uid integerValue]
                                         targetUid:[self.targetUid integerValue]
                                          gymGroup:0
                                             start:0
                                            offSet:5
                                          delegate:self];
}



#pragma mark --
#pragma mark  Reload and LoadMore Method
//加载新的数据
- (void)reloadTableViewDataSource{
    
    _reloading = YES;
//    [self showActivityWithText:@"数据加载中..."];
    [[PostService sharedService] loadStatusWithUid:[self.user.uid integerValue]
                                         targetUid:[self.targetUid  integerValue]
                                          gymGroup:0
                                             start:0
                                            offSet:5
                                          delegate:self];

}
//加载更多数据
- (void)loadMoreTableViewDataSource {
    _reloading = NO;
//    [self showActivityWithText:@"数据加载中..."];
    [[PostService sharedService] loadStatusWithUid:[self.user.uid integerValue]
                                         targetUid:[self.targetUid integerValue]
                                          gymGroup:0
                                             start:_start
                                            offSet:5
                                          delegate:self];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)clickSettingsButton:(id)sender{
    
    
    if (self.settingViewController ==nil) {
      self.settingViewController = [[Myself_SettingsViewController alloc]initWithNibName:@"Myself_SettingsViewController" bundle:nil];

    }
    [self.navigationController pushViewController :_settingViewController animated:YES];
    
}




-(void)clickVatarButton:(id)sender{
    
    PPDebug(@"进入个人资料页面!!!");
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self showActivityWithText:@"数据加载中..."];
    
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    [self dataSourceDidFinishLoadingNewData];
    [self dataSourceDidFinishLoadingMoreData];
    
    [self hideActivity];
    PPDebug(@"***Load objects count: %d", [objects count]);
    
    if ([objects count] == 0) {
        [self popupMessage:@"亲,已经没有更多数据了！" title:nil];
        return;
    }
       
    NSObject *object  = [objects objectAtIndex:0];

    if ([object isMemberOfClass:[User class]]) {
         User *user = [objects objectAtIndex:0];
        [[UserService defaultService] setUser:user];
        [[UserService defaultService] storeUserInfoByUid:user.uid];
        self.user =[[UserService defaultService] user];
        [self upgradeUI];
    }
    
    
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
            self.dataList = newDataList;
        }
        
        _start += [objects count];
        PPDebug(@"****objects %d******",[self.dataList count]);
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

    }
    
    if ([objects count] == 0) {
        [self popupMessage:@"亲,已经没有更多数据了！" title:nil];
        return;
    }

}

@end
