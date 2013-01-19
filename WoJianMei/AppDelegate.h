//
//  AppDelegate.h
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPApplication.h"
#import "SinaweiboManager.h"
#import "TencentOAuthManager.h"
#import "TCWBEngine.h"


@class SinaweiboManager;
@class TCWBEngine;
@class PPTabBarController;


enum
{
    TAB_REALTIME_SCORE = 0,
};


@interface AppDelegate : PPApplication <UIApplicationDelegate,UITabBarControllerDelegate,SinaWeiboDelegate,TencentSessionDelegate>

{
      PPTabBarController	*_tabBarController;
      UINavigationController *_navigationController;
    
      SinaweiboManager    *_sinaWeiboManager;
      TencentOAuthManager *_tencentOAuthManager;
      TCWBEngine          *_tCWBEngine;

}

@property (retain, nonatomic)  UIWindow *window;
@property (readonly,nonatomic) SinaweiboManager *sinaWeiboManager;
@property (retain,nonatomic)   TCWBEngine  *tCWBEngine;
@property (readonly,nonatomic)  TencentOAuthManager *tencentOAuthManager;
@property (nonatomic,retain)     UINavigationController *navigationController;
@property (nonatomic, retain)   PPTabBarController	*tabBarController;





@end
