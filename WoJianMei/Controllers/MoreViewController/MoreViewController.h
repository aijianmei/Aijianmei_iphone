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
#import "CommonDialog.h"

@protocol sendMsgToWeChatViewDelegate <NSObject>
- (void) sendTextContent:(NSString*)nsText;
- (void) sendAppContentWithTitle:(NSString*)title  description:(NSString *)descriptoin image:(UIImage *)image urlLink :(NSString*)urlLink;
- (void) sendImageContent;
- (void) sendNewsContent ;
- (void) doAuth;
- (void) changeScene:(NSInteger)scene;

@end



@interface MoreViewController : PPTableViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,CommonDialogDelegate,UserServiceDelegate>

{
 
    NSArray *_listData;
    int whichAcctionSheet;
    
    SinaWeiboManager *_sinaweiboManager;
    
    UIImage *postImage;
    
    NSString *_uid;

    
}

@property (nonatomic, retain) NSArray *listData;
@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;
@property (nonatomic,retain) NSString *uid;


- (void)initMoreUI;
- (void)leftButtonClickHandler:(id)sender;
- (void)rightButtonClickHandler:(id)sender;
-(void)clickSinaShareButton;


@end
