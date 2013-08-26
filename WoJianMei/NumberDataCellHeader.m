//
//  NumberDataCellHeader.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import "NumberDataCellHeader.h"


@interface NumberDataCellHeader()
@property (assign, nonatomic) id<NumberDataCellHeaderDelegate> delegate;
@end





@implementation NumberDataCellHeader

-(void)dealloc {
    [_nameButton release];
    [_numberButton release];
    [_weightButton release];
    [_timeButton release];
    [_caloriesButton release];
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (NumberDataCellHeader *)createHeaderWithName:(NSString *)name
                                           weight:(NSString *)weight
                                           number:(NSString *)number
                                             time:(NSString *)time
                                         calories:(NSString *)calories
                                         delegate:(id<NumberDataCellHeaderDelegate>)delegate
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NumberDataCellHeader" owner:self options:nil];
    
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create NumberDataCellHeader but cannot find object from Nib");
        return nil;
    }
    
    NumberDataCellHeader *header = (NumberDataCellHeader*)[topLevelObjects objectAtIndex:0];
    
    [header.numberButton.titleLabel setText:name];
    header.delegate = delegate;
    
    return header;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
