//
//  BBSPostDetailCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import <UIKit/UIKit.h>
#import "BBSPostDetailTableCell.h"

@class PBBBSPostComment ;

@interface BBSPostDetailCell : BBSPostDetailTableCell


+ (id)createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeightWithBBSPost:(PBBBSPostComment *)postComment;
- (void)updateCellWithBBSPost:(PBBBSPostComment *)postComment;

@end
