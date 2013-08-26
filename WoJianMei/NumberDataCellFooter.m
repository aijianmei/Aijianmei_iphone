//
//  NumberDataCellFooter.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import "NumberDataCellFooter.h"


@interface NumberDataCellFooter()
@property (assign, nonatomic) id<NumberDataCellFooterDelegate> delegate;
@end


@implementation NumberDataCellFooter
@synthesize averageButton =_averageButton;
@synthesize numberButton =_numberButton;
@synthesize weightButton =_weightButton;
@synthesize timeButton =_timeButton;
@synthesize caloriesButton =_caloriesButton;

@synthesize delegate = _delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc {
    [_averageButton release];
    [_numberButton release];
    [_weightButton release];
    [_timeButton release];
    [_caloriesButton release];
    [super dealloc];
}

+ (NumberDataCellFooter *)createFooterWithAverage:(NSString *)average
                                           weight:(NSString *)weight
                                           number:(NSString *)number
                                             time:(NSString *)time
                                         calories:(NSString *)calories
                               delegate:(id<NumberDataCellFooterDelegate>)delegate
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NumberDataCellFooter" owner:self options:nil];
    
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create NumberDataCellFooter but cannot find object from Nib");
        return nil;
    }
    
    NumberDataCellFooter *footer = (NumberDataCellFooter*)[topLevelObjects objectAtIndex:0];
    
    [footer.averageButton.titleLabel setText:average];
     footer.delegate = delegate;
    
    return footer;
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
