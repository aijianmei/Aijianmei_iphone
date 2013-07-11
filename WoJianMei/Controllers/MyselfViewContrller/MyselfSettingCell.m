//
//  MyselfSettingCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/11/13.
//
//

#import "MyselfSettingCell.h"

@implementation MyselfSettingCell
@synthesize detailLabelView =_detailLabelView;
@synthesize detailImageView =_detailImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.detailLabelView = [[UILabel alloc]initWithFrame:CGRectMake(145.0f, 11.0f, 115.0f,32.0f)];
        [self.detailLabelView setTextAlignment:NSTextAlignmentRight];
        [self.detailLabelView setBackgroundColor:[UIColor clearColor]];
        [self.detailLabelView setTextColor:[UIColor grayColor]];
        [self addSubview:_detailLabelView];
        
        
        
        self.detailImageView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 5.0f, 45.0f,42.0f)];
        [self.detailImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_detailImageView];

        
        
    }
    return self;
}

-(void)dealloc{

    [_detailLabelView release];
    [_detailImageView release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end