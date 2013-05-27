//
//  DrawContextView.m
//  WoJianMei
//
//  Created by Kaibin on 13-5-25.
//
//

#import "DrawContextView.h"

@implementation DrawContextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataList1 = [[NSMutableArray alloc] init];
        _dataList2 = [[NSMutableArray alloc] init];
        _dataList3 = [[NSMutableArray alloc] init];

    }
    return self;
}

- (void)addToList1:(UIButton*)button
{
    [_dataList1 addObject:button];
}

- (void)addToList2:(UIButton*)button
{
    [_dataList2 addObject:button];
}

- (void)addToList3:(UIButton*)button
{
    [_dataList3 addObject:button];
}
- (void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
    
    for(int i=0; i<[_dataList1 count]-1; i++) {
        UIButton *btn = (UIButton*)[_dataList1 objectAtIndex:i];
        CGPoint point1 = CGPointMake(btn.frame.origin.x, btn.frame.origin.y);
        btn = (UIButton*)[_dataList1 objectAtIndex:i+1];
        CGPoint point2 = CGPointMake(btn.frame.origin.x, btn.frame.origin.y);
        [self addLineFromPoint:point1 to:point2 withColor:[UIColor redColor].CGColor];
    }
    
    for(int i=0; i<[_dataList2 count]-1; i++) {
        UIButton *btn = (UIButton*)[_dataList2 objectAtIndex:i];
        CGPoint point1 = CGPointMake(btn.frame.origin.x, btn.frame.origin.y);
        btn = (UIButton*)[_dataList2 objectAtIndex:i+1];
        CGPoint point2 = CGPointMake(btn.frame.origin.x, btn.frame.origin.y);
        [self addLineFromPoint:point1 to:point2 withColor:[UIColor greenColor].CGColor];
    }
    
    for(int i=0; i<[_dataList3 count]-1; i++) {
        UIButton *btn = (UIButton*)[_dataList3 objectAtIndex:i];
        CGPoint point1 = CGPointMake(btn.frame.origin.x, btn.frame.origin.y);
        btn = (UIButton*)[_dataList3 objectAtIndex:i+1];
        CGPoint point2 = CGPointMake(btn.frame.origin.x, btn.frame.origin.y);
        [self addLineFromPoint:point1 to:point2 withColor:[UIColor blueColor].CGColor];
    }
    
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


@end
