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
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGRect rectangle = CGRectMake(60,170,40,40);
    CGContextAddEllipseInRect(context, rectangle);
    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillEllipseInRect(context, rectangle);
    
    
    NSString *text = @"30";
    UIFont *font = [UIFont systemFontOfSize:15];
    //在指定x，y点位置画文字，宽度为18
    [text drawAtPoint:CGPointMake(80, 190) forWidth:18 withFont:font minFontSize:8 actualFontSize:NULL
        lineBreakMode:UILineBreakModeTailTruncation
        baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
    [super drawRect:rect];

}


@end
