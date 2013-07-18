//
//  SignUpViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 5/23/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import <RestKit/RestKit.h>

@protocol SignUpViewControllerDelegate <NSObject>

@optional
-(void)pushToMyselfViewControllerFrom:(UIViewController *)viewController;
@end


@interface SignUpViewController : PPViewController<RKObjectLoaderDelegate>
{
        
    BOOL isSignupAijianmeiUser;
    id <SignUpViewControllerDelegate> delegate;

}

@property (retain, nonatomic) IBOutlet UITextField *userNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (retain, nonatomic) NSString *snsId;
@property (retain, nonatomic) NSString *userType;
@property (nonatomic,assign) id <SignUpViewControllerDelegate> delegate;


- (IBAction)closeDoneEdit:(id)sender;
- (IBAction)didPressLogin:(id)sender;

@end
