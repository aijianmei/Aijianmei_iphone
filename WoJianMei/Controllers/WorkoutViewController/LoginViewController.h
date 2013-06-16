//
//  LoginViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 5/23/13.
//
//

#import <UIKit/UIKit.h>
#import "SinaweiboManager.h"

@interface LoginViewController : UIViewController<SinaWeiboDelegate>
{
    SinaWeiboManager *_sinaweiboManager;
}

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;


//实现closeDoneEdit点击done关闭键盘
- (IBAction)closeDoneEdit:(id)sender;

- (IBAction)clickSinaWeiboButton:(UIButton *)sender;
- (IBAction)clickQQShareButton:(UIButton *)sender;


@end
