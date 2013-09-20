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
#import "LoginViewController.h"
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
#import "VersionInfo.h"
#import "PublicMyselfViewController.h"
#import "StatusView.h"
#import "Reachability.h"
//#import "MobClick.h"
#import "NetworkDetector.h"
#import "UserManager.h"





// To be changed for each project  在苹果商店上面的ID
#define kAppId			@"683646344"




///aijianmei
#define WeChatId @"wxc996cdfc0f512dd7"



#define kAppRedirectURI     @"http://aijianmei.com"

//友盟统计的 key
#define kMobClickKey @"51b942ae56240bd8cb009671"


#define SinaweibossoLogin @"sinaweibosso"


#define IosAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#define BaiduMobileAnlyizeAppId @"eaca9d7cc8"


#define SPLASH_VIEW_TAG 20130909




@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController =_navigationController;
@synthesize viewDelegate = _viewDelegate;
@synthesize publicStatusViewController =_publicStatusViewController;
@synthesize homeViewController =_homeViewController;
@synthesize loginViewController =_loginViewController;


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
    [_publicStatusViewController release];
    [_homeViewController release];
    [_loginViewController release];
    [super dealloc];
}


#pragma mark Mob Click Delegates

- (NSString *)appKey
{
	return kMobClickKey;	// shall be changed for each application
}

+(AppDelegate*)getAppDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;    
}


-(PublicMyselfViewController *)initPublicStatusViewController{
    if (self.publicStatusViewController ==nil) {
        PublicMyselfViewController *myselfVC = [[PublicMyselfViewController alloc]initWithNibName:@"PublicMyselfViewController" bundle:nil];
        myselfVC.title = @"我";
        self.publicStatusViewController =myselfVC;
        [myselfVC release];
    }
    return _publicStatusViewController;
}

-(HomeViewController *)initHomeViewControllerFromAppDelegate{

    if (self.homeViewController == nil) {
            
        HomeViewController *vc =[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        self.homeViewController =vc;
            [vc release];
        self.homeViewController.title = @"首页";
        }
    
    return  _homeViewController;
}

-(LoginViewController *)initLoginViewController{
    
    if (self.loginViewController == nil) {
        
        LoginViewController *vc =[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        self.loginViewController =vc;
        [vc release];
        self.loginViewController.title = @"登陆";
    }
    
    return  _loginViewController;
}


-(void)showLoginView{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if (![[UserService defaultService] user]){
            LoginViewController *loginViewController =    [[AppDelegate getAppDelegate] initLoginViewController];
            loginViewController.delegate = [self homeViewController];
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginViewController];
            [self.window.rootViewController presentModalViewController:navigation animated:NO];
            [navigation release];
        }
    }
    else
    {
        
        return;
    }
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


#define BUFFER_SIZE  1024 * 100
- (void)sendAppContentWithTitle:(NSString*)title
                    description:(NSString *)descriptoin
                          image:(UIImage *)image
                        urlLink:(NSString*)urlLink
{
    // 发送内容给微信
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description =descriptoin;
    
    
    //发送的图片不能太大，否则，不可以通过！ 大小不能够超过32k 
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

-(void) changeScene:(NSInteger)scene{
    _scene = scene;
}





- (void)initUserService
{
    [UserService defaultService] ;
}

- (void)userRegister
{
    if (![UserManager isUserExisted]) {
        [[UserService  defaultService] userRegisterByToken:[self getDeviceToken]];
    }
    else {
        NSLog(@"User exist,User ID is <%@>, Skip Registration",[UserManager getUserId]);
    }
}

//- (void)initMobClick
//{
//    [MobClick setDelegate:self reportPolicy:BATCH];
//}



- (void)initNetworkDetector
{
    _networkDetector = [[NetworkDetector alloc]
                        initWithErrorMsg:@"应用检测到无法连接到互联网，请检查您的网络连接设置。"
                        detectInterval:2];
    [_networkDetector start];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    [self initNetworkDetector];
    
    
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSLog(@"Initiating remoteNoticationssAreActive");
    if(!application.enabledRemoteNotificationTypes){
        NSLog(@"Initiating remoteNoticationssAreActive1");
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge)];
    }
    UIApplication* myapp = [UIApplication sharedApplication];
    myapp.idleTimerDisabled = YES;
    
    
    
    
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = YES; // 是否允许截获并发送崩溃信息，请设置YES或者NO
    statTracker.channelId = @"ReplaceMeWithYourChannel";//设置您的app的发布渠道
    statTracker.logStrategy = BaiduMobStatLogStrategyCustom;//根据开发者设定的时间间隔接口发送 也可以使用启动时发送策略
    statTracker.logSendInterval = 1;  //为1时表示发送日志的时间间隔为1小时
    statTracker.logSendWifiOnly = YES; //是否仅在WIfi情况下发送日志数据
    statTracker.sessionResumeInterval = 60;//设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s
    statTracker.shortAppVersion  = IosAppVersion; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [statTracker startWithAppId:BaiduMobileAnlyizeAppId];//设置您在mtj网站上添加的app的appkey
    
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
  
  //RestKit initialized...
    RKURL *baseURL = [RKURL URLWithBaseURLString:kServerUrl];
    RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];
    objectManager.acceptMIMEType = RKMIMETypeJSON;
    objectManager.serializationMIMEType = RKMIMETypeJSON;
    objectManager.client.baseURL = baseURL;
    [objectManager.client setTimeoutInterval:30];
    objectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;


    
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
    
    //从本地获取用户信息
    //TOTO:根据用户uid登陆获取信息
    
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey: @"OriginalUserId"];
    PPDebug(@"*****OriginalUserId :%@*****",uid);
    
    if (uid !=nil) {
        User *user  =[[UserService defaultService] getUserInfoByUid:uid];
        [[UserService defaultService] setUser: user];
        [[UserService defaultService] storeUserInfoByUid:uid];;
    }

    
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        HomeViewController *homeViewVC =[self initHomeViewControllerFromAppDelegate];
       _navigationController = [[UINavigationController alloc]initWithRootViewController:homeViewVC];
        
        
        
        //添加left View 导航栏
        AJMLeftSideViewController *leftVC = [[[AJMLeftSideViewController alloc] init] autorelease];
        
        IIViewDeckController *vc = [[IIViewDeckController alloc] initWithCenterViewController:self.navigationController leftViewController:leftVC];
        
        vc.leftSize  = self.window.frame.size.width - (320 - 60.0);
        self.viewController = vc;
    
    } else {
        
    }
    
    
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];

    
    if ([DeviceDetection isOS5]){
        [[UINavigationBar appearance] setBackgroundImage:[ImageManager navigationBgImage] forBarMetrics:UIBarMetricsDefault];
    }else{
        
       GlobalSetNavBarBackground(@"topmenu_bg.png");
    }
    
    
    
    
    UIImage *startImage = nil;
    if ([DeviceDetection isIPhone5]) {
        startImage = [UIImage imageNamed:@"Default-568h.png"];
    } else {
        startImage = [UIImage imageNamed:@"Default.png"];
    }
    UIView* splashView = [[UIImageView alloc] initWithImage:startImage];
    splashView.frame = [self.window bounds];
    splashView.tag = SPLASH_VIEW_TAG;
    [self.window addSubview:splashView];
    [splashView release];
    [self performSelector:@selector(removeSplashView) withObject:nil afterDelay:2.0f];


    
    // Register to WeChat   wxd930ea5d5a258f4f
    // aijianmei  :
    
     [WXApi registerApp:WeChatId];
    
    
    
    ///
    if (![self isPushNotificationEnable]){
        [self bindDevice];
    }


    
    
    
    return YES;
}

- (void)removeSplashView
{
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:2.0f];
	
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
						   forView:self.window
                             cache:YES];
    [UIView commitAnimations];
    [[self.window viewWithTag:SPLASH_VIEW_TAG] removeFromSuperview];
    
     
        
        //检测当前版本是否为最新的版本
        [self performSelector:@selector(updateApplication) withObject:nil afterDelay:30.0f];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	NSLog(@"applicationWillResignActive");
//	[MobClick appTerminated];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    //不再检测网络
    [_networkDetector stop];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    
    //检测网络
    [_networkDetector start];
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


-(void)updateApplication{
    
    [[UserService defaultService] queryVersionWithDelegate:self];
}



#pragma mark -
#pragma mark Device Notification Delegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	
    // Get a hex string from the device token with no spaces or < >
	[self saveDeviceToken:deviceToken];
    //TODO post the device token to the server.
    
    // user already register
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
	NSString *message = [error localizedDescription];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"错误"
													message: message
                                                   delegate: nil
                                          cancelButtonTitle: @"确认"
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
	
	// try again
	 [self bindDevice];
}

- (void)showNotification:(NSDictionary*)payload
{
	NSDictionary *dict = [[payload objectForKey:@"aps"] objectForKey:@"alert"];
	NSString* msg = [dict valueForKey:@"loc-key"];
	NSArray*  args = [dict objectForKey:@"loc-args"];
	
	if (args != nil && [args count] >= 2){
		NSString* from = nil; //[args objectAtIndex:0];
		NSString* text = nil; //[args objectAtIndex:1];
		[UIUtils alert:[NSString stringWithFormat:NSLS(msg), from, text]];
	}
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	NSDictionary *payload = userInfo;
    
#ifdef DEBUG
	NSLog(@"receive push notification, payload=%@", [payload description]);
#endif
    
	if (nil != payload) {
        NSString *alert = [[payload objectForKey:@"aps"] valueForKey:@"alert"];
        PPDebug(@"%@",alert);
	}
}



#pragma mark -
#pragma SinaWeiboDelegate methods
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    [[SinaWeiboManager sharedManager] storeAuthData];
    
    //微博登陆后获取用户数据
    [[UserService defaultService] fetchSinaUserInfo:sinaweibo.userID delegate:self];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [[SinaWeiboManager sharedManager] removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [[SinaWeiboManager sharedManager] removeAuthData];
}


#pragma mark -
#pragma mark - SinaWeiboRequest Delegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    //  发送微博
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        NSLog(@"******%@",[error description]);
        
        [StatusView hideStatusText];

    }
    
    //获取用户个人信息
    if ([request.url hasSuffix:@"users/show.json"])
    {
        NSLog(@"******%@",[error description]);
        [StatusView hideStatusText];

    }
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    //  发送微博
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        NSLog(@"******%@",[result description]);
        [StatusView hideStatusText];
    }
    
    //获取用户个人信息
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [[UserService defaultService] storeSinaUserInfo:result];
        
        NSDictionary *userInfo = result;
        NSLog(@"<storeSinaUserInfo>:%@",[[userInfo objectForKey:@"id"] stringValue]);
        [StatusView hideStatusText];
        
    }
    
}


#pragma mark -
#pragma mark - RKObjectLoaderDelegate
- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Response code: %d", [response statusCode]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)requestDidStartLoad:(RKRequest *)request
{
    NSLog(@"Start load request...");
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects count: %d", [objects count]);
    
    if ([objects count]<=0) {
        return;
    }
    
    NSObject *result =[objects objectAtIndex:0];
    if ([result isMemberOfClass:[VersionInfo class]]){

        
        VersionInfo *versionInfo =[objects objectAtIndex:0];
        NSLog(@"当前版本是:%@,下载URL:%@,标题:%@,更新内容:%@",      versionInfo.version,
              versionInfo.downloadurl,
              versionInfo.updateTitle,
              versionInfo.updateContent);
        
        NSString *latestVersion = versionInfo.version;
        NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        //    NSString *localVersion =@"1.0";
        if ([latestVersion isEqualToString:localVersion]){
            PPDebug(@"当前是最新版本");
        }
        else{
        
            CommonDialog *dialog = [CommonDialog createDialogWithTitle:@"新版本升级提示!"
                                                              subTitle:versionInfo.updateTitle
                                                               content:versionInfo.updateContent OKButtonTitle:@"立刻升级"                                               cancelButtonTitle:@"稍后提醒"
                                                              delegate:self];
    
            [self.window addSubview:dialog];

        }
    }
}


#pragma mark -
#pragma CommonDialogDelegate methods
- (void)didClickOkButton
{
    [UIUtils openApp:kAppId];
}

- (void)didClickCancelButton
{
    return;
}


@end
