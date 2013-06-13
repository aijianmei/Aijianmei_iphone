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

#import "AJMViewDelegate.h"




@class AJMViewDelegate;

enum
{
    TAB_REALTIME_SCORE = 0,
};


@interface AppDelegate : PPApplication <UIApplicationDelegate,UITabBarControllerDelegate,WXApiDelegate,sendMsgToWeChatViewDelegate>

{
      UINavigationController *_navigationController;
      AJMViewDelegate *_viewDelegate;
}
@property (retain, nonatomic)  UIWindow *window;
@property (nonatomic,retain)   UINavigationController *navigationController;
@property (strong, nonatomic)  IIViewDeckController *viewController;
@property (nonatomic,readonly) AJMViewDelegate *viewDelegate;

@end
