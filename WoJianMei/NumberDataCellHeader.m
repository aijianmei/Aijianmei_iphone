//
//  NumberDataCellHeader.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import "NumberDataCellHeader.h"


@interface NumberDataCellHeader()
@end


@implementation NumberDataCellHeader
@synthesize delegate =_delegate;




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
    
    //获得系统时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"HH:mm"];
//    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
//    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];

    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    
    NSString *timeAndName = [NSString stringWithFormat:@"%@\n%@",name,morelocationString];
    
    [header.nameButton setTitle:timeAndName forState:UIControlStateNormal];
    
    //点击按钮
//    [header.nameButton addTarget:header action:@selector(clickChangeStytle:) forControlEvents:UIControlEventTouchUpInside];
    
      
    [header.weightButton setTitle:weight forState:UIControlStateNormal];
    [header.numberButton setTitle:number forState:UIControlStateNormal];
    [header.timeButton setTitle:time forState:UIControlStateNormal];
    [header.caloriesButton setTitle:calories forState:UIControlStateNormal];
    
    header.delegate = delegate;
    
    return header;
}


-(void)clickChangeStytle:(UIButton *)sender{
    
//    if ([self.delegate respondsToSelector:@selector(didClickHeaderButton:atIndex:)]){
//        [self.delegate  didClickHeaderButton:sender atIndex:0];
//    }
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
