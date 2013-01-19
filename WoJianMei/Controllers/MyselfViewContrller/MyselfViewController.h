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


#import "SinaweiboManager.h" // tencent  sina
#import "TCWBEngine.h"   /// tencent weibo
#import "TencentOAuth.h"   // tencent qq
#import "User.h"


@class TencentOAuthManager;
@class TCWBEngine;
@class SinaweiboManager;


@class User;


@interface MyselfViewController : PPTableViewController<UITableViewDataSource,UITableViewDelegate,MyselfTableViewCellDelegate,UINavigationControllerDelegate,SinaWeiboDelegate,SinaWeiboRequestDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,TencentSessionDelegate,UIActionSheetDelegate>

{
    
    UIButton                *_headerVImageButton;
    UIView                        *_myHeaderView;
	 UIView                        *myFooterView;
    UILabel                      *_userNameLabel;
    UILabel                         *_mottoLabel;
    UILabel                    *_userGenderLabel;
    UISwitch                    *_sinaModeSwitch;
    UISwitch            *_tenCentWeiboModeSwitch;
    UISwitch               *_tenCentQQModeSwitch;
    
    SinaweiboManager           *sinaweiboManager; //sina
    TencentOAuthManager        *tencentQQManager;//qq
    TCWBEngine              *tencentWeiboManager; //weibo

    
    NSDictionary                 *_sina_userInfo;
    NSDictionary                      *user_info;

    User                                  *_user;
}


@property (nonatomic,retain) UISwitch         *sinaModeSwitch;
@property (nonatomic,retain) UISwitch    *tenCentQQModeSwitch;
@property (nonatomic,retain) UISwitch *tenCentWeiboModeSwitch;
@property (nonatomic,retain) UIButton     *headerVImageButton;
@property (nonatomic,retain) UIImageView       *footerVImageV;
@property (nonatomic,retain) UIView             *myHeaderView;
@property (nonatomic,retain) UILabel           *userNameLabel;
@property (nonatomic,retain) UILabel              *mottoLabel;
@property (nonatomic,retain) UILabel         *userGenderLabel;
@property (nonatomic,retain) NSDictionary      *sina_userInfo;
@property (nonatomic,retain) User                       *user;

@end
