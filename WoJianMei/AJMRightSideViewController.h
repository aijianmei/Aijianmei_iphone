//
//  AJMRightSideViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 6/17/13.
//
//

#import "PPViewController.h"
#import <UIKit/UIKit.h>
#import "MyselfHeaderView.h"

@class AppDelegate;

@interface AJMRightSideViewController : PPViewController <UITableViewDataSource,
UITableViewDelegate>
{
@private
    UITableView *_tableView;
    MyselfHeaderView *_myselfHeaderView;
    AppDelegate *_appDelegate;
}

@property(nonatomic, retain)UINavigationController *navigationController;

@end
