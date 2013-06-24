//
//  MyselfTableViewCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/29/12.
//
//

#import "MyselfTableViewCell.h"

@implementation MyselfTableViewCell
@synthesize delegate;


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
    
    
    return @"MyselfTableViewCell";
    
}

+ (MyselfTableViewCell*) createCell:(id)delegate{
    
    return nil;

}



+ (CGFloat)getCellHeight{
    
    return 45;

}


@end
