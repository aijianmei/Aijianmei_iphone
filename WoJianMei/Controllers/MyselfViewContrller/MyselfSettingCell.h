//
//  MyselfSettingCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/11/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewCell.h"

@protocol MyselfSettingCellDelegate <NSObject>

- (void)didClickAddMoreButton:(id)sender atIndex:(NSIndexPath*)indexPath;
- (void)didClickLessButton:(id)sender atIndex:(NSIndexPath*)indexPath;

@end


@interface MyselfSettingCell : PPTableViewCell<UITextFieldDelegate>
{
    UILabel *_detailLabelView;
    UIImageView *_detailImageView;
    UITextField *_textField;
    
    UIButton *_moreButton;
    UIButton *_lessButton;
    
    id <MyselfSettingCellDelegate> newdelegate;

    
}

@property (nonatomic,retain) UILabel     *detailLabelView;
@property (nonatomic,retain) UIImageView *detailImageView;
@property (nonatomic,retain) UITextField *textField;
@property (nonatomic,retain) UIButton    *moreButton;
@property (nonatomic,retain) UIButton    *lessButton;
@property (nonatomic,assign) id<MyselfSettingCellDelegate>newdelegate;





@end
