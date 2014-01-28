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
#import "NetworkDetector.h"
#import "UserManager.h"
#import "AJMViewDelegate.h"











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








NSString* GlobalGetServerURL()
{
    
//#ifdef DEBUG
//    //    return @"http://192.168.1.13:8001/api/i?";
//    //    return @"http://58.215.160.100:8002/api/i?";
//    
//    //    return @"http://58.215.160.100:8888/api/i?";
//    //    return @"http://192.168.1.5:8000/api/i?";
//    
//    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
//    NSString* str = [def objectForKey:@"api_server"];
//    if (str && str.length > 5) {
//        PPDebug(@"<for test!!!!!!> get api server %@", str);
//        return [NSString stringWithFormat:@"http://%@/api/i?",str];
//    }
//#endif
//    
//    return [ConfigManager getAPIServerURL];
    
    
     //Debug
    
  //    return @"http://192.168.1.107/~tomcallon/tom/ios.php?";

    
    //For Online
     return @"http://115.29.42.96/wapapi/ios.php?";
    
}



@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationController =_navigationController;
@synthesize viewDelegate = _viewDelegate;
@synthesize publicStatusViewController =_publicStatusViewController;
@synthesize bbsHomeViewController =_bbsHomeViewController;
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
    [_bbsHomeViewController release];
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
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            HomeViewController *vc=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
            self.homeViewController =vc;
            [vc release];
        }
        else
        {
             HomeViewController *vc =[[HomeViewController alloc] initWithNibName:@"HomeViewController ~ipad" bundle:nil];
            self.homeViewController =vc;
            [vc release];
        }

    }

    
    
    self.homeViewController.title = @"首页";
    return  self.homeViewController;

}

-(LoginViewController *)initLoginViewController{
    
    if (self.loginViewController == nil) {
        
        LoginViewController *vc =[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        self.loginViewController =vc;
        [vc release];
    }
    
    self.loginViewController.title = @"登陆";
    return  _loginViewController;
}


-(void)showLoginView{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if (![[UserManager defaultManager]user]){
            LoginViewController *loginViewController = [[AppDelegate getAppDelegate] initLoginViewController];
            loginViewController.delegate = [self homeViewController];
            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginViewController];            
            [self.window.rootViewController presentViewController:navigation animated:YES completion:^{}];
            [navigation release];
        }
    }
    else
    {
        if (![[UserManager defaultManager]user]){
        LoginViewController *loginViewController = [[AppDelegate getAppDelegate] initLoginViewController];
        loginViewController.delegate = [self homeViewController];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginViewController];
        [self.window.rootViewController presentViewController:navigation animated:YES completion:^{}];
        [navigation release];
    }
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


- (void)sendVideoContentWithTitle:(NSString*)title
                      description:(NSString *)descriptoin
                            image:(UIImage *)image
                        videoLink:(NSString*)videoLink
{
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = descriptoin;
    
    [message setThumbImage:image];
    
    WXVideoObject *ext = [WXVideoObject object];
    ext.videoUrl = videoLink;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[[SendMessageToWXReq alloc] init]autorelease];
    req.bText = NO;
    req.message = message;
    req.scene = _scene;
    
    [WXApi sendReq:req];
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

-(void)changeScene:(NSInteger)scene{
    _scene = scene;
}


-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        [alert release];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        switch (resp.errCode) {
            case WXSuccess:
            {
                [UIUtils alert:@"已成功分享至微信"];
                PPDebug(@"<onResp> weixin response success");

            }
                break;
            case WXErrCodeUserCancel:
            {
                [UIUtils alert:@"用户取消分享"];
                PPDebug(@"<onResp> weixin response fail");
                
            }
                break;

            case WXErrCodeUnsupport:
            {
                [UIUtils alert:@"微信版本不支持"];
                PPDebug(@"<onResp> weixin response fail");
                
            }
                break;
                
            default:
                break;
        }
    }
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

    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = YES; // 是否允许截获并发送崩溃信息，请设置YES或者NO
    statTracker.channelId = @"ReplaceMeWithYourChannel";//设置您的app的发布渠道
    statTracker.logStrategy = BaiduMobStatLogStrategyCustom;//根据开发者设定的时间间隔接口发送 也可以使用启动时发送策略
    statTracker.logSendInterval = 1;  //为1时表示发送日志的时间间隔为1小时
    statTracker.logSendWifiOnly = YES; //是否仅在WIfi情况下发送日志数据
    statTracker.sessionResumeInterval = 60;//设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s
    statTracker.shortAppVersion  = IosAppVersion; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [statTracker startWithAppId:BaiduMobileAnlyizeAppId];//设置您在mtj网站上添加的app的appkey

    
    //从本地获取用户信息
    //TOTO:根据用户uid登陆获取信息
    
    
    NSString *uid =[UserManager loadUserId];
    PPDebug(@"*****OriginalUserId :%@*****",uid);
    
    
    
    
    if (uid !=nil) {
        User *user  =[[UserManager defaultManager] getUserInfoByUid:uid];
        [[UserManager defaultManager] setUser: user];
        [[UserManager defaultManager] storeUserInfoByUid:uid];;
    }

    
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    
        HomeViewController *homeViewVC =[self initHomeViewControllerFromAppDelegate];
       _navigationController = [[UINavigationController alloc]initWithRootViewController:homeViewVC];
        
        //添加left View 导航栏
        AJMLeftSideViewController *leftVC = [[[AJMLeftSideViewController alloc] init] autorelease];
        
        IIViewDeckController *vc = [[IIViewDeckController alloc] initWithCenterViewController:self.navigationController leftViewController:leftVC];
    
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone){
        vc.leftSize  = self.window.frame.size.width - (self.window.frame.size.width - 80.0f);

    }else{
        vc.leftSize  = self.window.frame.size.width - (self.window.frame.size.width - 80.0f);
    }

    
    self.viewController = vc;
    
    
    

    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    

    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
	[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:155.0/255.0 blue:255.0/255.0 alpha:1]];

    
    
    
    
    
//    if (![[UserManager defaultManager] user]) {
//        
//        UIImage *startImage = nil;
//        if ([DeviceDetection isIPhone5]) {
//            startImage = [UIImage imageNamed:@"Default-568h.png"];
//        } else {
//            startImage = [UIImage imageNamed:@"Default.png"];
//        }
//        
//        UIView* splashView = [[UIImageView alloc] initWithImage:startImage];
//        splashView.frame = [self.window bounds];
//        splashView.tag = SPLASH_VIEW_TAG;
//        [self.window addSubview:splashView];
//        [splashView release];
//        [self performSelector:@selector(removeSplashView) withObject:nil afterDelay:2.0f];
//
//    }
    
    
   
    

    
    // Register to WeChat   wxd930ea5d5a258f4f
    // aijianmei  :
    
     [WXApi registerApp:WeChatId];
    
    
    
    ///
//    if (![self isPushNotificationEnable]){
//        [self bindDevice];
//    }
    
    //检测当前版本是否为最新的版本
    [self performSelector:@selector(updateApplication) withObject:nil afterDelay:10.0f];

    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]){
         /*如果不是第二次使用*/
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];//设置第二次使用的value值为yes
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];//设置第一次使用的value值为yes
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        
    
//        WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] init];
//        
//        [self.window setRootViewController:welcomeVC];
//        [self showIntroWithCrossDissolve];

        
    }else{
//         MainViewController *mainVC = [[MainViewController alloc] init];
//        
//        [self.window setRootViewController:mainVC];
    }
    

    
    return YES;
}


- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:@"1"];
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.bgImage = [UIImage imageNamed:@"2"];
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:@"3"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.window.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.window animateDuration:0.0];
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
    BOOL success;

    //For weibo HD like ipad
    if ([sourceApplication isEqualToString:@"com.sina.weibohd"] && [url.absoluteString hasPrefix:SinaweibossoLogin]){
    
         success =[[SinaWeiboManager sharedManager].sinaweibo handleOpenURL:url];
        
        return success;
    }
    
    //For weibo like iphone 5
    if ([sourceApplication isEqualToString:@"com.sina.weibo"] && [url.absoluteString hasPrefix:SinaweibossoLogin]){
        
        success =[[SinaWeiboManager sharedManager].sinaweibo handleOpenURL:url];
        
        return success;
    }

    
    if ([sourceApplication isEqualToString:@"com.tencent.xin"] && [url.absoluteString hasSuffix:@"wechat"]){
        
         success = [WXApi handleOpenURL:url delegate:self];
        
        return success;
    }

    return YES;
}


-(void)updateApplication{
   [[UserService defaultService] queryVersion:self];
}







#pragma mark -
#pragma SinaWeiboDelegate methods
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    [[SinaWeiboManager sharedManager] storeAuthData];
    
    //微博登陆后获取用户数据
//    [[UserService defaultService] fetchSinaUserInfo:sinaweibo.userID delegate:self];
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
        [[UserManager defaultManager] storeSinaUserInfo:result];
        
        NSDictionary *userInfo = result;
        NSLog(@"<storeSinaUserInfo>:%@",[[userInfo objectForKey:@"id"] stringValue]);
        [StatusView hideStatusText];
        
    }
    
}


#pragma mark -
#pragma mark - RKObjectLoaderDelegate
-(void)didLoadUpdateVersionInfo:(VersionInfo*)versionInfo errorCode:(int)errorCode
{
    
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
