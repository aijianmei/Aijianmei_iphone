//
//  MakeFriendsViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/29/12.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"

@class AppDelegate;

@interface MakeFriendsViewController : PPTableViewController
{
    AppDelegate *_appDelegate;

}


- (void)initMoreUI;
- (void)leftButtonClickHandler:(id)sender;
- (void)rightButtonClickHandler:(id)sender;
@end
