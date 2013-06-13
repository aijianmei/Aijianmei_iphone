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






enum
{
    TAB_REALTIME_SCORE = 0,
};


@interface AppDelegate : PPApplication <UIApplicationDelegate,UITabBarControllerDelegate,WXApiDelegate,sendMsgToWeChatViewDelegate>

{
      UINavigationController *_navigationController;
    
    
      enum WXScene _scene;


}

@property (retain, nonatomic)  UIWindow *window;
@property (nonatomic,retain)   UINavigationController *navigationController;
@property (strong, nonatomic) IIViewDeckController *viewController;


- (void)hideTabBar:(BOOL)isHide;

@end
