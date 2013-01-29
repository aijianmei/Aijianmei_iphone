//
//  NutritionDetailCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 9/7/12.
//
//

#import "NutritionDetailCell.h"
#import "NutritionInfo.h"

@implementation NutritionDetailCell
@synthesize delegate;
@synthesize introductionImageButton =_introductionImageButton;
@synthesize commentNumberLabel      =_commentNumberLabel;
@synthesize clickedNumberLabel      =_clickedNumberLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)dealloc{
    
    [_introductionImageButton release];
    [_clickedNumberLabel release];
    [_commentNumberLabel release];
    [super dealloc];
   

}

+ (NutritionDetailCell*) createCell:(id)delegate{
    
    return nil;
}

+ (NSString*)getCellIdentifier{
    
    return @"NutritionDetailCell";
    
}
+ (CGFloat)getCellHeight{
    
    return 81.0f;
}

- (void)setCellInfo:(NutritionInfo *)nutritionInfo{

    
    [self.introductionImageButton setImage:[UIImage imageNamed:nutritionInfo.imageName] forState:UIControlStateNormal];
    
    NSString *commentString = [NSString stringWithFormat:@"%@次评论",nutritionInfo.commentsNumber ];
    self.commentNumberLabel.text=commentString;
    self.clickedNumberLabel.text=nutritionInfo.clickedNumber;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
