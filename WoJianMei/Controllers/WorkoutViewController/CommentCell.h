//
//  CommentCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/23/13.
//
//

#import <UIKit/UIKit.h>


@class Comment;

@interface CommentCell : UITableViewCell


+ (Comment*) createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;
- (void)setCellInfo:(Comment *)comment;




@end
