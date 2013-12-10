//
//  BBSPostDetailCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "BBSPostDetailCell.h"

@implementation BBSPostDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (id)createCell:(id)delegate{
    
    BBSPostDetailCell *cell = [BBSPostDetailTableCell createCellWithIdentifier:[self getCellIdentifier] delegate:delegate];
    return cell;

}
+ (NSString*)getCellIdentifier{
    return @"BBSPostDetailCell";
}
+ (CGFloat)getCellHeightWithBBSPost:(PBBBSPostComment *)postComment{
    
    return 299.0f;

}
- (void)updateCellWithBBSPost:(PBBBSPostComment *)postComment{
    
    
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
