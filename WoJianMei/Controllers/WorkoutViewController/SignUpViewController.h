//
//  SignUpViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 5/23/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "UserService.h"
#import "UIKeyboardViewController.h"


@protocol SignUpViewControllerDelegate <NSObject>

@optional
-(void)pushToMyselfViewControllerFrom:(UIViewController *)viewController;
@end


@interface SignUpViewController : PPViewController<UserServiceDelegate,UIKeyboardViewControllerDelegate>
{
        
    BOOL isSignupAijianmeiUser;
    id <SignUpViewControllerDelegate> delegate;
    UIKeyboardViewController *keyBoardController;

}

@property (retain, nonatomic) IBOutlet UITextField *userNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) NSString *snsId;
@property (retain, nonatomic) NSString *userType;
@property (nonatomic,assign) id <SignUpViewControllerDelegate> delegate;


- (IBAction)closeDoneEdit:(id)sender;

-(IBAction)cancleButton:(id)sender;

@end
