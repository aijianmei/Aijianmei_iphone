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


#define kAppKey @"3622140445"
#define kAppSecret @"f94d063d06365972215c62acaadf95c3"
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




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setNavigationRightButton:@"取消" imageName:@"top_bar_commonButton.png" action:@selector(clickCancleButton:)];
    
    
    [self.sinaButton setTag:10];
    [self.qqButton setTag:10];
    [self.aijianmeiButton setTag:10];


}

-(void)clickCancleButton:(UIButton *)sender{

    [self dismissModalViewControllerAnimated:YES];

}
//实现closeDoneEdit点击done关闭键盘
- (IBAction)closeDoneEdit:(id)sender
{
    
    //    [[UserService defaultService] registerUserWithUsername:[userInfo objectForKey:@"name"] email:self.usernameField.text password:self.passwordField.text usertype:@"local" snsId:nil profileImageUrl:[userInfo objectForKey:@"profile_image_url"] sex:[userInfo objectForKey:@"gender"] age:nil body_weight:@"" height:@"" keyword:@"" province:[userInfo objectForKey:@"province"] city:[userInfo objectForKey:@"city"] delegate:self];

    [sender resignFirstResponder];

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
    
    

    self.userType = @"local";
    
    
    [[UserService defaultService] loginUserWithEmail:_usernameField.text
                                            password:_passwordField.text
                                            usertype:self.userType
                                            delegate:self];
    
    
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


- (void)dealloc {
    
    [super dealloc];
}
- (void)viewDidUnload {
    
    [super viewDidUnload];
}

- (IBAction)clickSinaWeiboButton:(UIButton *)sender {
    
        
        [self setUserType:@"sina"];
        _sinaweiboManager = [SinaWeiboManager sharedManager];
        [_sinaweiboManager createSinaweiboWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:KAppRedirectURI delegate:self];
    
       //授权不可用的时候,用户要重新登录
        if ([_sinaweiboManager.sinaweibo isAuthValid])
        {
            PPDebug(@"%@",_sinaweiboManager.sinaweibo.userID);
           [[UserService defaultService]  fechUserIdBySnsId :_sinaweiboManager.sinaweibo.userID delegate:self];
        }
    //授权不可用的时候,就获取新浪微博的id，再通过sns 的id 来获取用户信息；
        else if(![_sinaweiboManager.sinaweibo isAuthValid])
        {
            [_sinaweiboManager.sinaweibo logIn];
        }
    
}

- (IBAction)clickQQShareButton:(UIButton *)sender {
    [self setUserType:@"qq"];
}
- (IBAction)clickSignupAijianmeiAccount:(UIButton *)sender {
    self.userType =@"local";
    [self performSegueWithIdentifier:@"SignupViewSegue" sender:self];
    
}

#pragma mark -
#pragma SinaWeiboDelegate methods
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    [_sinaweiboManager storeAuthData];
    //微博登陆后获取用户数据
    [[UserService defaultService] fetchSinaUserInfo:sinaweibo.userID delegate:self];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [_sinaweiboManager removeAuthData];
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
    [_sinaweiboManager removeAuthData];
}

#pragma mark - SinaWeiboRequest Delegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        NSLog(@"******%@",[error description]);
    }
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
    [[UserService defaultService] storeSinaUserInfo:result];
     
    NSDictionary *userInfo = result;
    NSLog(@"<storeSinaUserInfo>:%@",[[userInfo objectForKey:@"id"] stringValue]);
        
    /*获取新浪微博ID ,判断该用户是否已经注册;
      如果用户已经注册过，就直接返回用户的所有个人数据
      如果用户没有注册过，就让其注册；
    */
     [[UserService defaultService] fechUserIdBySnsId:[userInfo objectForKey:@"id"]
                                               delegate:self];
   }
}




#pragma mark -
#pragma mark - RKObjectLoaderDelegate
- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Response code: %d", [response statusCode]);
    [self showActivityWithText:@"数据加载完成"];

}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)requestDidStartLoad:(RKRequest *)request
{
    NSLog(@"Start load request...");
    [self showActivityWithText:@"数据加载中"];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
     NSLog(@"***Load objects count: %d", [objects count]);
    NSObject *result =[objects objectAtIndex:0];
    [self hideActivity];
    
    //通过新浪微博或者腾讯微博等第三方账号登陆
    if ([result isMemberOfClass:[SinaResult class]])
    {
        SinaResult *result =[objects objectAtIndex:0];
        int errocde = [result.errorCode integerValue];
        
        if (SINA_ERROR_SUCCESS ==errocde)
        {
            PPDebug(@"登陆成功,用户ID:%@",result.uid);
            
            SinaResult *result =[objects objectAtIndex:0];
            if ([result.uid integerValue] !=0 && [result.errorCode integerValue] ==0)
            {
                //正式创建新用户
                User *user = [UserManager createUserWithUserId:result.uid sinaUserId:_sinaweiboManager.sinaweibo.userID qqUserId:nil userType:self.userType name:nil profileImageUrl:nil gender:nil email:nil password:nil];
                [[UserService defaultService] setUser:user];
                [self dismissViewControllerAnimated:YES completion:^
                 {
                     // 调用该方法进入用户资料界面
                     if (delegate &&[delegate respondsToSelector:@selector(pushToMyselfViewController:)])
                     {
                         [delegate pushToMyselfViewController:self];
                     }
                 }];
            }
        }
        if (NO_Such_User ==errocde)
        {
            PPDebug(@"该用户不存在,用户要开始创建新的账户");
            
            [self performSegueWithIdentifier:@"SignupViewSegue" sender:self];
            
        }
    
    }

    if ([result isMemberOfClass:[Result class]])
    {
        //使用用户登陆接口，只是需要填写 邮箱以及密码
        /*
         10002 用户密码错误
         */
        Result *result =[objects objectAtIndex:0];
        int errocde = [result.errorCode integerValue];
        
        
        if (WRONG_NAME_PASSWORD == errocde)
        {
            [UIUtils alert:@"用户名或密码 错误"];
            [_usernameField becomeFirstResponder];
            [_passwordField becomeFirstResponder];
            return;
        }
        
        if (ERROR_SUCCESS ==errocde)
        {
            PPDebug(@"本地登陆成功,用户ID:%@",result.uid);
            
            Result *result =[objects objectAtIndex:0];
            if ([result.uid integerValue] !=0 && [result.errorCode integerValue] ==0)
                {
                    //正式创建新用户
                    User *user = [UserManager createUserWithUserId:result.uid sinaUserId:nil qqUserId:nil userType:self.userType name:nil profileImageUrl:nil gender:nil email:nil password:nil];
                    [[UserService defaultService] setUser:user];
                    [self dismissViewControllerAnimated:YES completion:^
                    {
                        // 调用该方法进入用户资料界面
                        if (delegate &&[delegate respondsToSelector:@selector(pushToMyselfViewController:)])
                        {
                            [delegate pushToMyselfViewController:self];
                        }
                    }];
                }            
               }
         }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"SignupViewSegue"]) {
        
          SignUpViewController *signUpViewController = (SignUpViewController*)segue.destinationViewController;
           signUpViewController.snsId = _sinaweiboManager.sinaweibo.userID;
           signUpViewController.userType =[self userType];
    }
    
}

@end
