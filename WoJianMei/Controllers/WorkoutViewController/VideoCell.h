//
//  VideoCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/31/13.
//
//

#import <UIKit/UIKit.h>

@interface VideoCell : UITableViewCell

+ (VideoCell*) createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;

@end
