//
//  VideoCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/31/13.
//
//

#import "VideoCell.h"

@implementation VideoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString*)getCellIdentifier{
    
    
    return @"VideoCell";
    
}

+ (VideoCell*) createCell:(id)delegate{
    
    return nil;
    
}



+ (CGFloat)getCellHeight{
    
    return 45;
    
}
@end
