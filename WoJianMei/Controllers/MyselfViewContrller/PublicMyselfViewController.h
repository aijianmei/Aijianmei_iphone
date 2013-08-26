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
#import "StatusViewBaseController.h"

@class User;
@class PostViewController;
@class MyselfViewController;


@interface PublicMyselfViewController : StatusViewBaseController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

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
    
    MyselfViewController *_myselfViewController;
    
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
@property (nonatomic,retain) MyselfViewController *myselfViewController;




-(PostViewController *)initPostViewController;





@end
