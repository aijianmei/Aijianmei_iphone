//
//  AppDelegate.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.

#import "AppDelegate.h"
#import "PPTabBarController.h"
#import "WorkoutViewController.h"
#import "MyselfViewController.h"
#import "Nutri_SupViewController.h"
#import "MakeFriendsViewController.h"
#import "MoreViewController.h"
#import "PlayVideosViewController.h"
#import "MySideMenueViewController.h"
#import "MFSideMenu.h"
#import "UIUtils.h"
#import "SinaweiboManager.h"
#import "DeviceDetection.h"
#import "ImageManager.h"
#import "UINavigationBarExt.h"




#define kAppRedirectURI     @"http://aijianmei.com"



@implementation AppDelegate

@synthesize window = _window;
@synthesize sinaWeiboManager =_sinaWeiboManager;
@synthesize tCWBEngine =_tCWBEngine;
@synthesize tencentOAuthManager =_tencentOAuthManager;
@synthesize navigationController =_navigationController;
@synthesize tabBarController=_tabBarController ;



- (void)dealloc
{
    [_tabBarController release];
    [_sinaWeiboManager release];
    [_tCWBEngine release];
    [_tencentOAuthManager release];
    [_navigationController release];
    [_window release];
    [super dealloc];
}

- (void)initTabViewControllers
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    PPTabBarController *tbController = [storyboard instantiateViewControllerWithIdentifier:@"PPTabBarController"];

    
    self.tabBarController = tbController;
    
    self.tabBarController.delegate = self;
    
    

	NSMutableArray* controllers = [[NSMutableArray alloc] init];
    
	WorkoutViewController* workoutViewController = (WorkoutViewController*)[storyboard instantiateViewControllerWithIdentifier:@"WorkoutViewController"];
    [UIUtils addViewControllerFromStoryBoard: workoutViewController
					 viewTitle:@""
					 viewImage:@"b_menu_1.png"
			  hasNavController:YES
			   viewControllers:controllers];
    
    Nutri_SupViewController * nutri_SupViewController = (Nutri_SupViewController*)[storyboard instantiateViewControllerWithIdentifier:@"Nutri_SupViewController"];
    [UIUtils addViewControllerFromStoryBoard:nutri_SupViewController
                     viewTitle:@""
                     viewImage:@"b_menu_2.png"
              hasNavController:YES
               viewControllers:controllers];

    MyselfViewController *myselfViewController = (MyselfViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MyselfViewController"];
    [UIUtils addViewControllerFromStoryBoard:myselfViewController
                                   viewTitle:@""
                                   viewImage:@"b_menu_3.png"
                            hasNavController:YES
                             viewControllers:controllers];

    
    MakeFriendsViewController *makeFriendsViewController =(MakeFriendsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MakeFriendsViewController"];
    
    
	[UIUtils addViewControllerFromStoryBoard:makeFriendsViewController
					 viewTitle:@""
					 viewImage:@"b_menu_4.png"
			  hasNavController:YES
			   viewControllers:controllers];
    
    
    MoreViewController *moreViewController =(MoreViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MoreViewController"];
	[UIUtils addViewControllerFromStoryBoard:moreViewController
                                   viewTitle:@""
                                   viewImage:@"b_menu_5.png"
                            hasNavController:YES
                             viewControllers:controllers];
    
    
    self.tabBarController.viewControllers = controllers;

    
    [self.tabBarController setSelectedImageArray:[NSArray arrayWithObjects:
                                                  @"b_menu_1s.png",
                                                  @"b_menu_2s.png",
                                                  @"b_menu_3s.png",
                                                  @"b_menu_4s.png",
                                                  @"b_menu_5s.png",
                                                  nil]];
    
    self.tabBarController.selectedIndex = TAB_REALTIME_SCORE;
    
    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_arrow.png"]];
    [self.tabBarController setTopImageView:imageView down:1.0 animated:YES];
    self.tabBarController.hidesBottomBarWhenPushed =YES;

    [imageView release];
   [controllers release];

}


- (void)customizeInterface
{
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"selection-tab.png"]];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
   [self initTabViewControllers];

    
    
    [self.window setRootViewController:self.tabBarController];
    
    [self.window makeKeyAndVisible];
    
    
    /////sinaweibo
    NSString *appKey = @"239725454";
    NSString *appSecret = @"e2064ac8fab9d889a9eccecc5babad11";
     _sinaWeiboManager = [SinaweiboManager defaultManager];
    [_sinaWeiboManager createSinaweiboWithAppKey:appKey appSecret:appSecret appRedirectURI:kAppRedirectURI delegate:self];

    
    ////tencentqqq
    NSArray *permissionArray =  [[NSArray arrayWithObjects:
                                  @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album",
                                  @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil] retain];
    _tencentOAuthManager = [TencentOAuthManager defaultManager];
    [_tencentOAuthManager createTencentQQWithAppId: @"100328471" appPermission:permissionArray appRedirectURI:@"www.qq.com" isInSafari:NO delegate:self];
    

    ///腾讯微博
    self.tCWBEngine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:@"http://www.aijianmei.com"];
    
    

    MySideMenueViewController *mySideMenuViewController = [[MySideMenueViewController alloc] init];

    MenuOptions options = MenuButtonEnabled|BackButtonEnabled;

    
    // make sure to display the navigation controller before calling this
    [MFSideMenuManager configureWithNavigationController:self.navigationController
                                      sideMenuController:mySideMenuViewController
                                                menuSide:MenuLeftHandSide
                                                 options:options];
    [mySideMenuViewController release];
    
    
    
    
    
    if ([DeviceDetection isOS5]){
        [[UINavigationBar appearance] setBackgroundImage:[[ImageManager defaultManager] navigationBgImage] forBarMetrics:UIBarMetricsDefault];
    }else{
        
       GlobalSetNavBarBackground(@"topmenu_bg@2x.png");
    }
    
//    [application setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    
    return YES;
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
    return [self.sinaWeiboManager.sinaweibo handleOpenURL:url] ;
}

//for ios version is or above 4.2
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self.sinaWeiboManager.sinaweibo handleOpenURL:url];
}

@end
