//
//  LoginViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 5/23/13.
//
//

#import <UIKit/UIKit.h>
#import "SinaweiboManager.h"
#import "PPViewController.h"
#import <RestKit/RestKit.h>



@interface LoginViewController : PPViewController<SinaWeiboDelegate, SinaWeiboRequestDelegate,RKObjectLoaderDelegate>
{
    SinaWeiboManager *_sinaweiboManager;
    UITextField    *_usernameField;
    UITextField    *_passwordField;
}

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (retain, nonatomic) NSString *snsId;
@property (retain, nonatomic) NSString *userType;

//实现closeDoneEdit点击done关闭键盘
- (IBAction)closeDoneEdit:(id)sender;
- (IBAction)clickSinaWeiboButton:(UIButton *)sender;
- (IBAction)clickQQShareButton:(UIButton *)sender;
- (IBAction)clickSignupAijianmeiAccount:(UIButton *)sender;
@end
