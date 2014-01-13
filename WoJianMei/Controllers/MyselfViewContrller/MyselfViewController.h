//
//  MyselfViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import <UIKit/UIKit.h>
#import "StatusCell.h"
#import "User.h"
#import "UserService.h"
#import "PostService.h"
#import "MyselfViewBaseController.h"

@class User;
@class PostViewController;
@class Myself_SettingsViewController;

@interface MyselfViewController : MyselfViewBaseController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate,PostStatusServiceDelegate,UserServiceDelegate>

{
    
    UIButton *_headerVImageButton;
    UIImageView *_backGroundImageView;
    UIView *_myHeaderView;
    UIView *myFooterView;
    UILabel *_userNameLabel;
    UILabel *_descriptionLabel;
    NSDictionary *_sina_userInfo;
    NSDictionary *user_info;
    User *_user;
    UserService *_userService;
    PostViewController *_postViewController;
    
    Myself_SettingsViewController *_settingViewController;
    
    NSString   *_targetUid;
    
}


@property (nonatomic,retain) UIButton *headerVImageButton;
@property (nonatomic,retain) UIImageView *backGroundImageView;
@property (nonatomic,retain) UIImageView *avatarImageView;
@property (nonatomic,retain) UIImageView *footerVImageV;
@property (nonatomic,retain) UIView *myHeaderView;
@property (nonatomic,retain) UILabel *userNameLabel;
@property (nonatomic,retain) UILabel *descriptionLabel;
@property (nonatomic,retain) NSDictionary *sina_userInfo;
@property (nonatomic,retain) User *user;
@property (nonatomic,retain) PostViewController *postViewController;
@property (assign, nonatomic) NSInteger start;
@property (retain,nonatomic)  NSString *targetUid;
@property (nonatomic,retain) Myself_SettingsViewController *settingViewController;

@end
