//
//  AppDelegate.h
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "SinaweiboManager.h"

@class SinaweiboManager;
@class TengxunWeiboManager;
@class PPTabBarController;


enum
{
    TAB_REALTIME_SCORE = 0,
};


@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,SinaWeiboDelegate>

{
      PPTabBarController	*_tabBarController;
      UINavigationController *_navigationController;
    
      SinaweiboManager *sinaWeiboManager;
      TengxunWeiboManager *tengxunWeiboManager;


}

@property (strong, nonatomic) UIWindow *window;
@property (readonly, nonatomic) SinaweiboManager *sinaWeiboManager;
@property (readonly,nonatomic)  TengxunWeiboManager *tengxunWeiboManager;
@property (nonatomic,retain) UINavigationController *navigationController;


@property (nonatomic, retain)   PPTabBarController	*tabBarController;


@end
