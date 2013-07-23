//
//  AGLeftSideViewController.m
//  AGShareSDKDemo
//
//  Created by 冯 鸿杰 on 13-1-30.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import "AJMLeftSideViewController.h"
#import "AppDelegate.h"
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
//#import <ShareSDK/ShareSDK.h>

#import "SinaWeiboRequest.h"

#import "ColorManager.h"
#import "ImageManager.h"

#define kAppKey @"3622140445"
#define kAppSecret @"f94d063d06365972215c62acaadf95c3"
#define KAppRedirectURI @"http://aijianmei.com"

#define AIJIANMEI_SINAWEIBO_ID @"2692984661"


#define TABLE_CELL @"tableCell"

@interface AJMLeftSideViewController ()

@end

@implementation AJMLeftSideViewController

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
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndexBG.png"]];
    bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
    bgImageView.frame = CGRectMake(0.0, 0.0, self.view.frame
                                   .size.width,     self.view.frame.size.height);
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width , self.view.frame.size.height)
                                              style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 32;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    [_tableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    [self.view addSubview:_tableView];
    [_tableView release];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 9;
        case 1:
            return 3;
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
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
//       cell.textLabel.textColor = [UIColor colorWithRGB:0xc3c3c2];
        
//        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textColor = [ColorManager leftSideNaviFontColor] ;

        
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IndexLine.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        
        CGRect frame = cell.contentView.frame;
        
        lineView.frame = CGRectMake(0.0, frame.size.height - lineView.frame.size.height , cell.contentView.frame.size.width, lineView.frame.size.height);
        
        lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [cell addSubview:lineView];
        [lineView release];
    }
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"首页";
                    break;                    
                case 1:
                    cell.textLabel.text = @"锻炼";
                    break;
                case 2:
                    cell.textLabel.text = @"健身计划";
                    break;
                case 3:
                    cell.textLabel.text = @"营养";
                    break;
                case 4:
                    cell.textLabel.text = @"补充";
                    break;
                case 5:
                    cell.textLabel.text = @"生活方式";
                    break;
                case 6:
                    cell.textLabel.text = @"论坛";
                    break;
                case 7:
                    cell.textLabel.text = @"交友互动";
                    break;
                case 8:
                    cell.textLabel.text = @"更多";                
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
                    break;
//                case 1:
//                    cell.textLabel.text = @"关注腾讯微博";
//                    break;
                case 1:
                    cell.textLabel.text = @"关注官方微信";
                    break;
                case 2:
                    cell.textLabel.text = @"访问官方网站";
                    break;
//                case 3:
//                {
//                    NSBundle *bundle = [NSBundle mainBundle];
//                    cell.textLabel.text = [NSString stringWithFormat:@"版本:ver%@",[[bundle infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
//                    break;
//                }
                default:
                    break;
            }
        }
        default:
            break;
    }
    
    [cell.textLabel setTextColor:[UIColor grayColor]];

    
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
        case 1:
            return tableView.sectionHeaderHeight;
        default:
            return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    UIStoryboard *currentInUseStoryBoard ;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIStoryboard * iPhoneStroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        
        currentInUseStoryBoard = iPhoneStroyBoard;
    
    }else{
    
       UIStoryboard * iPadStroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        currentInUseStoryBoard = iPadStroyBoard;

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
                        HomeViewController *homeVC = (HomeViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                        homeVC.title = @"首页";
                        _navigationController = [[UINavigationController alloc] initWithRootViewController:homeVC] ;
                        self.viewDeckController.centerController = _navigationController;
                        self.view.userInteractionEnabled = YES;
                        
                        
                    }];
                 break;
                }

                case 1:
                {
                    ///锻炼
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                                        WorkoutViewController *workOutVC = (WorkoutViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"WorkoutViewController"];
                        workOutVC.title = @"锻炼";
                        _navigationController = [[UINavigationController alloc] initWithRootViewController:workOutVC] ;
                        self.viewDeckController.centerController = _navigationController;
                        self.view.userInteractionEnabled = YES;

                        
                    }];
                    break;
                }
                case 2:
                {
                    ///健身计划
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        WorkoutPlanViewController *WorkoutPlanVC = (WorkoutPlanViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"WorkoutPlanViewController"];
                        WorkoutPlanVC.title = @"健身计划";
                        _navigationController = [[UINavigationController alloc] initWithRootViewController:WorkoutPlanVC];
                        self.viewDeckController.centerController = _navigationController;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }

                case 3:
                {
                    ///营养
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        NutriViewController *nutriVC = (NutriViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"NutriViewController"];
                        nutriVC.title = @"营养";
                        _navigationController = [[UINavigationController alloc] initWithRootViewController:nutriVC];
                        self.viewDeckController.centerController = _navigationController;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 4:
                {
                    ///补充
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        
                        SupplementViewController *supplementVC = (SupplementViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"SupplementViewController"];
                        supplementVC.title = @"补充";
                        _navigationController = [[UINavigationController alloc] initWithRootViewController:supplementVC];
                        self.viewDeckController.centerController = _navigationController;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 5:
                {
                    ///生活方式
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        
                       LifeStytleViewController *lifeStytleVC = (LifeStytleViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"LifeStytleViewController"];
                        lifeStytleVC.title = @"生活方式";
                        _navigationController = [[UINavigationController alloc] initWithRootViewController:lifeStytleVC];
                        self.viewDeckController.centerController = _navigationController;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 6:
                {
                   ////论坛
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        ForumViewController *forumVC = [currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"ForumViewController"];
                        forumVC.title = @"论坛";

                        _navigationController = [[UINavigationController alloc] initWithRootViewController:forumVC];
                        self.viewDeckController.centerController = _navigationController;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 7:
                {
                    ////交友互动
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        MakeFriendsViewController *mfVC = [currentInUseStoryBoard  instantiateViewControllerWithIdentifier:@"MakeFriendsViewController"];
                        mfVC.title = @"交友互动";
                        _navigationController = [[UINavigationController alloc] initWithRootViewController:mfVC];
                        self.viewDeckController.centerController = _navigationController;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 8:
                {
                    ///更多
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        MoreViewController *moreVC = [currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"MoreViewController"];
                        [moreVC setTitle:@"更多"];
                        _navigationController = [[UINavigationController alloc] initWithRootViewController:moreVC];
                        
                        self.viewDeckController.centerController = _navigationController;
                        
                        self.view.userInteractionEnabled = YES;
                        _tableView.userInteractionEnabled =YES;
                        
                    }];
                    break;
                }
                    
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
                        PPDebug(@"%@",_sinaweiboManager.sinaweibo.userID);
                        [[UserService defaultService] createSinaFriendshipWithUid:AIJIANMEI_SINAWEIBO_ID delegate:self];
                        PPDebug(@"新浪授权可用");

                    }
                    //授权不可用的时候,就获取新浪微博的id，再通过sns 的id 来获取用户信息；
                    else if(![_sinaweiboManager.sinaweibo isAuthValid])
                    {
                        [_sinaweiboManager.sinaweibo logIn];
                        PPDebug(@"登陆新浪授权页面");

                    }


                }
                    break;
//                case 1:
//                {
//                ///关注腾讯微博
//                //TODO


//                }
                    
                   break;
                case 1:
                {
                ///关注微信
                //TODO
                    break;

                }
                case 2:
                {
                    ///关注爱健美网 www.aijianmei.com
                    //TODO
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        SVWebViewController *vc = [[SVWebViewController alloc] initWithAddress:@"http://aijianmei.com"];
                        vc.title = @"官方网站";
                        UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:vc] autorelease];
                        [vc release];
                        self.viewDeckController.centerController = navController;
                    }];
                    break;
                }
                

                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
     //Set the Image of the cell when you click
//    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
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
    }
    //上传图片
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        NSLog(@"******%@",[error description]);
    }
    //关注爱健美用户
    if ([request.url hasSuffix:@"friendships/create.json"])
    {
        NSLog(@"******%@",[error description]);
        if ([error code]==20506) {
            UIAlertView *alerView  = [[UIAlertView alloc]initWithTitle:@"您已关注了 @爱健美网"
                                                               message:@""
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil, nil];
            [alerView show];
        }
    }
    

}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    
    //获取用户信息
    if ([request.url hasSuffix:@"users/show.json"])
    {
        NSLog(@"******%@",[result description]);
    }
    

    //上传图片
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        [[UserService defaultService] storeSinaUserInfo:result];
        
        NSDictionary *userInfo = result;
        NSLog(@"<storeSinaUserInfo>:%@",[[userInfo objectForKey:@"id"] stringValue]);
       
    }
    
    //关注爱健美用户
    if ([request.url hasSuffix:@"friendships/create.json"])
    {
        NSLog(@"******%@",[result description]);
        UIAlertView *alerView  = [[UIAlertView alloc]initWithTitle:@"成功关注了@爱健美网"
                                                           message:@""
                                                          delegate:self
                                                 cancelButtonTitle:@"退出"
                                                 otherButtonTitles:nil, nil];
        [alerView show];
    }

}





@end
