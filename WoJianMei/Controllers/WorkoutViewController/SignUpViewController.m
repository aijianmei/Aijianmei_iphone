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
//    [self setTitle:@"账号绑定"];
    
    if ([self.userType isEqualToString:@"sina"]) {
        NSDictionary *userInfo = [[UserService defaultService] getSinaUserInfoWithUid:self.snsId];
        
        NSString *sinaWeiboUserName =[userInfo objectForKey:@"name"];
        [_userNameTextField setText:sinaWeiboUserName];

    }

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
    [_repeatPasswordTextField release];
    [_loginButton release];
    [_snsId release];
    [_userType release];
    [super dealloc];
    
}

- (IBAction)closeDoneEdit:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)didPressLogin:(id)sender
{
    if ([self verifyField] == NO){
        return;
    }
    NSDictionary *userInfo = nil;
    if ([self.userType isEqualToString:@"sina"]) {
        userInfo = [[UserService defaultService] getSinaUserInfoWithUid:self.snsId];
        
        [[UserService defaultService] registerUserWithUsername:[userInfo objectForKey:@"name"] email:self.emailTextField.text password:self.passwordTextField.text usertype:self.userType snsId:self.snsId profileImageUrl:[userInfo objectForKey:@"profile_image_url"] sex:[userInfo objectForKey:@"gender"] age:@"" body_weight:@"" height:@"" keyword:@"" province:[userInfo objectForKey:@"province"] city:[userInfo objectForKey:@"city"] delegate:self];

    }
    if ([self.userType isEqualToString:@"qq"]) {
       

    }
    if ([self.userType isEqualToString:@"local"]) {
        
        userInfo = [[UserService defaultService] createUserInfo:_userNameTextField.text];
        PPDebug(@"I am going to login as aijianmei account");
        
        [[UserService defaultService] registerAijianmeiUserWithUsername:[userInfo objectForKey:@"userName"] email:self.emailTextField.text password:self.passwordTextField.text usertype:self.userType delegate:self];
    }
}

- (BOOL)verifyField
{
    if ([_userNameTextField.text length] == 0){
        [UIUtils alert:@"用户名不能为空"];
        [_emailTextField becomeFirstResponder];
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
    
    if ([_repeatPasswordTextField.text length] == 0){
        [UIUtils alert:@"密码不能为空"];
        [_passwordTextField becomeFirstResponder];
        return NO;
    }
    
    if (![_repeatPasswordTextField.text isEqualToString:_passwordTextField.text]){
        [UIUtils alert:@"密码输入不一致"];
        [_repeatPasswordTextField becomeFirstResponder];
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
    }
    if (REPEAT_USER_EMAIL ==errocde){
        [UIUtils alert:@"邮箱已经被注册"];
        [_emailTextField becomeFirstResponder];
    }
    if (REPEAT_USER_NAME_EMAIL ==errocde){
        [UIUtils alert:@"用户名和邮箱已被注册"];
        [_userNameTextField becomeFirstResponder];
    }
    
    
    NSDictionary *userInfo = nil;
    if ([self.userType isEqualToString:@"sina"]) {
        userInfo = [[UserService defaultService] getSinaUserInfoWithUid:self.snsId];
        
        User *user = [UserManager createUserWithUserId:result.uid sinaUserId:self.snsId qqUserId:nil userType:self.userType name:[userInfo objectForKey:@"name"] profileImageUrl:[userInfo objectForKey:@"profile_image_url"] gender:[userInfo objectForKey:@"gender"] email:_emailTextField.text password:_passwordTextField.text];
        
        NSLog(@"******Register success,return uid:%@",user.uid);
        [UserService defaultService].user = user;
        [[UserService defaultService] storeUserInfo];
        [self performSegueWithIdentifier:@"finishRegisterSegue" sender:self];

    }
    if ([self.userType isEqualToString:@"local"]) {
        userInfo = [[UserService defaultService] createUserInfo:_userNameTextField.text];
        
        User *user = [UserManager createUserWithUserId:result.uid sinaUserId:nil qqUserId:nil userType:self.userType name:[userInfo objectForKey:@"name"] profileImageUrl:nil gender:nil email:_emailTextField.text password:_passwordTextField.text];
        
        NSLog(@"******Register success,return uid:%@",user.uid);
        [UserService defaultService].user = user;
        [[UserService defaultService] storeUserInfo];
        [self performSegueWithIdentifier:@"finishRegisterSegue" sender:self];
        
    }
}

@end
