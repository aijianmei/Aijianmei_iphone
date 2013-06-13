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
#import "WorkoutViewController.h"
#import "WorkoutPlanViewController.h"
#import "NutriViewController.h"
#import "SupplementViewController.h"
#import "MoreViewController.h"
#import "ForumViewController.h"
#import "LifeStytleViewController.h"
#import "MakeFriendsViewController.h"


#import "SVWebViewController.h"

#import <ShareSDK/ShareSDK.h>





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
        _sectionView.titleLabel.text = @"更多";
    }
    return self;
}

- (void)dealloc
{

    
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
            return 8;
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
        
        cell.textLabel.textColor = [UIColor whiteColor];

        
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
                    cell.textLabel.text = @"锻炼";
                    break;
                case 1:
                    cell.textLabel.text = @"健身计划";
                    break;
                case 2:
                    cell.textLabel.text = @"营养";
                    break;
                case 3:
                    cell.textLabel.text = @"补充";
                    break;
                case 4:
                    cell.textLabel.text = @"生活方式";
                    break;
                case 5:
                    cell.textLabel.text = @"论坛";
                    break;
                case 6:
                    cell.textLabel.text = @"交友互动";
                    break;
                case 7:
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
            return @"关注我们";
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
    
    UIStoryboard * stroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    switch (indexPath.section)
    {
        case 0:
        {
            self.view.userInteractionEnabled = NO;
            switch (indexPath.row)
            {
                case 0:
                {
                    ///锻炼
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                                        WorkoutViewController *workOutVC = (WorkoutViewController *)[stroyBoard instantiateViewControllerWithIdentifier:@"WorkoutViewController"];
                        workOutVC.title = @"锻炼";
                        UINavigationController *navApiVC = [[[UINavigationController alloc] initWithRootViewController:workOutVC] autorelease] ;
                        self.viewDeckController.centerController = navApiVC;
                        self.view.userInteractionEnabled = YES;
                        
                    }];
                    break;
                }
                case 1:
                {
                    ///健身计划
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        WorkoutPlanViewController *WorkoutPlanVC = (WorkoutPlanViewController *)[stroyBoard instantiateViewControllerWithIdentifier:@"WorkoutPlanViewController"];
                        WorkoutPlanVC.title = @"健身计划";
                        UINavigationController *navAuthVC = [[[UINavigationController alloc] initWithRootViewController:WorkoutPlanVC] autorelease];
                        self.viewDeckController.centerController = navAuthVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }

                case 2:
                {
                    ///营养
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        NutriViewController *nutriVC = (NutriViewController *)[stroyBoard instantiateViewControllerWithIdentifier:@"NutriViewController"];
                        nutriVC.title = @"营养";
                        UINavigationController *navAuthVC = [[[UINavigationController alloc] initWithRootViewController:nutriVC] autorelease];
                        self.viewDeckController.centerController = navAuthVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 3:
                {
                    ///补充
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        
                        SupplementViewController *supplementVC = (SupplementViewController *)[stroyBoard instantiateViewControllerWithIdentifier:@"SupplementViewController"];
                        supplementVC.title = @"补充";
                        UINavigationController *navAuthVC = [[[UINavigationController alloc] initWithRootViewController:supplementVC] autorelease];
                        self.viewDeckController.centerController = navAuthVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 4:
                {
                    ///生活方式
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        
                       NutriViewController *lifeStytleVC = (NutriViewController *)[stroyBoard instantiateViewControllerWithIdentifier:@"NutriViewController"];
                        lifeStytleVC.title = @"生活方式";
                        UINavigationController *navQQVC = [[[UINavigationController alloc] initWithRootViewController:lifeStytleVC] autorelease];
                        self.viewDeckController.centerController = navQQVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 5:
                {
                   ////论坛
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        ForumViewController *forumVC = [stroyBoard instantiateViewControllerWithIdentifier:@"ForumViewController"];
                        forumVC.title = @"论坛";

                        UINavigationController *navShareVC = [[[UINavigationController alloc] initWithRootViewController:forumVC] autorelease];
                        self.viewDeckController.centerController = navShareVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 6:
                {
                    ////交友互动
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        MakeFriendsViewController *mfVC = [stroyBoard  instantiateViewControllerWithIdentifier:@"MakeFriendsViewController"];
                        mfVC.title = @"交友互动";
                        UINavigationController *navShareVC = [[[UINavigationController alloc] initWithRootViewController:mfVC] autorelease];
                        self.viewDeckController.centerController = navShareVC;
                        
                        self.view.userInteractionEnabled = YES;
                    }];
                    break;
                }
                case 7:
                {
                    ///更多
                    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
                        MoreViewController *moreVC = [stroyBoard instantiateViewControllerWithIdentifier:@"MoreViewController"];
                        [moreVC setTitle:@"更多"];
                        UINavigationController *navShareVC = [[[UINavigationController alloc] initWithRootViewController:moreVC] autorelease];
                        
                        self.viewDeckController.centerController = navShareVC;
                        
                        self.view.userInteractionEnabled = YES;
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
            id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                                 allowCallback:YES
                                                                 authViewStyle:SSAuthViewStyleFullScreenPopup
                                                                  viewDelegate:nil
                                                       authManagerViewDelegate:_appDelegate.viewDelegate];
            
            //在授权页面中添加关注官方微博
            [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [ShareSDK userFieldWithType:SSUserFieldTypeName valeu:@"ShareSDK"],
                                            SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                            [ShareSDK userFieldWithType:SSUserFieldTypeName valeu:@"ShareSDK"],
                                            SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                            nil]];
            
            switch (indexPath.row)
            {
                case 0:
                {
                    [ShareSDK followUserWithType:ShareTypeSinaWeibo
                                           field:@"ShareSDK"
                                       fieldType:SSUserFieldTypeName
                                     authOptions:authOptions
                                    viewDelegate:_appDelegate.viewDelegate
                                          result:^(SSResponseState state, id<ISSUserInfo> userInfo, id<ICMErrorInfo> error) {
                                              NSString *msg = nil;
                                              if (state == SSResponseStateSuccess)
                                              {
                                                  msg = @"关注成功";
                                              }
                                              else if (state == SSResponseStateFail)
                                              {
                                                  switch ([error errorCode])
                                                  {
                                                      case 20506:
                                                          msg = @"已关注";
                                                          break;
                                                          
                                                      default:
                                                          msg = [NSString stringWithFormat:@"关注失败:%@", error.errorDescription];
                                                          break;
                                                  }
                                              }
                                              
                                              if (msg)
                                              {
                                                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                                                      message:msg
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:@"知道了"
                                                                                            otherButtonTitles:nil];
                                                  [alertView show];
                                                  [alertView release];
                                              }
                                          }];
                    break;
                }
                case 1:
                {
                    [ShareSDK followUserWithType:ShareTypeTencentWeibo
                                           field:@"ShareSDK"
                                       fieldType:SSUserFieldTypeName
                                     authOptions:authOptions
                                    viewDelegate:_appDelegate.viewDelegate
                                          result:^(SSResponseState state, id<ISSUserInfo> userInfo, id<ICMErrorInfo> error) {
                                              NSString *msg = nil;
                                              if (state == SSResponseStateSuccess)
                                              {
                                                  msg = @"关注成功";
                                              }
                                              else if (state == SSResponseStateFail)
                                              {
                                                  switch ([error errorCode])
                                                  {
                                                      case 80103:
                                                          msg = @"已关注";
                                                          break;
                    
                                                      default:
                                                          msg = [NSString stringWithFormat:@"关注失败:%@", error.errorDescription];
                                                          break;
                                                  }
                                              }
                                              
                                              if (msg)
                                              {
                                                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                                                      message:msg
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:@"知道了"
                                                                                            otherButtonTitles:nil];
                                                  [alertView show];
                                                  [alertView release];
                                              }
                                          }];
                    break;
                }
                case 2:
                {
                   [ShareSDK followWeixinUser:@"http://weixin.qq.com/r/HHURHl7EjmDxh099nyA4"];
                    break;
                }
                case 3:
                {
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
}

@end
