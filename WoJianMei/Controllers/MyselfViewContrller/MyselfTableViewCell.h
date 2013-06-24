//
//  MyselfTableViewCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/29/12.
//
//

#import <UIKit/UIKit.h>



@protocol MyselfTableViewCellDelegate <NSObject>
@optional
- (void)didClickFollowButton:(id)sender atIndex:(NSIndexPath*)indexPath;
- (void)didClickBuyButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)didClickSinaWeiBlogButton:(id)sender atIndex:(NSIndexPath *)indexPath;
- (void)clickShowBigImage:(id)sender;

@end

 

@interface MyselfTableViewCell : UITableViewCell
{

    id<MyselfTableViewCellDelegate>delegate;

}

@property (nonatomic, assign) id<MyselfTableViewCellDelegate>delegate;

+ (MyselfTableViewCell*) createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;


@end
