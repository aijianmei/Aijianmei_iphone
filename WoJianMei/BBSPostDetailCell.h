//
//  BBSPostDetailCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import <UIKit/UIKit.h>
#import "BBSPostDetailTableCell.h"

@class PostStatus ;

@interface BBSPostDetailCell : BBSPostDetailTableCell


+ (id)createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeightWithBBSPost:(PostStatus *)post;
- (void)updateCellWithBBSPost:(PostStatus *)post;
- (void)updateContentWithBBSPost:(PostStatus *)post;


@end
