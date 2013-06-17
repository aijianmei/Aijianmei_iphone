//
//  MyselfHeaderView.h
//  WoJianMei
//
//  Created by Tom Callon  on 6/17/13.
//
//

#import <UIKit/UIKit.h>

@interface MyselfHeaderView : UIView

{
@private
    UILabel    *_titleLabel;
    UIButton   *_headerVImageButton;
    UILabel    *_userNameLabel;
    UILabel    *_descriptionLabel;
    UIImageView *_userBackGroundImageView;

}

@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UIButton *headerVImageButton;
@property (nonatomic,retain) UILabel *userNameLabel;
@property (nonatomic,retain) UILabel *descriptionLabel;
@property (nonatomic,retain) UIImageView *userBackGroundImageView;



@end
