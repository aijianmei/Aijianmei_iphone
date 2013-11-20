//
//  AGLeftSideViewController.m
//  AGShareSDKDemo
//
//  Created by 冯 鸿杰 on 13-1-30.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import "AJMLeftSideViewController.h"
#import "AGLeftSideTableCell.h"
#import "MyselfViewController.h"
#import "HomeViewController.h"
#import "WorkoutViewController.h"
#import "WorkoutPlanViewController.h"
#import "NutriViewController.h"
#import "SupplementViewController.h"
#import "LifeStytleViewController.h"
#import "MoreViewController.h"
#import "ForumViewController.h"
#import "LifeStytleViewController.h"
#import "MakeFriendsViewController.h"
#import "LoginViewController.h"
#import "SVWebViewController.h"
#import "WorkOutManagerViewController.h"
#import "IIViewDeckController.h"
#import "AppDelegate.h"


#import "SinaWeiboRequest.h"

#import "ColorManager.h"
#import "ImageManager.h"

#import "BaiduMobStat.h"


//239725454
//e2064ac8fab9d889a9eccecc5babad11

//爱健美网
//#define kAppKey @"3622140445"
//#define kAppSecret @"f94d063d06365972215c62acaadf95c3"



//爱健美
#define kAppKey @"239725454"
#define kAppSecret @"e2064ac8fab9d889a9eccecc5babad11"
#define KAppRedirectURI @"http://aijianmei.com"



#define AIJIANMEI_SINAWEIBO_ID @"2692984661"


#define TABLE_CELL @"tableCell"

@interface AJMLeftSideViewController ()

@end

@implementation AJMLeftSideViewController
@synthesize homeViewController =_homeViewController;
@synthesize workoutPlanViewController =_workoutPlanViewController;
@synthesize workoutViewController =_workoutViewController;
@synthesize supplementViewController =_supplementViewController;
@synthesize nutriViewController =_nutriViewController;
@synthesize lifeStytleViewController =_lifeStytleViewController;
@synthesize workOutManagerViewController =_workOutManagerViewController;
@synthesize moreViewController =_moreViewController;
@synthesize webViewController =_webViewController;

- (id)init
{
    self = [super init];
    if (self)
    {
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        // Custom initialization
        _sectionView = [[AGSectionView alloc] initWithFrame:CGRectZero];
        _sectionView.titleLabel.text = @"关注爱健美";
    }
    return self;
}

- (void)dealloc
{

    [_navigationController release];
    [_homeViewController release];
    [_workoutPlanViewController release];
    [_workoutViewController release];
    [_nutriViewController release];
    [_supplementViewController release];
    [_lifeStytleViewController release];
    [_workOutManagerViewController release];
    [_moreViewController release];
    [_webViewController release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [self setHomeViewController:nil];
    [self setWorkoutPlanViewController:nil];
    [self setWorkoutViewController:nil];
    [self setSupplementViewController:nil];
    [self setNutriViewController:nil];
    [self setLifeStytleViewController:nil];
    [self setWorkOutManagerViewController:nil];
    [self setMoreViewController:nil];
    [self setWebViewController:nil];
    [super viewDidUnload];
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    

    typedef enum
    {
        SSRectEdgeNone   = 0,
        SSRectEdgeTop    = 1 << 0,
        SSRectEdgeLeft   = 1 << 1,
        SSRectEdgeBottom = 1 << 2,
        SSRectEdgeRight  = 1 << 3,
        SSRectEdgeAll    = SSRectEdgeTop | SSRectEdgeLeft | SSRectEdgeBottom | SSRectEdgeRight
    }
    SSRectEdge;
    
    
//    if ([[UIDevice currentDevice].systemVersion isEqualToString:@"7.0"]
//        ) {
        [self setExtendedLayoutIncludesOpaqueBars:NO];
        [self setEdgesForExtendedLayout:SSRectEdgeBottom | SSRectEdgeLeft | SSRectEdgeRight];
//    }
    

    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndexBG.png"]];
    bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    bgImageView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)
                                              style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 32;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor ];
    _tableView.backgroundView = nil;
    [self.view addSubview:_tableView];
    [_tableView release];

    
//    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndexBG.png"]];
//    bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    
//    
//    bgImageView.frame = CGRectMake(0.0, 0.0, self.view.frame
//                                   .size.width,     self.view.frame.size.height);
//    [self.view addSubview:bgImageView];
//    [bgImageView release];
//    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width , self.view.frame.size.height)
//                                              style:UITableViewStylePlain];
//    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _tableView.sectionHeaderHeight = 32;
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
//    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.backgroundView = nil;
//    [_tableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
//    [self.view addSubview:_tableView];
//    [_tableView release];
//    
}



#pragma mark --
#pragma mark - initViewControllers
-(void)initHomeViewController
{
    HomeViewController *homeViewVC =[[AppDelegate getAppDelegate] initHomeViewControllerFromAppDelegate];
    _navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewVC];
    
}

-(void)initWorkoutPlanViewController{
    if (self.workoutPlanViewController ==nil) {
        WorkoutPlanViewController *vc =[[WorkoutPlanViewController alloc] initWithNibName:@"WorkoutPlanViewController" bundle:nil];
        self.workoutPlanViewController =vc;
        [vc release];
        self.workoutPlanViewController.title = @"健身计划";
    }
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:_workoutPlanViewController];
}

-(void)initWorkOutViewController{
    
      if (self.workoutViewController ==nil) {

        WorkoutViewController *vc =[[WorkoutViewController alloc] initWithNibName:@"WorkoutViewController" bundle:nil];
        self.workoutViewController =vc;
        [vc release];
        self.workoutViewController.title = @"锻炼";
      }
    
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:_workoutViewController];
}

-(void)initSupplementViewController{
    if (self.supplementViewController ==nil) {

    self.supplementViewController =[[SupplementViewController alloc] initWithNibName:@"SupplementViewController" bundle:nil];
    self.supplementViewController.title = @"补充";
        
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:_supplementViewController] ;
}
-(void)initNutriViewController{
    
    if (self.nutriViewController ==nil) {

    self.nutriViewController =[[NutriViewController alloc] initWithNibName:@"NutriViewController" bundle:nil];
    self.nutriViewController.title = @"营养";
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:_nutriViewController] ;
}

-(void)initLifeStytleViewController{
    
    if (self.lifeStytleViewController ==nil) {
        
        self.lifeStytleViewController =[[LifeStytleViewController alloc] initWithNibName:@"LifeStytleViewController" bundle:nil];
        self.lifeStytleViewController.title = @"生活方式";
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:_lifeStytleViewController] ;
}


-(void)initWorkOutManagerViewController{
    if (self.workOutManagerViewController ==nil) {

    self.workOutManagerViewController =[[WorkOutManagerViewController alloc] initWithNibName:@"WorkOutManagerViewController" bundle:nil];
    self.workOutManagerViewController.title = @"运动管理";
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:_workOutManagerViewController] ;
}
-(void)initMoreController{
    if (self.moreViewController ==nil) {

    self.moreViewController =[[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    self.moreViewController.title = @"更多";
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:_moreViewController] ;
}


-(void)initWebViewController{
    if (self.webViewController ==nil) {
        self.webViewController = [[SVWebViewController alloc] initWithAddress:@"http://aijianmei.com"];
        self.webViewController.title = @"官方网站";
  }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:_webViewController];
}






#pragma mark --
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 8;
        case 1:
            return 2;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_CELL];
    if (cell == nil)
    {
        cell = [[[AGLeftSideTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_CELL] autorelease];
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cell.textLabel.textColor = [ColorManager leftSideNaviFontColor] ;
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IndexLine.png"] stretchableImageWithLeftCapWidth:1
                                                                                                                topCapHeight:1]];
        
        CGRect frame = cell.contentView.frame;
        
        lineView.frame = CGRectMake(0.0, frame.size.height - lineView.frame.size.height , cell.contentView.frame.size.width, lineView.frame.size.height);
        
        lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
          [cell addSubview:lineView];
          [lineView release];
    
    }
    
    
    UIImageView *imvaew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cbdqx_1.png"]];
    [cell setSelectedBackgroundView:imvaew];
    [imvaew release];
    
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"首页";
                    [cell.imageView setImage:[UIImage imageNamed:@"Home_Icon.png"]
                     ];
                    break;                    
                case 1:
                    cell.textLabel.text = @"锻炼";
                    [cell.imageView setImage:[UIImage imageNamed:@"Workout_Icon.png"]];

                    break;
                case 2:
                    cell.textLabel.text = @"健身计划";
                    [cell.imageView setImage:[UIImage imageNamed:@"Plan_Icon.png"]];

                   break;
                case 3:
                    cell.textLabel.text = @"营养";
                    [cell.imageView setImage:[UIImage imageNamed:@"Nuri_Icon.png"]];
                    
                    break;
                case 4:
                    cell.textLabel.text = @"补充";
                    [cell.imageView setImage:[UIImage
                                  imageNamed:@"Supplement_Icon.png"]];
                    break;
                case 5:
                    cell.textLabel.text = @"生活方式";
                    [cell.imageView setImage:[UIImage
                                  imageNamed:@"LifeStyle_Icon.png"]];
                    break;
                case 6:
                    cell.textLabel.text = @"运动管理";
                    [cell.imageView setImage:[UIImage imageNamed:
                                              @"Manager_Icon.png"]];
                    break;
                case 7:
                    cell.textLabel.text = @"更多";
                    [cell.imageView setImage:[UIImage imageNamed:@"More_Icon.png"]];
                    break;
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"关注新浪微博";
                    [cell.imageView setImage:[UIImage imageNamed:
                                              @"Weibo_Icon.png"]];

                    break;
                
                case 1:
                    cell.textLabel.text = @"访问官方网站";
                    [cell.imageView setImage:[UIImage imageNamed:
                                              @"Aijianmei_Icon.png"]];

                    break;
            }
            break;
        }
        default:
            break;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 1:
            return @"关注爱健美";
        default:
            return nil;
    }
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
        {
            return _sectionView;
        }
        case 1:
            return _sectionView;
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 15;
        case 1:
            return tableView.sectionHeaderHeight;
        default:
            return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
    
    }else{
    
    }
    
    
    switch (indexPath.section)
    {
        case 0:
        {
            self.view.userInteractionEnabled = NO;
            switch (indexPath.row)
            {
                case 0:
                {
                    ///首页
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
    
                       [self initHomeViewController];
                       self.viewDeckController.centerController = _navigationController;
                                            }];
                    
                    self.view.userInteractionEnabled = YES;
                    _tableView.userInteractionEnabled =YES;
                    

                    //百度统计;
                    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
                    [statTracker logEvent:@"HomeView" eventLabel:@"HomeView"];
                                        
                }
                break;
                case 1:
                {
                    ///锻炼
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        
                    [self initWorkOutViewController];
                     self.viewDeckController.centerController = _navigationController;
                
                    
                    }];
                    
                    
                    self.view.userInteractionEnabled = YES;
                    _tableView.userInteractionEnabled =YES;
                    
                    //百度统计
                    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
                    [statTracker logEvent:@"WorkOutView" eventLabel:@"WorkOutView"];
                }
                break;

                case 2:
                {
                    ///健身计划
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {

                        [self initWorkoutPlanViewController];
                        self.viewDeckController.centerController = _navigationController;
                        self.view.userInteractionEnabled = YES;
                    }];
                }
                    break;

                case 3:
                {
                    ///营养
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        
                        [self initNutriViewController];
                        self.viewDeckController.centerController = _navigationController;
                        
                        self.view.userInteractionEnabled = YES;
                        
                       
                    }];
                    
                    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
                    [statTracker logEvent:@"NutriView" eventLabel:@"NutriView"];
                }
                    break;
                
                case 4:
                {
                    ///补充
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                    
                        [self initSupplementViewController];
                        self.viewDeckController.centerController = _navigationController;
                        
                        self.view.userInteractionEnabled = YES;
                        
                      
                    }];
                    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
                    [statTracker logEvent:@"SupplementView" eventLabel:@"SupplementView"];
                }
                break;
                case 5:
                {
                    ///生活方式
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        
                        [self initLifeStytleViewController];
                        self.viewDeckController.centerController = _navigationController;
                        
                        self.view.userInteractionEnabled = YES;
                        [_tableView setUserInteractionEnabled:YES];
                        
                    }];
                    
                    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
                    [statTracker logEvent:@"LifeStytleView" eventLabel:@"LifeStytleView"];
                    
                }
                break;

                case 6:
                {
                   ////运动管理
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        
                        [self initWorkOutManagerViewController];
                        self.viewDeckController.centerController = _navigationController;
                    }];
                    
                    self.view.userInteractionEnabled = YES;
                    _tableView.userInteractionEnabled =YES;

                    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
                    [statTracker logEvent:@"WorkoutManagerView" eventLabel:@"WorkoutManagerView"];
                }
                    break;
                case 7:
                {
                    ///更多
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
            
                        [self initMoreController];
                        self.moreViewController.delegate =[AppDelegate getAppDelegate];
                        self.viewDeckController.centerController = _navigationController;
                    }];
                    self.view.userInteractionEnabled = YES;
                    _tableView.userInteractionEnabled =YES;
                    
                    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
                    [statTracker logEvent:@"MoreView" eventLabel:@"MoreView"];
                }
                    break;

                default:
                    break;
            }
            break;
        }
    
    
        case 1:
        {
            /////在第二个section
            switch (indexPath.row)
            {
                case 0:
                {
                ///关注新浪微博
                //TODO
                    
                    _sinaweiboManager = [SinaWeiboManager sharedManager];
                    [_sinaweiboManager createSinaweiboWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:KAppRedirectURI delegate:self];
                    
                    if ([_sinaweiboManager.sinaweibo isAuthValid])
                    {
                        [self createSinaFriendship];
                        PPDebug(@"新浪授权可用");
                    }
                    //授权不可用的时候,就获取新浪微博的id，再通过sns 的id 来获取用户信息；
                    else if(![_sinaweiboManager.sinaweibo isAuthValid])
                    {
                        [_sinaweiboManager.sinaweibo logIn];
                        PPDebug(@"登陆新浪授权页面");

                    }

                    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
                    [statTracker logEvent:@"FollowSina" eventLabel:@"FollowSina"];
                    
                    self.view.userInteractionEnabled = YES;
                    _tableView.userInteractionEnabled =YES;
                    
                }
                break;
                case 1:
                {
                    ///关注爱健美网 www.aijianmei.com
                    //TODO
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        
                        
                        [self initWebViewController];
                         self.viewDeckController.centerController = _navigationController;
                    }];
                    
                    
                    self.view.userInteractionEnabled = YES;
                    _tableView.userInteractionEnabled =YES;
                    
                    
                    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
                    [statTracker logEvent:@"VistWebSite" eventLabel:@"VistWebSite"];
                }
                
                   break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }    
}



#pragma mark -
#pragma SinaWeiboDelegate methods
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    [_sinaweiboManager storeAuthData];
    //微博登陆后获取用户数据
    [[UserService defaultService] fetchSinaUserInfo:sinaweibo.userID delegate:self];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [_sinaweiboManager removeAuthData];
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
    [_sinaweiboManager removeAuthData];
}

#pragma mark - SinaWeiboRequest Delegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{

    //获取用户信息
    if ([request.url hasSuffix:@"users/show.json"])
    {
        NSLog(@"******%@",[error description]);
        [self hideActivity];

    }

    //关注爱健美用户
    if ([request.url hasSuffix:@"friendships/create.json"])
    {
        [self hideActivity];
        NSLog(@"******%@",[error description]);
        if ([error code]==20506) {
            UIAlertView *alerView  = [[UIAlertView alloc]initWithTitle:@"您已关注了 @爱健美网"
                                                               message:@""
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil, nil];
            [alerView show];
        }else{
        
            [self popupUnhappyMessage:@"网络不给力，请稍后再试！" title:nil];
        }
        
    }
    

}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    
    
    //获取用户信息
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [self hideActivity];
        NSLog(@"******%@",[result description]);
        [self createSinaFriendship];
    }
    
    //关注爱健美用户
    if ([request.url hasSuffix:@"friendships/create.json"])
    {
        
        [self hideActivity];
        NSLog(@"******%@",[result description]);
        UIAlertView *alerView  = [[UIAlertView alloc]initWithTitle:@"成功关注了@爱健美网"
                                                           message:@""
                                                          delegate:self
                                                 cancelButtonTitle:@"退出"
                                                 otherButtonTitles:nil, nil];
        [alerView show];
    }

}


-(void)createSinaFriendship{
    
    [self showActivityWithText:@"连接服务器..."];
    PPDebug(@"%@",_sinaweiboManager.sinaweibo.userID);
    [[UserService defaultService] createSinaFriendshipWithUid:AIJIANMEI_SINAWEIBO_ID delegate:self];
}

- (BOOL)shouldAutorotate

{
    
    return NO;
    
}




@end
