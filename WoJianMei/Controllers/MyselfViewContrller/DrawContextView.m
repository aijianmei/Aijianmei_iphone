//
//  DrawContextView.m
//  WoJianMei
//
//  Created by Kaibin on 13-5-25.
//
//

#import "DrawContextView.h"

#define DAY_AMOUNT 2

@implementation DrawContextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _amountList = [[NSMutableArray alloc] init];
        _timeList = [[NSMutableArray alloc] init];
        _intensityList = [[NSMutableArray alloc] init];
        
        for (int i=0; i<DAY_AMOUNT;i++) {
            [_amountList addObject:[[NSMutableArray alloc] init]];
        }
        
        for (int i=0; i<DAY_AMOUNT;i++) {
            [_timeList addObject:[[NSMutableArray alloc] init]];
        }
        
        for (int i=0; i<DAY_AMOUNT;i++) {
            [_intensityList addObject:[[NSMutableArray alloc] init]];
        }

    }
    return self;
}

- (void)addAmount:(UIButton*)button dayIndex:(int)dayIndex
{
    [[_amountList objectAtIndex:dayIndex] addObject:button];
}


- (void)addTime:(UIButton *)button dayIndex:(int)dayIndex
{
    [[_timeList objectAtIndex:dayIndex] addObject:button];
}

- (void)addIntensity:(UIButton *)button dayIndex:(int)dayIndex
{
    [[_intensityList objectAtIndex:dayIndex] addObject:button];
}

- (void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
    NSLog(@"Redraw data.....");
    
    int day = [_amountList count];//天数，横坐标
    int index = 0;//第几组数据
    
    
    for (int i=0; i<day-1; i++) {
        UIButton *btn1 = (UIButton*)[[_amountList objectAtIndex:i] objectAtIndex:index];
        CGPoint point1 = CGPointMake(btn1.frame.origin.x, btn1.frame.origin.y);
        UIButton *btn2 = (UIButton*)[[_amountList objectAtIndex:i+1] objectAtIndex:index];
        CGPoint point2 = CGPointMake(btn2.frame.origin.x, btn2.frame.origin.y);
        [self addLineFromPoint:point1 to:point2 withColor:[UIColor redColor].CGColor];
        [self addSubview:btn1];
        [self addSubview:btn2];
    }
    
    for (int i=0; i<day-1; i++) {
        UIButton *btn1 = (UIButton*)[[_timeList objectAtIndex:i] objectAtIndex:index];
        CGPoint point1 = CGPointMake(btn1.frame.origin.x, btn1.frame.origin.y);
        UIButton *btn2 = (UIButton*)[[_timeList objectAtIndex:i+1] objectAtIndex:index];
        CGPoint point2 = CGPointMake(btn2.frame.origin.x, btn2.frame.origin.y);
        [self addLineFromPoint:point1 to:point2 withColor:[UIColor greenColor].CGColor];
        [self addSubview:btn1];
        [self addSubview:btn2];
    }
    
    for (int i=0; i<day-1; i++) {
        UIButton *btn1 = (UIButton*)[[_intensityList objectAtIndex:i] objectAtIndex:index];
        CGPoint point1 = CGPointMake(btn1.frame.origin.x, btn1.frame.origin.y);
        UIButton *btn2 = (UIButton*)[[_intensityList objectAtIndex:i+1] objectAtIndex:index];
        CGPoint point2 = CGPointMake(btn2.frame.origin.x, btn2.frame.origin.y);
        [self addLineFromPoint:point1 to:point2 withColor:[UIColor blueColor].CGColor];
        [self addSubview:btn1];
        [self addSubview:btn2];
    }
    
    [self addTabText];
}

- (void)addLineFromPoint:(CGPoint)start to:(CGPoint)end withColor:(CGColorRef)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10.0);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextMoveToPoint(context, start.x+23, start.y+23);
    CGContextAddLineToPoint(context, end.x+23, end.y+23);
    CGContextStrokePath(context);
}

- (void)addTabText
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, 10.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    NSString *text = @"22";
    [text drawAtPoint:CGPointMake(37, 350) withFont:[UIFont systemFontOfSize:22]];
    
    text = @"23";
    [text drawAtPoint:CGPointMake(137, 350) withFont:[UIFont systemFontOfSize:22]];

    text = @"24";
    [text drawAtPoint:CGPointMake(237, 350) withFont:[UIFont systemFontOfSize:22]];
    
}


@end
