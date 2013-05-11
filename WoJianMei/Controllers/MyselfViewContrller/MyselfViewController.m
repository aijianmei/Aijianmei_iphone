//
//  MyselfViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import "MyselfViewController.h"
#import "MyselfTableViewCell.h"
#import "ImageManager.h"
#import "Myself_SettingsViewController.h"
#import "ShareToSinaController.h"
#import "ShareToQQViewController.h"
#import "SinaweiboManager.h"
#import "AppDelegate.h"
#import "User.h"
#import "TencentOAuthManager.h"
#import "TCWBEngine.h"
#import "TCWBGlobalUtil.h"
#import "FileStreame.h"
#import "key.h"
#import <CoreText/CoreText.h>


#define USER                          @"user"
#define USER_NAME                     @"screen_name"
#define USER_DESCRIPTION              @"description"
#define USER_AVATAR_IMAGE             @"avatar_large"
#define USER_GENDER                   @"gender"


#ifndef WiressSDKDemoAppKey
#error
#endif

#ifndef WiressSDKDemoAppSecret
#error
#endif

#define TCWBAlertViewLogOutTag          100
#define TCWBAlertViewLogInTag           101


typedef enum SOCIAL_NET_WORK {
    SINA_WEIBO_ACCOUNT = 0,
    TENGXUN_QQ_ACOUNT = 1,
    TENGXUN_WEIBO_ACCOUNT,
}SOCIAL_NET_WORK;


@interface MyselfViewController ()
@end

@implementation MyselfViewController
@synthesize sinaModeSwitch = _sinaModeSwitch;
@synthesize tenCentQQModeSwitch =_tenCentQQModeSwitch;
@synthesize tenCentWeiboModeSwitch =_tenCentWeiboModeSwitch;
@synthesize headerVImageButton=_headerVImageButton;
@synthesize myHeaderView =_myHeaderView;
@synthesize userNameLabel=_userNameLabel;
@synthesize mottoLabel = _mottoLabel;
@synthesize userGenderLabel = _userGenderLabel;
@synthesize sina_userInfo =_sina_userInfo;
@synthesize user =_user;



-(void)dealloc{
    
    
    [_sinaModeSwitch release];
    [_tenCentWeiboModeSwitch release];
    [_tenCentQQModeSwitch release];
    [_headerVImageButton release];
    [_footerVImageV release];
    [_myHeaderView release];
    [_userNameLabel release];
    [_mottoLabel release];
    [_userGenderLabel release];
    [_sina_userInfo release], _sina_userInfo = nil;
    [_user release];
    [super dealloc];
}

-(void)viewDidUnload{
    
    [super viewDidUnload];
    self.headerVImageButton =nil;
    self.userNameLabel = nil;
    self.mottoLabel = nil;
    self.sinaModeSwitch =nil;
    self.tenCentWeiboModeSwitch=nil;
    self.tenCentQQModeSwitch =nil;
    self.headerVImageButton =nil;
    self.footerVImageV =nil;
    self.myHeaderView =nil;
    self.userNameLabel =nil;
    self.mottoLabel =nil;
    self.userGenderLabel =nil;
    
}



/* display new or existing cached image */

- (void)upgradeUI
{
    NSData *userData  =[[NSUserDefaults standardUserDefaults] objectForKey:USER];
    self.user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    
    [self.headerVImageButton setBackgroundImage:[self.user avatarImage] forState:UIControlStateNormal];

    
    NSString *userName = [self.user name];
    [self.userNameLabel setText:userName];
    
    NSString *userGender = [self.user gender];
    
    
    if ([userGender  isEqualToString:@"m"]) {
        
        [self.userGenderLabel setText:@"男"];

    }else{
        [self.userGenderLabel setText:@"女"];
        
    }
    
    NSString *description = [self.user description];
    [self.mottoLabel setText:description];
    
    
}

-(void)test{

//    [self performSegueWithIdentifier:@"SearchViewController" sender:self];
    
}

-(void)initUI{
    
    
    [self setTitle:@"我"];
    
    ///set the right buttons
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(clickSettingsButton:)];
    ////set the left buttons
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleBordered target:self action:@selector(test)];
    
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    [self.navigationItem setRightBarButtonItem:rightBarButton];

    [rightBarButton release];
    [leftBarButton release];
    
     //////// Set the headerView of the buttons  
    
    self.myHeaderView  =[[UIView alloc]init];
    [_myHeaderView setFrame: CGRectMake(0, 0, 100, 100)];
    
    
    self.headerVImageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_headerVImageButton addTarget:self action:@selector(clickVatarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _headerVImageButton.layer.borderWidth = 4.0f;
    _headerVImageButton.layer.cornerRadius = 8.0f;
    _headerVImageButton.layer.borderColor = [UIColor whiteColor].CGColor;

    
    [_headerVImageButton setFrame:CGRectMake(15, 16, 70, 70)];
    [_headerVImageButton setBackgroundColor:[UIColor grayColor]];
    [_headerVImageButton setImage:[ImageManager avatarbackgroundImage] forState:UIControlStateNormal];
    
    
////// set the Username 
    self.userNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(120, 30, 100, 30)];
    _userNameLabel.backgroundColor =[UIColor clearColor];
    [self.myHeaderView addSubview:self.userNameLabel];
    
    
    
    ////// set the User Gender
    self.userGenderLabel  = [[UILabel alloc]initWithFrame:CGRectMake(250, 30, 100, 30)];
    _userGenderLabel.backgroundColor =[UIColor clearColor];
    [self.myHeaderView addSubview:self.userGenderLabel];
    
    

 //////set the motto 
    self.mottoLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 70, 200, 30)];
    [_mottoLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    _mottoLabel.backgroundColor = [UIColor clearColor];
    
    [self.mottoLabel setTextAlignment:NSTextAlignmentLeft];
    [self.mottoLabel  setLineBreakMode:NSLineBreakByTruncatingTail];
    
    [self.myHeaderView addSubview:self.mottoLabel];

    
    [self.myHeaderView addSubview:self.headerVImageButton];
    [self.dataTableView setTableHeaderView:self.myHeaderView];
    


    
    
    
     //   新浪微博 
    sinaweiboManager = [self sinaweiboManager];
    
    //  腾讯QQ
    
    NSArray *_permissions =  [[NSArray arrayWithObjects:
					  @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album",
					  @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil] retain];
    
    [tencentQQManager createTencentQQWithAppId: @"100328471" appPermission:_permissions appRedirectURI:@"www.qq.com" isInSafari:NO delegate:self];
    
    

    [self setBackgroundImageName:@"BackGround.png"];
    [self showBackgroundImage];

    
}

- (SinaweiboManager *)sinaweiboManager
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.sinaWeiboManager setDelegate:self];
    return appDelegate.sinaWeiboManager;
}

- (TencentOAuthManager *)tencentOAuthManager
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.tencentOAuthManager setDelegate:self];
    return appDelegate.tencentOAuthManager;
}


- (TCWBEngine *)tCWBEngine
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.tCWBEngine setRootViewController:self];
    return appDelegate.tCWBEngine;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    sinaweiboManager    = [self   sinaweiboManager];
    tencentWeiboManager = [self         tCWBEngine];
    tencentQQManager    = [self tencentOAuthManager];

    [self initUI];
    /* prepare to use our own on-disk cache */
   
    [self upgradeUI];
    self.dataList = [NSArray arrayWithObjects:@"新浪微博",@"QQ登陆",@"腾讯微博账号", nil];
    
       
    
}

#pragma mark ----------------------------------------————————————————
#pragma mark  tableviewDelegate Method


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    switch (section) {
          case 0:
        {
            return 1;
        }
            break;
//        case 1:
//        {
//            return 2;
//        }
//            break;
//        case 2:
//        {
//            return 2;
//        }
//            break;
//        case 3:
//        {
//            return 3;
//        }
//            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [MyselfTableViewCell getCellIdentifier];
    
    MyselfTableViewCell *cell = (MyselfTableViewCell *)[self.dataTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell) {
        cell = [[[MyselfTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        cell.textLabel.textColor=[UIColor colorWithRed:0x46/255.0 green:0x46/255.0 blue:0x46/255.0 alpha:1.0];
    }
    
    
    
    [cell.textLabel setText:@"爱健美历程"];
    
//    if (indexPath.section==0) {
//        switch ([indexPath row]) {
//            case 0:
//            {
//                
//                UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [leftButton setFrame:CGRectMake(9, 0, 151, 55)];
//                [leftButton setTitle:@"私信" forState:UIControlStateNormal];
//                [leftButton addTarget:self
//                               action:@selector(theActionYouWant:)
//                     forControlEvents:UIControlEventTouchUpInside];
//                [cell addSubview:leftButton];
//                
//                
//                UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [rightButton setFrame:CGRectMake(160, 0, 151, 55)];
//                [rightButton setTitle:@"预约" forState:UIControlStateNormal];
//                [rightButton addTarget:self
//                                action:@selector(theActionYouWant:)
//                      forControlEvents:UIControlEventTouchDragOutside];
//                [cell addSubview:rightButton];
//                
//            }
//                
//                break;
//            case 1:
//            {
//                
//                UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [leftButton setFrame:CGRectMake(9, 0, 151, 55)];
//                [leftButton setTitle:@"评论" forState:UIControlStateNormal];
//                [leftButton addTarget:self
//                               action:@selector(theActionYouWant:)
//                     forControlEvents:UIControlEventTouchUpInside];
//                [cell addSubview:leftButton];
//                
//                
//                
//                UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [rightButton setFrame:CGRectMake(160, 0, 151, 55)];
//                [rightButton setTitle:@"@我" forState:UIControlStateNormal];
//                [rightButton addTarget:self
//                                action:@selector(theActionYouWant:)
//                      forControlEvents:UIControlEventTouchDragOutside];
//                [cell addSubview:rightButton];
//                
//            }
//                
//                break;
//            default:
//                break;
//        }
//    }
//    
    
//    if (indexPath.section==1) {
//        switch ([indexPath row]) {
//            case 0:
//            {
//                UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [leftButton setFrame:CGRectMake(9, 0, 151, 55)];
//                [leftButton setTitle:@"相册" forState:UIControlStateNormal];
//                [leftButton addTarget:self
//                               action:@selector(theActionYouWant:)
//                     forControlEvents:UIControlEventTouchUpInside];
//                [cell addSubview:leftButton];
//                
//                
//                
//                UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [rightButton setFrame:CGRectMake(160, 0, 151, 55)];
//                [rightButton setTitle:@"收藏" forState:UIControlStateNormal];
//                [rightButton addTarget:self
//                                action:@selector(theActionYouWant:)
//                      forControlEvents:UIControlEventTouchDragOutside];
//                [cell addSubview:rightButton];
//            }                break;
//            case 1:
//            {
//                UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [leftButton setFrame:CGRectMake(9, 0, 151, 55)];
//                [leftButton setTitle:@"好友" forState:UIControlStateNormal];
//                [leftButton addTarget:self
//                               action:@selector(theActionYouWant:)
//                     forControlEvents:UIControlEventTouchUpInside];
//                [cell addSubview:leftButton];
//                
//                
//                
//                UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [rightButton setFrame:CGRectMake(160, 0, 151, 55)];
//                [rightButton setTitle:@"粉丝" forState:UIControlStateNormal];
//                [rightButton addTarget:self
//                                action:@selector(theActionYouWant:)
//                      forControlEvents:UIControlEventTouchDragOutside];
//                [cell addSubview:rightButton];
//                
//            }
//                break;
//            default:
//                break;
//        }
//    }
//    
//    if (indexPath.section==2) {
//        switch ([indexPath row]) {
//            case 0:
//            {
//                UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [leftButton setFrame:CGRectMake(9, 0, 151, 55)];
//                [leftButton setTitle:@"消息" forState:UIControlStateNormal];
//                [leftButton addTarget:self
//                               action:@selector(theActionYouWant:)
//                     forControlEvents:UIControlEventTouchUpInside];
//                [cell addSubview:leftButton];
//                
//                
//                
//                UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [rightButton setFrame:CGRectMake(160, 0, 151, 55)];
//                [rightButton setTitle:@"消息" forState:UIControlStateNormal];
//                [rightButton addTarget:self
//                                action:@selector(theActionYouWant:)
//                      forControlEvents:UIControlEventTouchDragOutside];
//                [cell addSubview:rightButton];
//                
//                
//                
//            }
//                break;
//            case 1:
//            {
//                UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [leftButton setFrame:CGRectMake(9, 0, 151, 55)];
//                [leftButton setTitle:@"消息" forState:UIControlStateNormal];
//                [leftButton addTarget:self
//                               action:@selector(theActionYouWant:)
//                     forControlEvents:UIControlEventTouchUpInside];
//                [cell addSubview:leftButton];
//                
//                
//                
//                UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                [rightButton setFrame:CGRectMake(160, 0, 151, 55)];
//                [rightButton setTitle:@"消息" forState:UIControlStateNormal];
//                [rightButton addTarget:self
//                                action:@selector(theActionYouWant:)
//                      forControlEvents:UIControlEventTouchDragOutside];
//                [cell addSubview:rightButton];
//                
//            }
//                break;
//            default:
//                break;
//        }
//    }
    
//    if (indexPath.section==3) {
//        switch ([indexPath row]) {
//            case SINA_WEIBO_ACCOUNT:
//                cell.imageView.image =[ImageManager weiboImage];
//                cell.textLabel.text =@"新浪微博";
//                
//                self.sinaModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
//                [self.sinaModeSwitch addTarget: self action: @selector(switchsinaModeSwitch:) forControlEvents:UIControlEventValueChanged];
//                
//                if ([sinaweiboManager.sinaweibo isLoggedIn]) {
//                    [self.sinaModeSwitch setOn:YES animated:NO];
//                }else
//                    
//                {
//                    [self.sinaModeSwitch setOn:NO animated:NO];
//                }
//                cell.accessoryView = self.sinaModeSwitch;
//                
//                break;
//            case TENGXUN_QQ_ACOUNT:
//                cell.textLabel.text =@"QQ账号";
//                [cell.detailTextLabel setText: @"未绑定"];
//                cell.imageView.image =[ImageManager qqImage];
//                self.tenCentQQModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
//                [self.tenCentQQModeSwitch addTarget: self action: @selector(switchTencentQQModeSwitch:) forControlEvents:UIControlEventValueChanged];
//                
//                
//                
//                if ( [[tencentQQManager tencentOAuth] isLogIn]) {
//                    
//                    [self.tenCentQQModeSwitch setOn:YES animated:NO];
//                    
//                }else
//                    
//                {
//                    [self.tenCentQQModeSwitch setOn:NO animated:NO];
//                }
//                
//                cell.accessoryView = self.tenCentQQModeSwitch;
//                break;
//            case TENGXUN_WEIBO_ACCOUNT:
//                cell.textLabel.text =@"腾讯微博账号";
//                cell.detailTextLabel.text =@"未绑定";
//                cell.imageView.image =[ImageManager tengxunWeiboImage];
//                
//                self.tenCentWeiboModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
//                [self.tenCentWeiboModeSwitch addTarget: self action: @selector(switchTencentWeiboModeSwitch:) forControlEvents:UIControlEventValueChanged];
//                
//                
//                if (![tencentWeiboManager isAuthorizeExpired]) {
//                    
//                    [self.tenCentWeiboModeSwitch setOn:YES animated:NO];
//                    
//                    
//                }else
//                    
//                {
//                    [self.tenCentWeiboModeSwitch setOn:NO animated:NO];
//                    
//                }
//                cell.accessoryView = self.tenCentWeiboModeSwitch;
//                break;
//            default:
//                break;
//        }
//    }
    
    
    return cell;
}

-(void)clickSettingsButton:(id)sender{
    
    Myself_SettingsViewController *vc = [[Myself_SettingsViewController alloc]init];
    [self.navigationController pushViewController :vc animated:YES];
     vc.user = self.user;
    [vc release];
    
    
}

#pragma mark -
#pragma mark - UIAlertViewDelegate

// Called when a button is clicked. The view will be automatically dismissed after this call returns

-(void)alertView:(UIAlertView *)_alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{
    
    self.alertView = _alertView;
    ////根据alerview 的类型来确定。
    switch (self.alertView.tag) {
        case SINA_WEIBO_ACCOUNT:
            
        {
            if (buttonIndex==0) {
                [self.sinaModeSwitch setOn:YES animated:YES];
                return;
            }
            
            [sinaweiboManager.sinaweibo logOut];
            [self.sinaModeSwitch setOn:NO animated:YES];
            
        }
            break;
            
        case TENGXUN_QQ_ACOUNT:
        {
            if (buttonIndex==0) {
                PPDebug(@"TENGXUN_QQ_ACOUNT Cancle logout");
                [self.tenCentQQModeSwitch setOn:YES animated:YES];
                return;
            }
            
           [[TencentOAuthManager defaultManager].tencentOAuth logOut];
            [self.tenCentQQModeSwitch setOn:NO animated:YES];
            
        }
            break;
            
        case TENGXUN_WEIBO_ACCOUNT:
        {
            
            if (buttonIndex==0) {
                [self.tenCentWeiboModeSwitch setOn:YES animated:YES];
                return;
            }
            
            [tencentWeiboManager logOut];
            if ([tencentWeiboManager logOut]) {
                [self.tenCentWeiboModeSwitch setOn:NO animated:YES];

            }
            
        }
        default:
            break;
    }
}


-(void)showAlerViewWithMessage:(NSString *)message withAlerViewTag:(NSInteger)tag

{
    
    NSString *string = nil;
    switch (tag) {
        case SINA_WEIBO_ACCOUNT:
        {
            string = message;
            
        }
            break;
        case TENGXUN_QQ_ACOUNT:
        {
            string = message;
        }
            break;
        case TENGXUN_WEIBO_ACCOUNT:
        {
            string = message;
        }
            break;
            
        default:
            break;
    }
   
    UIAlertView *alerView  = [[UIAlertView alloc]initWithTitle:@"授权" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerView.tag = tag;
    [alerView show];
    [alerView release];
    
}

-(void)switchsinaModeSwitch:(id)sender{
    
    self.sinaModeSwitch = (UISwitch *)sender;
    
    if ( [self.sinaModeSwitch isOn]) {
       
        [sinaweiboManager.sinaweibo logIn];
    
    }else{
        
      [self showAlerViewWithMessage:@"是否解除与新浪微博的绑定？" withAlerViewTag:SINA_WEIBO_ACCOUNT];
    }
}

-(void)switchTencentQQModeSwitch:(id)sender{
    self.tenCentQQModeSwitch = (UISwitch *)sender;
    if ( [self.tenCentQQModeSwitch isOn]) {
                        
        [self loginQQAccount];

    }else
    {
        [self showAlerViewWithMessage:@"是否解除腾讯QQ的绑定？" withAlerViewTag:TENGXUN_QQ_ACOUNT];
    }
}

-(void)switchTencentWeiboModeSwitch:(id)sender{
    
    self.tenCentWeiboModeSwitch = (UISwitch *)sender;
    
    if ( [self.tenCentWeiboModeSwitch isOn]) {
        
        if ([tencentWeiboManager isAuthorizeExpired]) {
            [self loginTengxunWeiboAccount];
        }
        
    
    }else
    {
        
        [self showAlerViewWithMessage:@"是否解除与腾讯微博的绑定？" withAlerViewTag:TENGXUN_WEIBO_ACCOUNT];
        
    }
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self.dataTableView reloadData];
    [self upgradeUI];
    [self hideActivity];
    
}





-(void)clickVatarButton:(id)sender{
    
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"照相"
                                              otherButtonTitles:@"相册",nil];
    [share showFromTabBar:self.tabBarController.tabBar];
    [share release];

}




#pragma mark -
#pragma mark - ImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image != nil){
        
    [self.navigationController  dismissViewControllerAnimated:YES completion:^{
        [self.headerVImageButton setImage:image forState:UIControlStateNormal];
         self.user.avatarImage = image;
        [self storeUserInfo];
        
    }];
  }
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark-
-(void)loginSinaAccount
{
    [[self sinaweiboManager].sinaweibo logIn];
}

-(void)loginQQAccount{
   [[TencentOAuthManager defaultManager].tencentOAuth login];
}

-(void)loginTengxunWeiboAccount{
    
    [self showActivityWithText:@"请稍后"];
    [self onLogin];
    
}

//点击登录按钮
- (void)onLogin {
    [tencentWeiboManager logInWithDelegate:self
                         onSuccess:@selector(onSuccessLogin)
                         onFailure:@selector(onFailureLogin:)];
}
- (void)onLogout {
    // 注销授权
    if ([tencentWeiboManager logOut]) {
        PPDebug( @"登出成功！");
    }else {
        PPDebug(@"登出失败！");
    }
}
#pragma mark - login callback

//登录成功回调
- (void)onSuccessLogin
{
    PPDebug(@"登陆成功.");
    [self hideActivity];
}

//登录失败回调
- (void)onFailureLogin:(NSError *)error
{
    NSString *message = [[NSString alloc] initWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
    UIAlertView *myalertView = [[UIAlertView alloc] initWithTitle:[error domain]
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [myalertView show];
    [myalertView release];
    [message release];
}




#pragma mark -
#pragma SinaWeiboDelegate methods
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    PPDebug(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [sinaweiboManager storeAuthData];
    [self.dataTableView reloadData];
        
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    PPDebug(@"sinaweiboDidLogOut");
    [sinaweiboManager removeAuthData];
    [self.dataTableView reloadData];

}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    PPDebug(@"sinaweiboLogInDidCancel");
    [self.dataTableView reloadData];

}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    PPDebug(@"sinaweibo logInDidFailWithError %@", error);
    [self.dataTableView reloadData];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    PPDebug(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [sinaweiboManager removeAuthData];
    [self.dataTableView reloadData];
}


#pragma mark -
#pragma TencentQQDelegate methods

-(void)tencentDidLogin{
    
    PPDebug(@"TencentQQ login");
    [[TencentOAuthManager defaultManager] storeAuthData];
    [self.dataTableView reloadData];

}

-(void)tencentDidLogout{
    
    PPDebug(@"TencentQQ logout");
    [[TencentOAuthManager defaultManager] removeAuthData];
    [self.dataTableView reloadData];

}

-(void)tencentDidNotLogin:(BOOL)cancelled{

}


/////微博请求的delegate 返回数据

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [_sina_userInfo release], _sina_userInfo = nil;
    }
   
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [_sina_userInfo release];
         _sina_userInfo = [result retain];
        PPDebug(@"The userinfo %@",[_sina_userInfo description]);
    }
    
    [self storeSinaweiboDatas:_sina_userInfo];
}

- (void) storeSinaweiboDatas :(NSDictionary *)dataDictionary{

     NSString *sinaUserName =  [dataDictionary objectForKey:USER_NAME];
     NSString *description = [dataDictionary objectForKey:USER_DESCRIPTION];
     NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[dataDictionary objectForKey:USER_AVATAR_IMAGE]]];
     UIImage *image = [UIImage imageWithData:data];
     [data release];
     NSString *gender = [dataDictionary objectForKey:USER_GENDER];
    
    
    self.user.name = sinaUserName;
    self.user.description =description;
    self.user.avatarImage = image;
    self.user.gender = gender;
    
    [self storeUserInfo];
    
}


-(void)storeUserInfo{
    
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:USER];
    
}


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
            [self  selectPhoto];
            
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
