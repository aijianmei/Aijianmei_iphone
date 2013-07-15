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
    
    User *user = [[UserService defaultService] user];
    [_userNameTextField setText:user.name];
    
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
    }
    [[UserService defaultService] registerUserWithUsername:[userInfo objectForKey:@"name"] email:self.emailTextField.text password:self.passwordTextField.text usertype:self.userType snsId:self.snsId profileImageUrl:[userInfo objectForKey:@"profile_image_url"] sex:[userInfo objectForKey:@"gender"] age:nil body_weight:@"" height:@"" keyword:@"" province:[userInfo objectForKey:@"province"] city:[userInfo objectForKey:@"city"] delegate:self];
}

- (BOOL)verifyField
{
    if ([_emailTextField.text length] == 0){
        [UIUtils alert:@"电子邮件地址不能为空"];
        [_emailTextField becomeFirstResponder];
        return NO;
    }
    
    if ([_userNameTextField.text length] == 0){
        [UIUtils alert:@"用户名不能为空"];
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
    NSDictionary *userInfo = nil;
    if ([self.userType isEqualToString:@"sina"]) {
        userInfo = [[UserService defaultService] getSinaUserInfoWithUid:self.snsId];
    }
    User *user = [UserManager createUserWithUserId:result.uid sinaUserId:self.snsId qqUserId:nil userType:self.userType name:[userInfo objectForKey:@"name"] profileImageUrl:[userInfo objectForKey:@"profile_image_url"] gender:[userInfo objectForKey:@"gender"] email:_emailTextField.text password:_passwordTextField.text];
    
    NSLog(@"******Register success,return uid:%@",user.uid);
    [UserService defaultService].user = user;
    [[UserService defaultService] storeUserInfo];
    [self performSegueWithIdentifier:@"finishRegisterSegue" sender:self];
}

@end
