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
#import "MySideMenueViewController.h"
#import "MFSideMenu.h"
#import "UIUtils.h"
#import "DeviceDetection.h"
#import "ImageManager.h"
#import "UINavigationBarExt.h"
#import  "MobClick.h"

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


- (id)init{
    if(self = [super init]){
        _scene = WXSceneSession;
    }
    
    return self;

}

- (void)dealloc
{
    [_navigationController release];
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
//    WorkoutViewController *apiVC = [[[WorkoutViewController alloc]init]autorelease];
    
    
    
    
//    WorkoutViewController *apiVC = [[UIStoryboard alloc]instantiateViewControllerWithIdentifier:@"WorkOutViewController"];
    
    
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
    
    
//    [MobClick startWithAppkey:Mobclick];

    [MobClick startWithAppkey:Mobclick reportPolicy:REALTIME channelId:nil];

    
    
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

- (void)doAuth
{
    SendAuthReq* req = [[[SendAuthReq alloc] init] autorelease];
    req.scope = @"post_timeline";
    req.state = @"xxx";
    
    [WXApi sendReq:req];
}

-(void) changeScene:(NSInteger)scene{
    _scene = scene;
}



@end
