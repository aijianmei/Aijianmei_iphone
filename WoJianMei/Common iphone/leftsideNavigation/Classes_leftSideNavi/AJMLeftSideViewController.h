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

@class AppDelegate;

@interface AJMLeftSideViewController : UIViewController <UITableViewDataSource,
                                                        UITableViewDelegate,SinaWeiboRequestDelegate,SinaWeiboDelegate,UIAlertViewDelegate>
{
    SinaWeiboManager *_sinaweiboManager;
@private
    UITableView *_tableView;
    AGSectionView *_sectionView;
    AppDelegate *_appDelegate;
}

@property(nonatomic, retain)UINavigationController *navigationController;


-(AppDelegate*)getAppDelegate;

@end
