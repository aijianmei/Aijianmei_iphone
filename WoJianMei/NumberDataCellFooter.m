//
//  NumberDataCellFooter.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import "NumberDataCellFooter.h"


@interface NumberDataCellFooter()
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
    
    [_addButton release];
    [_delegate release];
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
    
    
    [footer.averageButton setTitle:average forState:UIControlStateNormal];
    [footer.weightButton setTitle:weight forState:UIControlStateNormal];
    [footer.numberButton setTitle:number forState:UIControlStateNormal];
    [footer.timeButton setTitle:time forState:UIControlStateNormal];
    [footer.caloriesButton setTitle:calories forState:UIControlStateNormal];

    
    [footer.addButton addTarget:footer action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    [footer.deleteButton addTarget:footer action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    

    footer.delegate = delegate;
    
    return footer;
}


-(void)clickAddButton:(UIButton *)sender{
    
    if ([_delegate respondsToSelector:@selector(didClickFooterAddButton:atIndex:)]){
        [_delegate  didClickFooterAddButton: sender atIndex:0];
    }
}

-(void)clickDeleteButton:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(didClickFooterDeleteButton:atIndex:)]){
        [_delegate  didClickFooterDeleteButton: sender atIndex:0];
    }
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
