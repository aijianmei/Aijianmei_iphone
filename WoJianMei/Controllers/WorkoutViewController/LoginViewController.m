//
//  LoginViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 5/23/13.
//
//

#import "LoginViewController.h"
#import "SinaWeiboManager.h"
#import "UserService.h"
#import "SignUpViewController.h"
#import "AppDelegate.h"
#import "UserManager.h"
#import "User.h"
#import "Result.h"
#import "SinaResult.h"
#import "BaiduMobStat.h"
#import "DeviceDetection.h"

//239725454
//e2064ac8fab9d889a9eccecc5babad11

//爱健美网 
//#define kAppKey @"3622140445"
//#define kAppSecret @"f94d063d06365972215c62acaadf95c3"


//爱健美
#define kAppKey @"239725454"
#define kAppSecret @"e2064ac8fab9d889a9eccecc5babad11"


#define KAppRedirectURI @"http://aijianmei.com"


enum errorCode {
    ERROR_SUCCESS =0,
    WRONG_NAME_PASSWORD =10002
};

enum SinaResultErrorCode
 {
    SINA_ERROR_SUCCESS =0,
    NO_Such_User =10002
};


@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize  usernameField =_usernameField;
@synthesize  passwordField =_passwordField;
@synthesize delegate;
@synthesize signUpViewController =_signUpViewController;
@synthesize sinaButton =_sinaButton;
@synthesize aijianmeiButton =_aijianmeiButton;
@synthesize qqButton =_qqButton;
@synthesize loginButton =_loginButton;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)dealloc {
    
    
    [_usernameField release];
    [_passwordField release];
    [_snsId release];
    [_userType release];
    [_sinaButton release];
    [_qqButton release];
    [_aijianmeiButton release];
    [_signUpViewController release];
    [_loginButton release];
    
    [super dealloc];
}


-(void)viewDidUnload{
    
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [self setSinaButton:nil];
    [self setQqButton:nil];
    [self setAijianmeiButton:nil];
    [self setLoginButton:nil];
    [self setLoginButton:nil];
    [super viewDidUnload];
}

-(void)tap{

    PPDebug(@"Tap the view");
    if ([_passwordField isEditing])
    {
        [_passwordField resignFirstResponder];
    }
    
    if ([_usernameField isEditing])
    {
        [_usernameField resignFirstResponder];
    }

}

#pragma mark -
#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"LoginView"];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"LoginView"];
    [self.navigationController.navigationBar setHidden:NO];
    

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];

    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];

}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    
    [_passwordField setPlaceholder:@"请输入密码.."];

    //隐藏导航栏
    [self.navigationController.navigationBar setHidden:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];


}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
	// Do any additional setup after loading the view.
    [self setNavigationRightButton:@"取消" imageName:@"top_bar_commonButton.png" action:@selector(clickCancleButton:)];
    [_usernameField setClearsOnBeginEditing:NO];
    [_passwordField setClearsOnBeginEditing:NO];

    
    if([DeviceDetection isIPhone5])
    {
        [self setBackgroundImageName:@"640X1136.png"];
    }
    else
    {
        [self setBackgroundImageName:@"640X960.png"];
    }
        [self showBackgroundImage];


    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

    
    

    [self.sinaButton setTag:10];
    
    [self.sinaButton addTarget:self action:@selector(clickSinaWeiboButton:) forControlEvents:UIControlEventTouchDown];
    
    
    [self.qqButton setTag:10];
    [self.aijianmeiButton setTag:10];
    
    [self.aijianmeiButton addTarget:self action:@selector(clickSignupAijianmeiAccount:) forControlEvents:UIControlEventTouchDown];

    
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
    }else{
        
        
    }
    
    
    [self.loginButton addTarget:self action:@selector(closeDoneEdit:) forControlEvents:UIControlEventTouchUpInside];
    

    SignUpViewController *vc = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    self.signUpViewController =vc;


    
    //轻触手势（单击，双击）
    UITapGestureRecognizer *tapCgr=nil;
    tapCgr=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                  action:@selector(tap)];
    tapCgr.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tapCgr];
    [tapCgr release];

}

-(void)clickCancleButton:(UIButton *)sender{

    [self dismissViewControllerAnimated:YES completion:nil];

}
//实现closeDoneEdit点击done关闭键盘
- (IBAction)closeDoneEdit:(id)sender
{
    
    if ([_usernameField isEditing]) {
        [_passwordField becomeFirstResponder];
        return;
    }
    
    
    [sender resignFirstResponder];

    self.userType = @"local";

    //开始登陆
    if ([self verifyField] == NO){
        return;
    }
    NSDictionary *userInfo = nil;
    if ([self.userType isEqualToString:@"sina"]) {
        userInfo = [[UserService defaultService] getSinaUserInfoWithUid:self.snsId];
    }
    if ([self.userType isEqualToString:@"qq"]) {
//        userInfo = [[UserService defaultService] getSinaUserInfoWithUid:self.snsId];
    }
    
    if ([self.userType isEqualToString:@"local"]) {
    }

    [[UserService defaultService] loginUserWithEmail:_usernameField.text
                                            password:_passwordField.text
                                            usertype:self.userType
                                            viewController:self];
    
    
}




- (BOOL)verifyField
{
    if ([_usernameField.text length] == 0){
        [UIUtils alert:@"电子邮件地址不能为空"];
        [_usernameField becomeFirstResponder];
        return NO;
    }
    
    if (NSStringIsValidEmail(_usernameField.text) == NO){
        [UIUtils alert:@"输入的电子邮件地址不合法，请重新输入"];
        [_usernameField becomeFirstResponder];
        return NO;
    }
    
    if ([_passwordField.text length] == 0){
        [UIUtils alert:@"密码不能为空"];
        [_passwordField becomeFirstResponder];
        return NO;
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)clickSinaWeiboButton:(UIButton *)sender {
    
        [self setUserType:@"sina"];
        [[SinaWeiboManager sharedManager] createSinaweiboWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:KAppRedirectURI delegate:self];
    
       //授权不可用的时候,用户要重新登录
        if ([[SinaWeiboManager sharedManager].sinaweibo isAuthValid])
        {
            PPDebug(@"%@",[SinaWeiboManager sharedManager].sinaweibo.userID);
            
           [[UserService defaultService]  fechUserIdBySnsId:SinaWeiboManager.sharedManager.sinaweibo.userID
                                             viewController:self];
        }
    //授权不可用的时候,就获取新浪微博的id，再通过sns 的id 来获取用户信息；
        else if(![[SinaWeiboManager sharedManager].sinaweibo isAuthValid])
        {
            [[SinaWeiboManager sharedManager].sinaweibo logIn];
        }
    
}

- (void)clickQQShareButton:(UIButton *)sender {
    [self setUserType:@"qq"];
}


- (void)clickSignupAijianmeiAccount:(UIButton *)sender {
    
    self.userType =@"local";
    
    [self.navigationController pushViewController:self.signUpViewController  animated:YES];
    
   
     [self.navigationController.navigationBar setHidden:NO];
    
    _signUpViewController.snsId = [SinaWeiboManager sharedManager].sinaweibo.userID;
    _signUpViewController.userType =[self userType];
    
    self.signUpViewController.delegate = (id) self.delegate;
    
}



#pragma mark -
#pragma SinaWeiboDelegate methods
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    [[SinaWeiboManager sharedManager] storeAuthData];
    //微博登陆后获取用户数据
    [[UserService defaultService] fetchSinaUserInfo:sinaweibo.userID
                                           delegate:self];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [[SinaWeiboManager sharedManager] removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [[SinaWeiboManager sharedManager] removeAuthData];
}

#pragma mark - SinaWeiboRequest Delegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        NSLog(@"******%@",[error description]);
        
        [self hideActivity];
    }
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
    [[UserManager defaultManager] storeSinaUserInfo:result];
     
    NSDictionary *userInfo = result;
    NSLog(@"<storeSinaUserInfo>:%@",[[userInfo objectForKey:@"id"] stringValue]);
        
    /*获取新浪微博ID ,判断该用户是否已经注册;
      如果用户已经注册过，就直接返回用户的所有个人数据
      如果用户没有注册过，就让其注册；
    */
     [[UserService defaultService] fechUserIdBySnsId:[userInfo objectForKey:@"id"]
                                      viewController:self];
   }
}



#pragma mark -
#pragma mark - LoginBySinaWeiboAccountMethod
-(void)loginBySinaWeiboAccount:(int)resultCode
                           uid:(NSString *)uid
{
    //通过新浪微博或者腾讯微博等第三方账号登陆
        int errorCode = resultCode;
        if (SINA_ERROR_SUCCESS ==errorCode)
        {
            
            if ([uid integerValue] !=0 && errorCode ==0)
            {
                
                NSDictionary *sinaUserInfo =[[UserManager defaultManager] getSinaUserInfoWithUid:[SinaWeiboManager sharedManager].sinaweibo.userID];
                NSString *profileImageUrl = [sinaUserInfo objectForKey:@"profileImageUrl"];
                
                
                //正式创建新用户
                User *user = [UserManager createUserWithUserId:uid
                                                    sinaUserId:[SinaWeiboManager sharedManager].sinaweibo.userID
                                                      qqUserId:nil
                                                      userType:self.userType
                                                          name:nil
                                               profileImageUrl:profileImageUrl
                                                        gender:nil
                                                         email:nil
                                                      password:nil];
                
                [[UserManager defaultManager] setUser:user];
                
                     // 调用该方法进入用户资料界面
                if (delegate &&[delegate respondsToSelector:@selector(pushToMyselfViewController:)])
                     {
                         [delegate pushToMyselfViewController:self];
                     }
            }
    }
        
        
        if (NO_Such_User ==errorCode)
        {
            PPDebug(@"该用户不存在,用户要开始创建新的账户");
            
            _signUpViewController.snsId = _sinaweiboManager.sinaweibo.userID;
            _signUpViewController.userType =[self userType];
            
            [self.navigationController pushViewController:self.signUpViewController animated:YES];
            
        }
    
    
}

- (void)didUserLogined:(int)resultCode uid:(NSString *)uid
{
    //使用用户登陆接口，只是需要填写 邮箱以及密码
    /*
     10002 用户密码错误
     */
    
    int errorCode = 0;
    errorCode = resultCode;
    if (WRONG_NAME_PASSWORD == errorCode)
    {
        [UIUtils alert:@"用户名或密码 错误"];
        [_usernameField becomeFirstResponder];
        [_passwordField becomeFirstResponder];
        return;
    }
    
    if (ERROR_SUCCESS ==errorCode)
    {
        PPDebug(@"本地登陆成功,用户ID:%@",uid);
        if ([uid integerValue] !=0 && errorCode  ==0)
        {
            //正式创建新用户
            User *user = [UserManager createUserWithUserId:uid
                                                sinaUserId:nil
                                                  qqUserId:nil
                                                  userType:self.userType
                                                      name:nil
                                           profileImageUrl:nil
                                                    gender:nil
                                                     email:nil
                                                  password:nil];
            
            [[UserManager defaultManager] setUser:user];
            
            [self dismissViewControllerAnimated:YES completion:^{}];
            
            // 调用该方法进入用户资料界面
            if (delegate &&[delegate respondsToSelector:@selector(pushToMyselfViewController:)])
            {
                [delegate pushToMyselfViewController:self];
            }
        }
    }
}


@end
