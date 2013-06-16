//
//  LoginViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 5/23/13.
//
//

#import "LoginViewController.h"
#import "SinaWeiboManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStyleBordered target:self action:@selector(clickCancleButton:)];
    [bar setTitle:@"取消"];
    [self.navigationItem setRightBarButtonItem:bar];
    [bar release];

    
}

-(void)clickCancleButton:(UIButton *)sender{

    [self dismissModalViewControllerAnimated:YES];

}


//实现closeDoneEdit点击done关闭键盘
- (IBAction)closeDoneEdit:(id)sender
{
    [sender resignFirstResponder];
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
    
    _sinaweiboManager = [SinaWeiboManager sharedManager];
    [_sinaweiboManager createSinaweiboWithAppKey:@"239725454" appSecret:@"b383e7a0201c154e290cf9b839b95998" appRedirectURI:@"http://aijianmei.com" delegate:self];
    
    if (![_sinaweiboManager.sinaweibo isAuthValid]) {
        [_sinaweiboManager.sinaweibo logInInView:self.view];
    }    
}

- (IBAction)clickQQShareButton:(UIButton *)sender {
    
}

#pragma mark -
#pragma SinaWeiboDelegate methods
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [_sinaweiboManager storeAuthData];
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


@end
