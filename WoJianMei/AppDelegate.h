//
//  AppDelegate.h
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPApplication.h"
//#import "SinaweiboManager.h"
#import "TencentOAuthManager.h"
#import "TCWBEngine.h"
#import "WXApi.h"
#import "MoreViewController.h"


//@class SinaweiboManager;
@class TCWBEngine;
@class PPTabBarController;


enum
{
    TAB_REALTIME_SCORE = 0,
};


@interface AppDelegate : PPApplication <UIApplicationDelegate,UITabBarControllerDelegate,WXApiDelegate,TencentSessionDelegate,sendMsgToWeChatViewDelegate>

{
      PPTabBarController	*_tabBarController;
      UINavigationController *_navigationController;
    
      TencentOAuthManager *_tencentOAuthManager;
      TCWBEngine          *_tCWBEngine;
    
      enum WXScene _scene;


}

@property (retain, nonatomic)  UIWindow *window;
@property (retain,nonatomic)   TCWBEngine  *tCWBEngine;
@property (readonly,nonatomic) TencentOAuthManager *tencentOAuthManager;
@property (nonatomic,retain)   UINavigationController *navigationController;
@property (nonatomic, retain )  PPTabBarController	*tabBarController;


- (void)hideTabBar:(BOOL)isHide;

@end
