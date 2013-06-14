//
//  NutritionDetailCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 9/7/12.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "Article.h"



@protocol NutritionDetailCellDelegate <NSObject>
@optional
- (void)didClickFollowButton:(id)sender atIndex:(NSIndexPath*)indexPath;
- (void)didClickBuyButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)didClickSinaWeiBlogButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)clickShowBigImage:(id)sender;

@end



@class NutritionInfo;


@interface NutritionDetailCell : UITableViewCell

{
    id<NutritionDetailCellDelegate>delegate;
    
    
    UILabel *_titleLabel;
    UILabel *_descriptionLabel;
    UIImageView  *_imgView;
    UILabel  *_commentNumberLabel;
    UILabel  *_clickedNumberLabel;

    
}
@property (nonatomic, assign) id<NutritionDetailCellDelegate>delegate;
@property (nonatomic, retain) IBOutlet      UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet      UILabel *descriptionLabel;

@property (nonatomic, retain) IBOutlet      UIImageView *imgView;
@property (nonatomic, retain) IBOutlet      UILabel  *commentLabel;
@property (nonatomic, retain) IBOutlet      UILabel  *releasedTimeLabel;




+ (NutritionDetailCell*) createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;


////set the NutritionInfo 
- (void)setCellInfo:(Article *)nutritionInfo;


@end
