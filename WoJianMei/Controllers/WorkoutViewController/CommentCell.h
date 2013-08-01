//
//  CommentCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/23/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewCell.h"


@class Comment;

@interface CommentCell : PPTableViewCell
{
    UIImageView   *_myImageView;
    UILabel       *_nameLabel;
    UILabel       *_commentLabel;
    UILabel       *_commentTimeLabel;

}
@property (nonatomic,retain)  UIImageView *myImageView;
@property (nonatomic,retain)  UILabel *nameLabel;
@property (nonatomic,retain)  UILabel *commentLabel;
@property (nonatomic,retain)  UILabel *commentTimeLabel;



+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;
- (void)setCellInfo:(Comment *)comment;




@end
