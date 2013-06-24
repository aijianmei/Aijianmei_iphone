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

@interface SignUpViewController : PPViewController<RKObjectLoaderDelegate>
{
        
    
}

@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)closeDoneEdit:(id)sender;
- (IBAction)didPressLogin:(id)sender;

@end
