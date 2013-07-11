//
//  PickCityCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/11/13.
//
//

#import "PickCityCell.h"

@implementation PickCityCell

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
- (void)setSelectedStyle
{
    
    [self setBackgroundColor:[UIColor redColor]];
    
}
- (void)setUnselectedStyle
{
    
    
    
}

@end
