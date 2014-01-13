//
//  BBSHomeCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "BBSHomeTableCell.h"


@class PostStatus;
@class PBBBSPost ;

@interface BBSHomeCell :BBSHomeTableCell


+ (id)createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeightWithBBSPost:(PostStatus *)post;
- (void)updateCellWithBBSPost:(PostStatus *)post;


@end
