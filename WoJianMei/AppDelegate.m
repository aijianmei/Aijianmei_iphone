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



//#define WeChatId @"wxd930ea5d5a258f4f"

///aijianmei
#define WeChatId @"wxc996cdfc0f512dd7"


#define kAppRedirectURI     @"http://aijianmei.com"



@implementation AppDelegate

@synthesize window = _window;
@synthesize sinaWeiboManager =_sinaWeiboManager;
@synthesize tCWBEngine =_tCWBEngine;
@synthesize tencentOAuthManager =_tencentOAuthManager;
@synthesize navigationController =_navigationController;
@synthesize tabBarController=_tabBarController ;


- (id)init{
    if(self = [super init]){
        _scene = WXSceneSession;
    }
    
    return self;

}

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



- (void)hideTabBar:(BOOL)isHide
{
   [self.tabBarController hideCustomTabBarView:isHide];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackTranslucent];

    
    // Assign tab bar item with titles
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5= [tabBar.items objectAtIndex:4];

//    
    tabBarItem1.title = @"锻炼";
    tabBarItem2.title = @"营养与辅助";
    tabBarItem3.title = @"我";
    tabBarItem4.title = @"交友互动";
    tabBarItem5.title = @"更多";

    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"workout_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"workout.png"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"nutri_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"nutri.png"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"myprofile_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"myprofile.png"]];
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"makefriend_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"makefriend.png"]];
    [tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"more_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"more.png"]];
    
    
    
    // Change the tab bar background
    UIImage* tabBarBackground = [UIImage imageNamed:@"bottom_bg@2x.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected.png"]];
    
    // Change the title color of tab bar items
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
    UIColor *titleHighlightedColor = [UIColor colorWithRed:153/255.0 green:192/255.0 blue:48/255.0 alpha:1.0];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, UITextAttributeTextColor,
                                                       nil] forState:UIControlStateHighlighted];
    

    
   
    
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
//    self.tCWBEngine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:@"http://www.aijianmei.com"];
    
    

    MySideMenueViewController *mySideMenuViewController = [[MySideMenueViewController alloc] init];

    MenuOptions options = MenuButtonEnabled|BackButtonEnabled;

    
    // make sure to display the navigation controller before calling this
    [MFSideMenuManager configureWithNavigationController:tabBarController
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
    
    // Register to WeChat   wxd930ea5d5a258f4f
    // aijianmei  :
    [WXApi registerApp:WeChatId];
    
    
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
    
    
//    switch (<#expression#>) {
//        case <#constant#>:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
    
    
//    return [self.sinaWeiboManager.sinaweibo handleOpenURL:url] ;
    
    return  [WXApi handleOpenURL:url delegate:self];

    
}

//for ios version is or above 4.2
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    return [self.sinaWeiboManager.sinaweibo handleOpenURL:url];
    return  [WXApi handleOpenURL:url delegate:self];

}

#define BUFFER_SIZE 1024 * 100
- (void) sendAppContent
{
    // Send content to WeChat
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"爱健美ios客户端测试！！！";
    message.description = @"爱健美，推广健身文化，传播健康理念！！！";
    [message setThumbImage:[UIImage imageNamed:@"QQWeibo_logo@2x.png"]];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = @"<xml>test</xml>";
    ext.url = @"http://www.aijianmei.com";
    
    Byte* pBuffer = (Byte *)malloc(BUFFER_SIZE);
    memset(pBuffer, 0, BUFFER_SIZE);
    NSData* data = [NSData dataWithBytes:pBuffer length:BUFFER_SIZE];
    free(pBuffer);
    
    ext.fileData = data;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}


@end
