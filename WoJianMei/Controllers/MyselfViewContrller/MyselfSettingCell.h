//
//  MyselfSettingCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/11/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewCell.h"

@interface MyselfSettingCell : PPTableViewCell<UITextFieldDelegate>
{
    UILabel *_detailLabelView;
    UIImageView *_detailImageView;
    UITextField *_textField;
    
    UIButton *_moreButton;
    UIButton *_lessButton;

    
}

@property (nonatomic,retain) UILabel     *detailLabelView;
@property (nonatomic,retain) UIImageView *detailImageView;
@property (nonatomic,retain) UITextField *textField;
@property (nonatomic,retain) UIButton    *moreButton;
@property (nonatomic,retain) UIButton    *lessButton;




@end
