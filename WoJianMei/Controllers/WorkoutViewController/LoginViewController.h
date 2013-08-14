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
#import "SignUpViewController.h"


@protocol LoginViewDelegate <NSObject>

@optional
-(void)pushToMyselfViewController:(id)sender;
@end



@interface LoginViewController : PPViewController<SinaWeiboDelegate, SinaWeiboRequestDelegate,RKObjectLoaderDelegate>
{
    SinaWeiboManager *_sinaweiboManager;
    UITextField    *_usernameField;
    UITextField    *_passwordField;
    
    id <LoginViewDelegate> delegate;
    
    SignUpViewController*_signUpViewController;
    
    UIButton *_sinaButton;
    UIButton *_aijianmeiButton;
    
}

@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;
@property (nonatomic, retain) NSString *snsId;
@property (nonatomic, retain) NSString *userType;
@property (nonatomic, retain)  IBOutlet UIButton *sinaButton;
@property (nonatomic, retain) IBOutlet UIButton *qqButton;
@property (nonatomic, retain) IBOutlet UIButton *aijianmeiButton;
@property (nonatomic,assign) id <LoginViewDelegate> delegate;
@property (nonatomic,retain) SignUpViewController*signUpViewController;



//实现closeDoneEdit点击done关闭键盘
- (IBAction)closeDoneEdit:(id)sender;
- (void)clickSinaWeiboButton:(UIButton *)sender;
- (void)clickQQShareButton:(UIButton *)sender;
- (void)clickSignupAijianmeiAccount:(UIButton *)sender;
@end
