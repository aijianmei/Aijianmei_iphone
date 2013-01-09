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

@interface MoreViewController : PPTableViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UserServiceDelegate>

{
 
    NSArray *_listData;
    int whichAcctionSheet;


}

@property (nonatomic, retain) NSArray *listData;

- (IBAction)sinaWeiBlogshareButton:(id)sender;

-(void)showShare;


@end
