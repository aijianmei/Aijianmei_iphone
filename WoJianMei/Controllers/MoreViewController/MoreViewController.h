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


#import "WXApiObject.h"

@protocol sendMsgToWeChatViewDelegate <NSObject>
- (void) sendTextContent:(NSString*)nsText;
- (void) sendAppContent;
- (void) sendImageContent;
@end



@class AppDelegate;

@interface MoreViewController : PPTableViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UserServiceDelegate>

{
 
    NSArray *_listData;
    int whichAcctionSheet;
    
    
    AppDelegate *_appDelegate;
}

@property (nonatomic, retain) NSArray *listData;
@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;


- (void)initMoreUI;
- (void)leftButtonClickHandler:(id)sender;
- (void)rightButtonClickHandler:(id)sender;


@end
