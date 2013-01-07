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

@class TencentWeiboManager;

@interface MyselfViewController : PPTableViewController<UITableViewDataSource,UITableViewDelegate,MyselfTableViewCellDelegate,UINavigationControllerDelegate,SinaWeiboDelegate,SinaWeiboAuthorizeViewDelegate,SinaWeiboRequestDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,TencentSessionDelegate>

{


    
    BOOL                  shouldShowIndicator;
    BOOL                           shouldLoad;
    BOOL                     shouldLoadAvatar;
    
    UIButton                *_headerVImageButton;
    UIImageView                *_footerVImageV;
    UIImage                     *_avatarImage;
    
    UIView                      *myHeaderView;
	UIView                      *myFooterView;
    
    UILabel                    *_userNameLabel;
    UILabel                    *_mottoLabel;
    
    UISwitch  *_sinaModeSwitch;
    UISwitch *_tenCentWeiboModeSwitch;
    UISwitch *_tenCentQQModeSwitch;
    
    
    SinaweiboManager     *sinaweiboManager ;
    TencentWeiboManager *tencentWeiboManager;
    
    
    NSDictionary *userInfo;



}


@property (nonatomic, retain) UISwitch *sinaModeSwitch;
@property (nonatomic, retain) UISwitch *tenCentQQModeSwitch;
@property (nonatomic, retain) UISwitch *tenCentWeiboModeSwitch;




@property (retain, nonatomic) UIButton *headerVImageButton;
@property (retain, nonatomic) UIImageView *footerVImageV;

@property (nonatomic, retain) UIImage                     *avatarImage;
@property (nonatomic,retain)  NSString                         *userID;
@property (nonatomic, retain)   NSMutableArray             *statuesArr;
@property (nonatomic, retain)   NSMutableDictionary    *imageDictionary;

@property (nonatomic, retain)  UIView *myHeaderView;
@property (nonatomic, retain)  UIView *myFooterView;
@property (nonatomic, retain)  UILabel *userNameLabel;
@property (nonatomic, retain)  UILabel *mottoLabel;







- (SinaweiboManager *)sinaweiboManager;
- (TencentWeiboManager*)tengxunWeiboManager;


@end
