//
//  AppDelegate.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "PPTabBarController.h"
#import "WorkoutViewController.h"
#import "MyselfViewController.h"
#import "NutriViewController.h"
#import "MakeFriendsViewController.h"
#import "MoreViewController.h"
#import "MySideMenueViewController.h"
#import "MFSideMenu.h"
#import "UIUtils.h"
#import "DeviceDetection.h"
#import "ImageManager.h"
#import "UINavigationBarExt.h"
#import  "MobClick.h"
#import <ShareSDK/ShareSDK.h>
#import "AJMLeftSideViewController.h"


//#define WeChatId @"wxd930ea5d5a258f4f"

///aijianmei
#define WeChatId @"wxc996cdfc0f512dd7"
#define kAppRedirectURI     @"http://aijianmei.com"
#define kServerUrl @"http://42.96.132.109/wapapi"

#define Mobclick @"51b942ae56240bd8cb009671"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController =_navigationController;
@synthesize viewDelegate = _viewDelegate;


- (id)init{
    if(self = [super init]){
        _viewDelegate = [[AJMViewDelegate alloc] init];

    }
    
    return self;

}

- (void)dealloc
{
    [_navigationController release];
    [_viewDelegate release];
    [_window release];
    [super dealloc];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
  
    
    
    // Assign tab bar item with titles
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//    
//
//    
//    
//    UITabBar *tabBar = tabBarController.tabBar;
//    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
//    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
//    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
//    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
//    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
//
////    
//    tabBarItem1.title = @"锻炼";
//    tabBarItem2.title = @"营养与辅助";
//    tabBarItem3.title = @"我";
//    tabBarItem4.title = @"交友互动";
//    tabBarItem5.title = @"更多";
//
//    
//    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"workout_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"workout.png"]];
//    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"nutri_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"nutri.png"]];
//    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"myprofile_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"myprofile.png"]];
//    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"makefriend_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"makefriend.png"]];
//    [tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"more_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"more.png"]];
//    
//    
//    
//    // Change the tab bar background
//    UIImage* tabBarBackground = [UIImage imageNamed:@"bottom_bg.png"];
//    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
//    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected.png"]];
//    
//    // Change the title color of tab bar items
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       [UIColor whiteColor], UITextAttributeTextColor,
//                                                       nil] forState:UIControlStateNormal];
//    UIColor *titleHighlightedColor = [UIColor colorWithRed:153/255.0 green:192/255.0 blue:48/255.0 alpha:1.0];
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       titleHighlightedColor, UITextAttributeTextColor,
//                                                       nil] forState:UIControlStateHighlighted];
//    
    
    
    
    
    //初始化主视图，  当用户点击左右的导航栏，可以更换；
    UIStoryboard * stroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    WorkoutViewController *apiVC = (WorkoutViewController*)[stroyBoard instantiateViewControllerWithIdentifier:@"WorkoutViewController"];

    
    apiVC.title = @"锻炼";
    UINavigationController *navApiVC = [[[UINavigationController alloc] initWithRootViewController:apiVC] autorelease];
    
    
    //左视图
    AJMLeftSideViewController *leftVC = [[[AJMLeftSideViewController alloc] init] autorelease];
    
    
    
    //右视图
    
    MyselfViewController *rightVC = (MyselfViewController*)[stroyBoard instantiateViewControllerWithIdentifier:@"MyselfViewController"];
    
    
    
    IIViewDeckController *vc = [[[IIViewDeckController alloc] initWithCenterViewController:navApiVC leftViewController:leftVC] autorelease];
    
    
    
    vc.rightController =rightVC;
    
    
    vc.leftSize  = self.window.frame.size.width - (320 - 44.0);
    vc.rightSize = self.window.frame.size.width - (320 - 34.0);
    

    self.viewController = vc;
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    //RestKit
    RKURL *baseURL = [RKURL URLWithBaseURLString:kServerUrl];
    RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];
    objectManager.acceptMIMEType = RKMIMETypeJSON;
    objectManager.serializationMIMEType = RKMIMETypeJSON;
    objectManager.client.baseURL = baseURL;

    if ([DeviceDetection isOS5]){
        [[UINavigationBar appearance] setBackgroundImage:[[ImageManager defaultManager] navigationBgImage] forBarMetrics:UIBarMetricsDefault];
    }else{
        
       GlobalSetNavBarBackground(@"topmenu_bg@2x.png");
    }
    
//    [application setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    
    // Register to WeChat   wxd930ea5d5a258f4f
    // aijianmei  :
    
    [WXApi registerApp:WeChatId];
    [MobClick startWithAppkey:Mobclick reportPolicy:REALTIME channelId:nil];

    /**
     注册SDK应用，此应用请到http://www.sharesdk.cn中进行注册申请。
     此方法必须在启动时调用，否则会限制SDK的使用。
     **/
    
    [ShareSDK registerApp:@"488184735e4"];
    [ShareSDK convertUrlEnabled:NO];

    [self initializePlat];
    
    //添加微信应用
    [ShareSDK connectWeChatWithAppId:@"wxc996cdfc0f512dd7" wechatCls:[WXApi class]];
    
    
    return YES;
}


- (void)initializePlat
{
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"239725454"
                               appSecret:@"b383e7a0201c154e290cf9b839b95998"
                             redirectUri:@"http://aijianmei.com"];
    
    
    
    //添加腾讯微博应用
    [ShareSDK connectTencentWeiboWithAppKey:@"100669978"
                                  appSecret:@"b383e7a0201c154e290cf9b839b95998"
                                redirectUri:@"http://www.sharesdk.cn"];
    

}
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}




//for ios version below 4.2
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
        
    
//    return [self.sinaWeiboManager.sinaweibo handleOpenURL:url] ;
    
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
    
    
}

//for ios version is or above 4.2
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    return [self.sinaWeiboManager.sinaweibo handleOpenURL:url];
//    return  [WXApi handleOpenURL:url delegate:self];
    
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];

}

@end
