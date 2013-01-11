//
//  MyselfViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "MyselfTableViewCell.h"


#import "SinaweiboManager.h"
#import "TencentWeiboManager.h"

#import "TencentOAuth.h"
#import "User.h"

@class TencentWeiboManager;
@class User;

@interface MyselfViewController : PPTableViewController<UITableViewDataSource,UITableViewDelegate,MyselfTableViewCellDelegate,UINavigationControllerDelegate,SinaWeiboDelegate,SinaWeiboAuthorizeViewDelegate,SinaWeiboRequestDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,TencentSessionDelegate>

{
    
    UIButton                *_headerVImageButton;
    
    UIView                      *_myHeaderView;
	UIView                      *myFooterView;
    
    UILabel                    *_userNameLabel;
    UILabel                    *_mottoLabel;
    UILabel                   *_userGenderLabel;
    
    UISwitch  *_sinaModeSwitch;
    UISwitch *_tenCentWeiboModeSwitch;
    UISwitch *_tenCentQQModeSwitch;
    
    
    SinaweiboManager     *sinaweiboManager ;
    TencentWeiboManager *tencentWeiboManager;
    
    
    NSDictionary *sina_userInfo;
    NSDictionary *user_info;
    
    
    
    User *_user;
}


@property (nonatomic, retain) UISwitch *sinaModeSwitch;
@property (nonatomic, retain) UISwitch *tenCentQQModeSwitch;
@property (nonatomic, retain) UISwitch *tenCentWeiboModeSwitch;




@property (retain, nonatomic) UIButton *headerVImageButton;
@property (retain, nonatomic) UIImageView *footerVImageV;

@property (nonatomic,retain)  NSString                         *userID;
@property (nonatomic, retain)   NSMutableArray             *statuesArr;
@property (nonatomic, retain)   NSMutableDictionary    *imageDictionary;

@property (nonatomic, retain)  UIView *myHeaderView;
@property (nonatomic, retain)  UILabel *userNameLabel;
@property (nonatomic, retain)  UILabel *mottoLabel;
@property (nonatomic, retain)  UILabel *userGenderLabel;



@property (nonatomic, retain) NSMutableArray *urlArray;

@property (nonatomic,retain) User *user;








- (SinaweiboManager *)sinaweiboManager;


@end
