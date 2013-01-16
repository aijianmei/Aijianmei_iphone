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

@class SinaweiboManager;
@class TengxunWeiboManager;
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
      TengxunWeiboManager *_tengxunWeiboManager;
      TencentOAuthManager *_tencentOAuthManager;


}

@property (strong, nonatomic) UIWindow *window;
@property (readonly, nonatomic) SinaweiboManager *sinaWeiboManager;
@property (readonly,nonatomic)  TengxunWeiboManager *tengxunWeiboManager;
@property (readonly,nonatomic)  TencentOAuthManager *tencentOAuthManager;

@property (nonatomic,retain) UINavigationController *navigationController;


@property (nonatomic, retain)   PPTabBarController	*tabBarController;





@end
