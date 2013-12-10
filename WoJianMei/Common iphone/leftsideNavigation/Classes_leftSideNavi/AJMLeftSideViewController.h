//
//  AGLeftSideViewController.h
//  AGShareSDKDemo
//
//  Created by 冯 鸿杰 on 13-1-30.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGSectionView.h"
#import "SinaWeiboRequest.h"
#import "SinaWeiboManager.h"
#import "PPViewController.h"

@class AppDelegate;

@class HomeViewController;
@class FitnessInfoViewController;
@class WorkoutPlanViewController;
@class WorkoutViewController;
@class SupplementViewController;
@class NutriViewController;
@class LifeStytleViewController;


@class WorkOutManagerViewController;
@class MoreViewController;
@class SVWebViewController;

@interface AJMLeftSideViewController : PPViewController <UITableViewDataSource,
                                                        UITableViewDelegate,SinaWeiboRequestDelegate,SinaWeiboDelegate,UIAlertViewDelegate>
{
    SinaWeiboManager *_sinaweiboManager;
@private
    UITableView *_tableView;
    AGSectionView *_sectionView;
    AppDelegate *_appDelegate;
    
    HomeViewController            *_homeViewController;
    FitnessInfoViewController     *_fitnessInfoViewController;
    WorkoutPlanViewController     *_workoutPlanViewController;
    WorkoutViewController         *_workoutViewController;
    SupplementViewController      *_supplementViewController;
    NutriViewController           *_nutriViewController;
    LifeStytleViewController      *_lifeStytleViewController;
    WorkOutManagerViewController  *_workOutManagerViewController;
    MoreViewController            *_moreViewController;
    SVWebViewController           *_webViewController;
}

@property(nonatomic, retain) UINavigationController           *navigationController;
@property(nonatomic, retain) HomeViewController               *homeViewController;
@property(nonatomic, retain) FitnessInfoViewController        *fitnessInfoViewController;
@property(nonatomic, retain) WorkoutPlanViewController        *workoutPlanViewController;
@property(nonatomic, retain) WorkoutViewController            *workoutViewController;
@property(nonatomic, retain) SupplementViewController         *supplementViewController;
@property(nonatomic, retain) NutriViewController              *nutriViewController;
@property(nonatomic, retain) LifeStytleViewController         *lifeStytleViewController;
@property(nonatomic, retain) WorkOutManagerViewController     *workOutManagerViewController;
@property(nonatomic, retain) MoreViewController               *moreViewController;
@property (nonatomic,retain)SVWebViewController               *webViewController;



@end
