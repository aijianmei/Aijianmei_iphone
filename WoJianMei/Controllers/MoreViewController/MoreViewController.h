//
//  MoreViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/14/12.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "UserService.h"
#import "AWActionSheet.h"


@interface MoreViewController : PPTableViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UserServiceDelegate>

{
 
    NSArray *_listData;
    int whichAcctionSheet;


}

@property (nonatomic, retain) NSArray *listData;

@end
