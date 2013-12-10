//
//  VoteCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/10/13.
//
//

#import "PPTableViewCell.h"

@interface VoteCell : PPTableViewCell


+ (id)createCellWithIdentifier:(NSString *)identifier                       delegate:(id)delegate;
+ (id)createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;

@end
