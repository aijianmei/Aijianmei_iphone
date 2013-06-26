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
        UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(30, 0, 50, 30)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [button setBackgroundImage:[UIImage imageNamed:@"label_Coloer_1.png"] forState:UIControlStateNormal];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
