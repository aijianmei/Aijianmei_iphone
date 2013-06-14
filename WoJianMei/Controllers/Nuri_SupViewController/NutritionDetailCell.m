//
//  NutritionDetailCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 9/7/12.
//
//

#import "NutritionDetailCell.h"
#import "NutritionInfo.h"
#import "Article.h"
#import "UIImageView+WebCache.h"


@implementation NutritionDetailCell
@synthesize delegate;
@synthesize titleLabel = _titleLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize imgView = _imgView;
@synthesize releasedTimeLabel = _releasedTimeLabel;
@synthesize commentLabel = _commentLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)dealloc{
    
    
    [_titleLabel release];
    [_descriptionLabel release];
    [_clickedNumberLabel release];
    [_commentLabel release];
    [_imgView release];
    
    [super dealloc];
   

}

+ (NutritionDetailCell*) createCell:(id)delegate{
    
    return nil;
}

+ (NSString*)getCellIdentifier{
    
    return @"NutritionDetailCell";
    
}
+ (CGFloat)getCellHeight{
    
    return 134.0f;
}

- (void)setCellInfo:(Article *)nutritionInfo{

    [self.titleLabel setText:nutritionInfo.title];
    [self.descriptionLabel setText:nutritionInfo.brief];
    [self.imgView setImageWithURL:[NSURL URLWithString:nutritionInfo.img] placeholderImage:[UIImage imageNamed:@"11"]];
    [self.commentLabel setText:nutritionInfo.commentCount];
    [self.releasedTimeLabel setText:nutritionInfo.create_time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
