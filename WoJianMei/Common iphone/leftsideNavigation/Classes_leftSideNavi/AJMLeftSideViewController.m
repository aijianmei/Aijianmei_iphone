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
#import "WorkoutViewController.h"
#import "WorkoutPlanViewController.h"
#import "NutriViewController.h"
#import "SupplementViewController.h"
#import "MoreViewController.h"
#import "ForumViewController.h"
#import "LifeStytleViewController.h"
#import "MakeFriendsViewController.h"
#import "LoginViewController.h"
#import "SVWebViewController.h"
//#import <ShareSDK/ShareSDK.h>

#import "ColorManager.h"
#import "ImageManager.h"


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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)
                                              style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 32;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
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
            return 5;
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
                    cell.textLabel.text = @"我";
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
                case 1:
                    cell.textLabel.text = @"关注腾讯微博";
                    break;
                case 2:
                    cell.textLabel.text = @"关注官方微信";
                    break;
                case 3:
                    cell.textLabel.text = @"访问官方网站";
                    break;
                case 4:
                {
                    NSBundle *bundle = [NSBundle mainBundle];
                    cell.textLabel.text = [NSString stringWithFormat:@"版本:ver%@",[[bundle infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
                    break;
                }
                default:
                    break;
            }
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
                    
//                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
//                        WorkoutViewController *workOutVC = (WorkoutViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"WorkoutViewController"];
//                        workOutVC.title = @"锻炼";
//                        _navigationController = [[UINavigationController alloc] initWithRootViewController:workOutVC] ;
//                        self.viewDeckController.centerController = _navigationController;
//                        self.view.userInteractionEnabled = YES;
//                        
//                        
//                    }];

                    
                    
                    
                    
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        
                        if (![[UserService defaultService] hasBindAccount]) {
                            LoginViewController *loginViewController = (LoginViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
                            loginViewController.title = @"登陆";
                            self.navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController] ;
                            
                        } else {
                            MyselfViewController *myselfVC = (MyselfViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"MyselfViewController"];
                            myselfVC.title = @"我";
                            self.navigationController = [[UINavigationController alloc] initWithRootViewController:myselfVC];
                        }
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
                        
                       NutriViewController *lifeStytleVC = (NutriViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"NutriViewController"];
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
                    
                    break;

                }
                case 1:
                {
                ///关注腾讯微博
                //TODO
                    break;

                    
                    
                }
                case 2:
                {
                ///关注微信
                //TODO
                    break;

                }
                case 3:
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
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}

@end
