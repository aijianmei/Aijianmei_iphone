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
#import "AJMLeftSideViewController.h"
#import "BaiduMobStat.h"
#import "WorkoutViewController.h"



// To be changed for each project

///aijianmei
#define WeChatId @"wxc996cdfc0f512dd7"
#define kAppRedirectURI     @"http://aijianmei.com"
#define Mobclick @"51b942ae56240bd8cb009671"


#define SinaweibossoLogin @"sinaweibosso"


#define IosAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define BaiduMobileAnlyizeAppId @"eaca9d7cc8"


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

+(AppDelegate*)getAppDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}



- (void)sendNewsContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"欢迎下载爱健美客户端！";
    message.description = @"爱健美iphone 客户端是一个专业的健身运动知识汇总手机客户端！";
    [message setThumbImage:[UIImage imageNamed:@"144x144.png"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"http://view.news.qq.com/zt2012/mdl/index.htm";
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    
    [WXApi sendReq:req];
}

-(void)RespNewsContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"欢迎下载爱健美客户端！";
    message.description = @"爱健美iphone 客户端是一个专业的健身运动知识汇总手机客户端！";
    [message setThumbImage:[UIImage imageNamed:@"144x144.png"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"http://view.news.qq.com/zt2012/mdl/index.htm";
    
    message.mediaObject = ext;
    
    GetMessageFromWXResp* resp = [[[GetMessageFromWXResp alloc] init] autorelease];
    resp.message = message;
    resp.bText = NO;
    
    [WXApi sendResp:resp];
}


#define BUFFER_SIZE 1024 * 100
- (void)sendAppContentWithTitle:(NSString*)title  description:(NSString *)descriptoin image:(UIImage *)image urlLink:(NSString*)urlLink
{
    // 发送内容给微信
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description =descriptoin;
    //发送的图片不能太大，否则，不可以通过！
    [message setThumbImage:image];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = @"<xml>爱健美</xml>";
    ext.url = urlLink;
    
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

-(void)RespAppContentWithTitle:(NSString*)title  description:(NSString *)descriptoin image:(UIImage *)image urlLink :(NSString*)urlLink

{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"欢迎下载爱健美客户端！";
    message.description = @"你看不懂啊， 看不懂啊， 看不懂！";
    [message setThumbImage:[UIImage imageNamed:@"144x144.png"]];
    
    WXAppExtendObject *ext = [WXAppExtendObject object];
    ext.extInfo = @"<xml>test</xml>";
    
    Byte* pBuffer = (Byte *)malloc(BUFFER_SIZE);
    memset(pBuffer, 0, BUFFER_SIZE);
    NSData* data = [NSData dataWithBytes:pBuffer length:BUFFER_SIZE];
    free(pBuffer);
    
    ext.fileData = data;
    
    message.mediaObject = ext;
    
    GetMessageFromWXResp* resp = [[[GetMessageFromWXResp alloc] init] autorelease];
    resp.message = message;
    resp.bText = NO;
    
    [WXApi sendResp:resp];
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
    

    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//    
//        HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
//        homeVC.title = @"主页";
//        self.navigationController = [[UINavigationController alloc] initWithRootViewController:homeVC];
        
//        [homeVC release];
        //左视图
//        AJMLeftSideViewController *leftVC = [[[AJMLeftSideViewController alloc] init] autorelease];
//        
//        IIViewDeckController *vc = [[IIViewDeckController alloc] initWithCenterViewController:_navigationController leftViewController:leftVC];
//    
//        vc.leftSize  = self.window.frame.size.width - (320 - 60.0);
//        self.viewController = vc;

       
//    } else {
//        //初始化主视图，  当用户点击左右的导航栏，可以更换；
//        UIStoryboard * iPadstroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
//        HomeViewController *homeVC = (HomeViewController*)[iPadstroyBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//        homeVC.title = @"锻炼";
//        UINavigationController *navVC = [[[UINavigationController alloc] initWithRootViewController:homeVC] autorelease];
//
//        //左视图
//        AJMLeftSideViewController *leftVC = [[[AJMLeftSideViewController alloc] init] autorelease];
//       IIViewDeckController *vc = [[[IIViewDeckController alloc] initWithCenterViewController:navVC leftViewController:leftVC] autorelease];
//        vc.leftSize  = self.window.frame.size.width - (640 - 344.0);
//        self.viewController = vc;
//
//    }
//    
//       
//
//        
////    self.window.rootViewController =self.viewController;
//    
//    self.window.rootViewController =self.navigationController;
//
//    [self.window makeKeyAndVisible];
    
    
    
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    HomeViewController *homeVC = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
         homeVC = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
       self.navigationController = [[UINavigationController alloc]initWithRootViewController:homeVC];
        
        
        
        //添加left View 导航栏
        AJMLeftSideViewController *leftVC = [[[AJMLeftSideViewController alloc] init] autorelease];
        
        IIViewDeckController *vc = [[IIViewDeckController alloc] initWithCenterViewController:self.navigationController leftViewController:leftVC];
        
        vc.leftSize  = self.window.frame.size.width - (320 - 60.0);
        self.viewController = vc;
        
        
        
        
        
    } else {
         homeVC = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
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
       [[UserService defaultService] storeUserInfoByUid:uid];;
    }



    if ([DeviceDetection isOS5]){
        [[UINavigationBar appearance] setBackgroundImage:[ImageManager navigationBgImage] forBarMetrics:UIBarMetricsDefault];
    }else{
        
       GlobalSetNavBarBackground(@"topmenu_bg.png");
    }
    
    
    // Register to WeChat   wxd930ea5d5a258f4f
    // aijianmei  :
    
     [WXApi registerApp:WeChatId];
//    [MobClick startWithAppkey:Mobclick reportPolicy:REALTIME channelId:nil];

        
    
    
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = YES; // 是否允许截获并发送崩溃信息，请设置YES或者NO
    statTracker.channelId = @"ReplaceMeWithYourChannel";//设置您的app的发布渠道
    statTracker.logStrategy = BaiduMobStatLogStrategyCustom;//根据开发者设定的时间间隔接口发送 也可以使用启动时发送策略
    statTracker.logSendInterval = 1;  //为1时表示发送日志的时间间隔为1小时
    statTracker.logSendWifiOnly = YES; //是否仅在WIfi情况下发送日志数据
    statTracker.sessionResumeInterval = 60;//设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s
    statTracker.shortAppVersion  = IosAppVersion; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [statTracker startWithAppId:BaiduMobileAnlyizeAppId];//设置您在mtj网站上添加的app的appkey
    

    
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
