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
#import "AJMViewDelegate.h"
#import "CommonDialog.h"




@class AJMViewDelegate;
@class PublicMyselfViewController;
@class LoginViewController;


enum
{
    TAB_REALTIME_SCORE = 0,
};


@interface AppDelegate : PPApplication <UIApplicationDelegate,UITabBarControllerDelegate,WXApiDelegate,sendMsgToWeChatViewDelegate,RKObjectLoaderDelegate,CommonDialogDelegate>

{
      UINavigationController *_navigationController;
      AJMViewDelegate *_viewDelegate;
      enum WXScene _scene;
    
    PublicMyselfViewController *_publicStatusViewController;
    HomeViewController         *_homeViewController;
    LoginViewController       *_loginViewController;
    
}
@property (nonatomic,retain)  UIWindow *window;
@property (nonatomic,retain)   UINavigationController *navigationController;
@property (nonatomic, retain)  IIViewDeckController *viewController;
@property (nonatomic,readonly) AJMViewDelegate *viewDelegate;
@property (nonatomic,retain) PublicMyselfViewController *publicStatusViewController;
@property (nonatomic,retain) HomeViewController *homeViewController;
@property (nonatomic,retain) LoginViewController *loginViewController;


+ (AppDelegate*)getAppDelegate;

-(PublicMyselfViewController *)initPublicStatusViewController;
-(HomeViewController *)initHomeViewController;
-(LoginViewController *)initLoginViewController;



@end
