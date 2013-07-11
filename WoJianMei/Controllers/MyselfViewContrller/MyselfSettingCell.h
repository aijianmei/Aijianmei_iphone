//
//  MyselfSettingCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/11/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewCell.h"

@interface MyselfSettingCell : PPTableViewCell
{
    UILabel *_detailLabelView;
    UIImageView *_detailImageView;
    
}

@property (nonatomic,retain) UILabel     *detailLabelView;
@property (nonatomic,retain) UIImageView *detailImageView;


@end
