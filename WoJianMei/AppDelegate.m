//
//  AppDelegate.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "PPTabBarController.h"
#import "HomeViewController.h"
#import "MyselfViewController.h"
#import "NutriViewController.h"
#import "MakeFriendsViewController.h"
#import "MoreViewController.h"
#import "UIUtils.h"
#import "DeviceDetection.h"
#import "ImageManager.h"
#import "UINavigationBarExt.h"
//#import  "MobClick.h"
#import "AJMLeftSideViewController.h"



// To be changed for each project

///aijianmei
#define WeChatId @"wxc996cdfc0f512dd7"
#define kAppRedirectURI     @"http://aijianmei.com"
#define Mobclick @"51b942ae56240bd8cb009671"


#define SinaweibossoLogin @"sinaweibosso"



@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController =_navigationController;
@synthesize viewDelegate = _viewDelegate;


- (id)init{
    if(self = [super init]){
        _viewDelegate = [[AJMViewDelegate alloc] init];
        _scene = WXSceneSession;

    }
    
    return self;

}

- (void)dealloc
{
    [_navigationController release];
    [_viewDelegate release];
    [_window release];
    [_viewController release];
    [super dealloc];
}

+ (AppDelegate*)getAppDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
  
  //RestKit initialized...
    RKURL *baseURL = [RKURL URLWithBaseURLString:kServerUrl];
    RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];
    objectManager.acceptMIMEType = RKMIMETypeJSON;
    objectManager.serializationMIMEType = RKMIMETypeJSON;
    objectManager.client.baseURL = baseURL;
    
//    
//    UIStoryboard *currentInUseStoryBoard ;
//    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        UIStoryboard * iPhoneStroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
//        
//        currentInUseStoryBoard = iPhoneStroyBoard;
//        
//    }else{
//        
//        UIStoryboard * iPadStroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
//        currentInUseStoryBoard = iPadStroyBoard;
//        
//    }
//
  
    
    HomeViewController *homeVC ;
//    MyselfViewController *rightVC;
    
    

    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
        //初始化主视图，  当用户点击左右的导航栏，可以更换；
        UIStoryboard * iPhonestroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        
       homeVC  = (HomeViewController*)[iPhonestroyBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        
        
        homeVC.title = @"主页";
        _navigationController = [[UINavigationController alloc] initWithRootViewController:homeVC];
        //左视图
        AJMLeftSideViewController *leftVC = [[[AJMLeftSideViewController alloc] init] autorelease];
    
        //右视图
//        rightVC = (MyselfViewController*)[iPhonestroyBoard instantiateViewControllerWithIdentifier:@"MyselfViewController"];
        
//        AJMRightSideViewController *ajmVC = [[AJMRightSideViewController alloc]init];
//        
//        
//        
        IIViewDeckController *vc = [[IIViewDeckController alloc] initWithCenterViewController:_navigationController leftViewController:leftVC];
//        
//        vc.rightController =ajmVC;
//        [ajmVC release];
        
        
        vc.leftSize  = self.window.frame.size.width - (320 - 60.0);
//        vc.rightSize = self.window.frame.size.width - (320 - 60.0);
        self.viewController = vc;

       
    } else {
        //初始化主视图，  当用户点击左右的导航栏，可以更换；
        UIStoryboard * iPadstroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        homeVC  = (HomeViewController*)[iPadstroyBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        homeVC.title = @"锻炼";
        UINavigationController *navVC = [[[UINavigationController alloc] initWithRootViewController:homeVC] autorelease];

        //左视图
        AJMLeftSideViewController *leftVC = [[[AJMLeftSideViewController alloc] init] autorelease];
        
        //右视图
//        rightVC = (MyselfViewController*)[iPadstroyBoard instantiateViewControllerWithIdentifier:@"MyselfViewController"];
        
       IIViewDeckController *vc = [[[IIViewDeckController alloc] initWithCenterViewController:navVC leftViewController:leftVC] autorelease];
        
//        vc.rightController =rightVC;
        vc.leftSize  = self.window.frame.size.width - (640 - 344.0);
//        vc.rightSize = self.window.frame.size.width - (640 - 344.0);
        self.viewController = vc;

    }

    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    //从本地获取用户信息
    //TOTO:根据用户uid登陆获取信息
    
    
     NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey: @"OriginalUserId"];
    PPDebug(@"*****OriginalUserId :%@*****",uid);
    
    if (uid !=nil) {
        User *user  =[[UserService defaultService] getUserInfoByUid:uid];
        [[UserService defaultService] setUser: user];
//        [[UserService defaultService] storeUserInfoByUid:uid];;
    }



    if ([DeviceDetection isOS5]){
        [[UINavigationBar appearance] setBackgroundImage:[ImageManager navigationBgImage] forBarMetrics:UIBarMetricsDefault];
    }else{
        
       GlobalSetNavBarBackground(@"topmenu_bg@2x.png");
    }
    
//    [application setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    
    // Register to WeChat   wxd930ea5d5a258f4f
    // aijianmei  :
    
     [WXApi registerApp:WeChatId];
//    [MobClick startWithAppkey:Mobclick reportPolicy:REALTIME channelId:nil];

        
    

    
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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    
    
    if ([url.absoluteString hasSuffix:SinaweibossoLogin]) {
        return [[SinaWeiboManager sharedManager].sinaweibo handleOpenURL:url];
    } else {
        return YES;
    }
    if ([url.absoluteString hasPrefix:@"http://weixin.qq.com/"]) {
        return [WXApi handleOpenURL:url delegate:self];
    } else {
        return YES;
    }

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{

    if ([sourceApplication isEqualToString:@"com.sina.weibo"] && [url.absoluteString hasPrefix:SinaweibossoLogin]){
        return [[SinaWeiboManager sharedManager].sinaweibo handleOpenURL:url];
    }else{
        
    return YES;
    }
    
    if ([url.absoluteString hasPrefix:@"http://weixin.qq.com/"]){
        return [WXApi handleOpenURL:url delegate:self];
    }else{
        
        return YES;
    }

}

@end
