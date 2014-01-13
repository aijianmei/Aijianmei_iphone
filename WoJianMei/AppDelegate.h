//
//  AppDelegate.h
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPApplication.h"
#import "WXApi.h"
#import "MoreViewController.h"
#import "IIViewDeckController.h"
#import "AJMLeftSideViewController.h"
#import "CommonDialog.h"
#import "SinaWeibo.h"
#import "SinaWeiboAuthorizeView.h"
#import "UserService.h"
#import "BBSHomeViewController.h"
#import "EAIntroView.h"
#import "RespForWeChatViewController.h"





@class AJMViewDelegate;
@class PublicMyselfViewController;
@class LoginViewController;
@class NetworkDetector;



enum
{
    TAB_REALTIME_SCORE = 0,
};


@interface AppDelegate : PPApplication <UIApplicationDelegate,UITabBarControllerDelegate,WXApiDelegate,sendMsgToWeChatViewDelegate,RespForWeChatViewDelegate,CommonDialogDelegate,SinaWeiboRequestDelegate,SinaWeiboDelegate,UserServiceDelegate,EAIntroDelegate,UIAlertViewDelegate>

{
      UINavigationController *_navigationController;
      AJMViewDelegate *_viewDelegate;
      enum WXScene _scene;
    
    
    SinaWeiboManager *_sinaweiboManager;

    
    PublicMyselfViewController    *_publicStatusViewController;
    BBSHomeViewController         *_bbsHomeViewController;
    LoginViewController           *_loginViewController;
    
    
    NetworkDetector *_networkDetector;

    
}
@property (nonatomic,retain)  UIWindow *window;
@property (nonatomic,retain)   UINavigationController *navigationController;
@property (nonatomic, retain)  IIViewDeckController *viewController;
@property (nonatomic,readonly) AJMViewDelegate *viewDelegate;
@property (nonatomic,retain) PublicMyselfViewController *publicStatusViewController;
@property (nonatomic,retain) BBSHomeViewController *bbsHomeViewController;
@property (nonatomic,retain) HomeViewController *homeViewController;


@property (nonatomic,retain) LoginViewController *loginViewController;


+ (AppDelegate*)getAppDelegate;


-(PublicMyselfViewController *)initPublicStatusViewController;
-(HomeViewController *)initHomeViewControllerFromAppDelegate;
-(LoginViewController *)initLoginViewController;
-(void)showLoginView;

- (void)sendAppContentWithTitle:(NSString*)title
                    description:(NSString *)descriptoin
                          image:(UIImage *)image
                        urlLink:(NSString*)urlLink;
- (void)sendVideoContentWithTitle:(NSString*)title
                      description:(NSString *)descriptoin
                            image:(UIImage *)image
                        videoLink:(NSString*)videoLink;



@end
