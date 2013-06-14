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
#import "User.h"


@class User;


@interface MyselfViewController : PPTableViewController<UITableViewDataSource,UITableViewDelegate,MyselfTableViewCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

{
    
    UIButton                *_headerVImageButton;
    UIView                        *_myHeaderView;
	 UIView                        *myFooterView;
    UILabel                      *_userNameLabel;
    UILabel                         *_mottoLabel;
    UILabel                    *_userGenderLabel;
    
      
    NSDictionary                 *_sina_userInfo;
    NSDictionary                      *user_info;

    User                                  *_user;
}


@property (nonatomic,retain) UIButton     *headerVImageButton;
@property (nonatomic,retain) UIImageView       *footerVImageV;
@property (nonatomic,retain) UIView             *myHeaderView;
@property (nonatomic,retain) UILabel           *userNameLabel;
@property (nonatomic,retain) UILabel              *mottoLabel;
@property (nonatomic,retain) UILabel         *userGenderLabel;
@property (nonatomic,retain) NSDictionary      *sina_userInfo;
@property (nonatomic,retain) User                       *user;
- (void)drawRect:(CGRect)rect;


@end
