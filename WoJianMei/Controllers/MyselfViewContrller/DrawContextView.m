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
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
    
    [self drawCircleAtPoint:CGPointMake(60, 170) radius:20 withText:@"30s"];
    [self drawCircleAtPoint:CGPointMake(150, 240) radius:20 withText:@"40"];
    [self addLineFromPoint:CGPointMake(60, 170) to:CGPointMake(150, 240)];
    
    }

- (void)addLineFromPoint:(CGPoint)start to:(CGPoint)end
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5.0);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextMoveToPoint(context, start.x+40, start.y+20+5);
    CGContextAddLineToPoint(context, end.x, end.y+20-5);
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);

}

- (void)drawCircleAtPoint:(CGPoint)point radius:(CGFloat)radius withText:(NSString*)text
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGRect rectangle = CGRectMake(point.x, point.y, 2*radius, 2*radius);
    CGContextAddEllipseInRect(context, rectangle);
    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillEllipseInRect(context, rectangle);
    
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    UIFont *font = [UIFont boldSystemFontOfSize:15];
    [text drawAtPoint:CGPointMake(point.x+radius/2, point.y+radius/2) forWidth:radius+radius/2 withFont:font minFontSize:15 actualFontSize:NULL
        lineBreakMode:UILineBreakModeTailTruncation
   baselineAdjustment:UIBaselineAdjustmentAlignCenters];
}


@end
