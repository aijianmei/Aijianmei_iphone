//
//  SignUpViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 5/23/13.
//
//

#import "SignUpViewController.h"
#import "User.h"
#import "UserService.h"
#import "UserManager.h"
#import "Result.h"
#import "StringUtil.h"
#import "BaiduMobStat.h"
#import "ImageManager.h"
#import "DeviceDetection.h"



enum errorCode {
    ERROR_SUCCESS =0,
    REPEAT_USER_NAME = 10001,
    REPEAT_USER_EMAIL = 10002,
    REPEAT_USER_NAME_EMAIL = 10003,
    USER_TYPE = 10004
};



@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize delegate;
@synthesize userNameTextField =_userNameTextField;
@synthesize emailTextField =_emailTextField;
@synthesize passwordTextField =_passwordTextField;
@synthesize snsId =_snsId;
@synthesize userType =_userType;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)tap{
    
    PPDebug(@"Tap the view");
    if ([_userNameTextField isEditing])
    {
        [_userNameTextField resignFirstResponder];
    }
    
    if ([_emailTextField isEditing])
    {
        [_emailTextField resignFirstResponder];
    }
    
    if ([_passwordTextField isEditing])
    {
        [_passwordTextField resignFirstResponder];
    }
    
}



#pragma - UIKeyboardViewController delegate methods

- (void)alttextFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

- (void)alttextViewDidEndEditing:(UITextView *)textView {
    NSLog(@"%@", textView.text);
}
#pragma mark -
#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"SignupView"];
    
    //停顿一会儿之后显示键盘
    float duration =0.3;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                  target:self
                                                selector:@selector(showKeyBoard)
                                                userInfo:nil
                                                 repeats:NO];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"SignupView"];
}



-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
    if ([_emailTextField isEditing]) {
        [_emailTextField resignFirstResponder];
    }
    if ([_userNameTextField isEditing]) {
        [_userNameTextField resignFirstResponder];
    }
    if ([_passwordTextField isEditing]) {
        [_passwordTextField resignFirstResponder];
    }

    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];

    
//	MCRelease(keyBoardController);
}



-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

//	keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
//	[keyBoardController addToolbarToKeyboard];
}


- (void)clickBack:(id)sender
{
	[self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)closeDoneEdit:(id)sender{
    
    
    [self didPressSignup:sender];
    [sender resignFirstResponder];
     
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setTitle:@"注册新用户"];
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    [self setNavigationRightButton:@"注册" imageName:@"top_bar_commonButton.png"  action:@selector(didPressSignup:)];

    [_userNameTextField setPlaceholder:@"用户名 : 如健美王子"];
    [_emailTextField setPlaceholder:@"邮箱: 格式如 xxx@gmail.com"];
    [_passwordTextField setPlaceholder:@"密码: 不得少于6为数字或字母"];
    
    
    if([DeviceDetection isIPhone5])
    {
        [self setBackgroundImageName:@"640X1136.png"];
    }
    else
    {
        [self setBackgroundImageName:@"640X960.png"];
    }
    [self showBackgroundImage];
    [self showBackgroundImage];

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];


    

    //轻触手势（单击，双击）
    UITapGestureRecognizer *tapCgr=nil;
    tapCgr=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                      action:@selector(tap)];
    tapCgr.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tapCgr];
    [tapCgr release];
    
    

    
	// Do any additional setup after loading the view.
    if ([self.userType isEqualToString:@"sina"]) {
        NSDictionary *userInfo = [[UserService defaultService] getSinaUserInfoWithUid:self.snsId];
        
        NSString *sinaWeiboUserName =[userInfo objectForKey:@"name"];
        [_userNameTextField setText:sinaWeiboUserName];

    }
    

    
    //停顿一会儿之后显示键盘
    float duration =0.4;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                  target:self
                                                selector:@selector(showKeyBoard)
                                                userInfo:nil
                                                 repeats:NO];
}

-(void)showKeyBoard{

    //当键盘显示了之后就停止计时器
    [_userNameTextField  becomeFirstResponder];
    [self.timer invalidate];


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_userNameTextField release];
    [_emailTextField release];
    [_passwordTextField release];
    [_snsId release];
    [_userType release];
    [super dealloc];
    
}

- (void)didPressSignup:(id)sender
{
    
    
    if ([self verifyField] == NO){
        return;
    }
    
    NSDictionary *userInfo = nil;
    if ([self.userType isEqualToString:@"sina"]) {
        userInfo = [[UserService defaultService] getSinaUserInfoWithUid:self.snsId];
        
        [[UserService defaultService] registerUserWithUsername:[userInfo objectForKey:@"name"] email:self.emailTextField.text password:self.passwordTextField.text usertype:self.userType snsId:self.snsId profileImageUrl:[userInfo objectForKey:@"profile_image_url"] sex:[userInfo objectForKey:@"gender"] age:@"23" body_weight:@"65" height:@"175" keyword:@"1233|33|eerw" province:[userInfo objectForKey:@"province"] city:[userInfo objectForKey:@"city"] delegate:self];

    }
    if ([self.userType isEqualToString:@"qq"]) {
       

    }
    if ([self.userType isEqualToString:@"local"]) {
        [self showActivityWithText:@"注册中..."];
        [[UserService defaultService] registerAijianmeiUserWithUsername:self.userNameTextField.text
                                                                  email:self.emailTextField.text
                                                               password:self.passwordTextField.text
                                                               usertype:self.userType delegate:self];
    }
    
    
}

- (BOOL)verifyField
{
    
    
    if ([_userNameTextField.text length] == 0){
        [UIUtils alert:@"用户名不能为空"];
        [_userNameTextField becomeFirstResponder];
        return NO;
    }
    
    if ([_emailTextField.text length] == 0){
        [UIUtils alert:@"电子邮件地址不能为空"];
        [_emailTextField becomeFirstResponder];
        return NO;
    }
    
    if (NSStringIsValidEmail(_emailTextField.text) == NO){
        [UIUtils alert:@"输入的电子邮件地址不合法，请重新输入"];
        [_emailTextField becomeFirstResponder];
        return NO;
    }
    
    if ([_passwordTextField.text length] == 0){
        [UIUtils alert:@"密码不能为空"];
        [_passwordTextField becomeFirstResponder];
        return NO;
    }
    
    
    if ([_passwordTextField.text length] <= 6){
        [UIUtils alert:@"密码长度不能少于六位数"];
        [_passwordTextField becomeFirstResponder];
        return NO;
    }

    
    return YES;
}

#pragma mark -
#pragma mark - RKObjectLoaderDelegate
- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Response code: %d", [response statusCode]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
    [self hideActivity];
}

- (void)requestDidStartLoad:(RKRequest *)request
{
    NSLog(@"Start load request...");
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects count: %d", [objects count]);
    Result *result = [objects objectAtIndex:0];
    PPDebug(@"The error code:%@",result.errorCode);
    
    /* 10001 用户名重复 
       10002 邮箱重复 
       10003 用户名以及邮箱都重复   
       10004 用户类型
     */
    
    int errocde = [result.errorCode integerValue];
    if (ERROR_SUCCESS ==errocde)
    {
        PPDebug(@"注册成功,用户ID:%@",result.uid);
    }
    
    if (REPEAT_USER_NAME ==errocde){
        [UIUtils alert:@"用户名已被使用"];
        [_userNameTextField becomeFirstResponder];
        return;
    }
    if (REPEAT_USER_EMAIL ==errocde){
        [UIUtils alert:@"邮箱已经被注册"];
        [_emailTextField becomeFirstResponder];
        return;

    }
    if (REPEAT_USER_NAME_EMAIL ==errocde){
        [UIUtils alert:@"用户名和邮箱已被注册"];
        [_userNameTextField becomeFirstResponder];
        return;

    }
    
    //通过新浪微博注册，获得用户名;
    NSDictionary *userInfo = nil;
    if ([self.userType isEqualToString:@"sina"]) {
        userInfo = [[UserService defaultService] getSinaUserInfoWithUid:self.snsId];
        
        User *user = [UserManager createUserWithUserId:result.uid
                                            sinaUserId:self.snsId
                                              qqUserId:nil
                                              userType:self.userType name:[userInfo objectForKey:@"name"]
                                       profileImageUrl:[userInfo objectForKey:@"profileLargeImageUrl"]
                                                gender:[userInfo objectForKey:@"gender"]
                                                 email:_emailTextField.text
                                              password:_passwordTextField.text];
        
        NSLog(@"******Register success,return uid:%@",user.uid);
        [UserService defaultService].user = user;
        [[UserService defaultService] storeUserInfoByUid:user.uid];
        
        
        
        //直接从注册页面，跳动到用户界面;
        [self dismissViewControllerAnimated:YES completion:^
         {
             // 调用该方法进入用户资料界面
             if (delegate && [delegate respondsToSelector:@selector(pushToMyselfViewControllerFrom:)])
             {
                [delegate pushToMyselfViewControllerFrom:self];
             }
         }];
        
    }
    
    
    
    
    
    //直接注册，用户名;
    if ([self.userType isEqualToString:@"local"]) {
        User *user = [UserManager createUserWithUserId:result.uid
                                            sinaUserId:nil
                                              qqUserId:nil
                                              userType:self.userType
                                                  name:_userNameTextField.text
                                       profileImageUrl:nil
                                                gender:nil
                                                 email:_emailTextField.text
                                              password:_passwordTextField.text];
        
        NSLog(@"******Register success,return uid:%@",user.uid);
        [UserService defaultService].user = user;
        [[UserService defaultService] storeUserInfoByUid:result.uid];
        
                
        //直接从注册页面，跳动到用户界面;
        [self dismissViewControllerAnimated:YES completion:^
         {
             // 调用该方法进入用户资料界面
             if (delegate && [delegate respondsToSelector:@selector(pushToMyselfViewControllerFrom:)])
             {
                 [delegate pushToMyselfViewControllerFrom:self];
             }
         }];
    }
}

@end















