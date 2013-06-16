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

- (IBAction)clickSinaWeiboButton:(UIButton *)sender;

- (IBAction)clickQQShareButton:(UIButton *)sender;


@end
