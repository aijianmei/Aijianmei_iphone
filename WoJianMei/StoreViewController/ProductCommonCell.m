//
//  ProductCommonCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/17/14.
//
//

#import "ProductCommonCell.h"
#import "PPDebug.h"


@implementation ProductCommonCell
@synthesize clickUrlString =_clickUrlString;
@synthesize imageViewContent =_imageViewContent;
@synthesize imageViewBG =_imageViewBG;
@synthesize actionButton =_actionButton;
@synthesize nameLabel =_nameLabel;
@synthesize devideLineImageView =_devideLineImageView;
@synthesize totalSaleCountLable =_totalSaleCountLable;
@synthesize priceLabel =_priceLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc{
    
    [_clickUrlString release];
    [_imageViewContent release];
    
    [_imageViewBG release];
    [_actionButton release];
    [_nameLabel release];
    
    [_devideLineImageView release];
    [_totalSaleCountLable release];
    [_priceLabel release];
    

    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)initMaskViews{
    

}
+ (id)createCellWithIdentifier:(NSString *)identifier
                      delegate:(id)delegate{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
    
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        PPDebug(@"create %@ but cannot find cell object from Nib", identifier);
        return nil;
    }
    
    ProductCommonCell  *cell = (ProductCommonCell *)[topLevelObjects objectAtIndex:0];
    cell.delegate = delegate;

    [cell initMaskViews];
    return cell;
}



@end
