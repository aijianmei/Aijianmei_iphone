//
//  ProductCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/17/14.
//
//

#import "ProductCell.h"
#import "ProductItem.h"
#import "UIImageView+WebCache.h"
#import "SingleItemView.h"




@implementation ProductCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc{
    [super dealloc];
}


#define LEFT_ITEM_TAG 1003
#define RIGHT_ITEM_TAG 1004

-(void)initMaskViews{
    
//    NSArray *array1 = [[NSBundle mainBundle] loadNibNamed:@"SingleItemView"owner:self options:nil];
//    SingleItemView *leftView = [array1 objectAtIndex:0];
//    leftView.center = CGPointMake(80, 85);
//    leftView.tag = LEFT_ITEM_TAG;
//
//    
//    [self addSubview:leftView];
//    
//    
//    NSArray *array2 = [[NSBundle mainBundle] loadNibNamed:@"SingleItemView"owner:self options:nil];
//    SingleItemView *rightView = [array2 objectAtIndex:0];
//    rightView.tag = RIGHT_ITEM_TAG;
//    rightView.center = CGPointMake(240, 85);
//    
//    [self addSubview:rightView];

}

+ (id)createCell:(id)delegate{
    
    ProductCell *cell = [ProductCommonCell createCellWithIdentifier:[self getCellIdentifier] delegate:delegate];
//    [cell initMaskViews];
    return cell;

    
}
+ (NSString*)getCellIdentifier{
    return @"ProductCell";
}
+ (CGFloat)getCellHeight{
    return 167.0f;
}


-(void)updateCellWithProduct:(ProductItem *)product{

    
//    SingleItemView*leftView = (SingleItemView*)[self viewWithTag:LEFT_ITEM_TAG];
//    [self setSingleItemView:nil withTaobaoItem:product];
    
    
//    SingleItemView*rightView = (SingleItemView*)[self viewWithTag:RIGHT_ITEM_TAG];
//    [self setSingleItemView:rightView withTaobaoItem:product];
    

}
@end
