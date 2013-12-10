//
//  BBSHomeCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "BBSHomeTableCell.h"


@class PBBBSPost ;

@interface BBSHomeCell :BBSHomeTableCell


+ (id)createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeightWithBBSPost:(PBBBSPost *)post;
- (void)updateCellWithBBSPost:(PBBBSPost *)post;


@end
