//
//  LabelsView.m
//  WoJianMei
//
//  Created by Tom Callon  on 6/26/13.
//
//

#import "LabelsView.h"
#import "PPViewController.h"



#define SCROLL_VIEW_TAG 20130626

#define BUTTONS_PERLINE  [buttonArrays count]




@implementation LabelsView

@synthesize buttonScrollView =_buttonScrollView;
@synthesize dataList =_dataList;


-(void)dealloc{

    [_buttonScrollView release];
    [_dataList release];
    [super dealloc];
    
}

-(void)setNeedsDisplay
{
    ////Configure The ButtonScrollView
    NSMutableArray *buttonArrays  =[[NSMutableArray alloc]init];
    for (NSString *buttonTitle in self.dataList) {
        UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(30, 0, 70, 30)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
        //获取一个随机数范围在：[500,1000），包括500，不包括1000
//       int y = (arc4random() % 501) + 500;
        
        //获取一个随机数范围在：[0,500），包括1，不包括4
//         int y = (arc4random() % 3) + 1;
//         NSLog(@"%i",y);
        [button setBackgroundImage:[UIImage imageNamed:[self getAnRandomImage]] forState:UIControlStateNormal];

        
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ////根据字体的多少来调整button 的长度
//       CGSize stringsize = [buttonTitle sizeWithFont:[UIFont systemFontOfSize:12]];
        //or whatever font you're using
    
//       [button setFrame:CGRectMake(30,0,stringsize.width,30)];
        
        
        
        [buttonArrays addObject:button];
        
        [button release];
        
    }
    

    UIScrollView *scrollView = [PPViewController createButtonScrollViewByButtonArray:buttonArrays buttonsPerLine:BUTTONS_PERLINE  buttonSeparatorY:-1];
    
    self.buttonScrollView =scrollView;
    [self.buttonScrollView setBackgroundColor:[UIColor clearColor]];
    
    
    [buttonArrays release];
    
    float buttonHeight = 30;
    float buttonWidth  = 70;
    
    [[self viewWithTag:SCROLL_VIEW_TAG] removeFromSuperview];
    self.buttonScrollView.tag = SCROLL_VIEW_TAG;
    [_buttonScrollView setFrame:CGRectMake(0,0, 230, 30)];
    [_buttonScrollView setShowsHorizontalScrollIndicator:NO];
    [_buttonScrollView setContentSize:CGSizeMake(([[_buttonScrollView subviews] count]) * buttonWidth * 2.6, buttonHeight)];
    
    [self addSubview:_buttonScrollView];

    
}

///获取随机数目图片名称；
-(NSString*)getAnRandomImage{
    
    int X =[self getRandomNumber:1 to:3];
    NSString *imageTitle = [NSString stringWithFormat:@"label_Coloer_%i",X];
    return imageTitle;

}
///产生随机数目
-(int)getRandomNumber:(int)from to:(int)to
{
    int xx = to - from + 1;
    int returnValue =(from + (arc4random() % xx));
    return returnValue;
}

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

@end
