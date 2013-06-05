//
//  ProductDetailCell.h
//  groupbuy
//
//  Created by  on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PPTableViewController.h"



@class Video;
@class OHAttributedLabel;

@protocol VideoListCellDelegate <NSObject>

- (void)didClickFollowButton:(id)sender atIndex:(NSIndexPath*)indexPath;
- (void)didClickBuyButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)didClickSinaWeiBlogButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)clickShowBigImage:(id)sender atIndex:(NSIndexPath *)indexPath;
;


@end



@interface ArticleCell : UITableViewCell
{
    id<VideoListCellDelegate>delegate;
    
    
    
}



@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@property (retain, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (retain, nonatomic) IBOutlet UIButton *ImageButton;
@property (retain, nonatomic) IBOutlet UILabel  *releasedTimeLabel;
@property (retain, nonatomic) IBOutlet UILabel  *commentLabel;
@property (retain, nonatomic) IBOutlet UILabel  *clickTimesLabel;


@property (nonatomic, assign) id<VideoListCellDelegate>delegate;

+ (ArticleCell*) createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;
- (void)setCellInfo:(Video *)Video;







@end
