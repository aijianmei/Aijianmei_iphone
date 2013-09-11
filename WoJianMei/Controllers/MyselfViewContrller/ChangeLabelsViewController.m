
//
//  ChangeLabelsViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/10/13.
//
//

#import "ChangeLabelsViewController.h"
#import "LabelManager.h"
#import "Label.h"
#import "ImageManager.h"
#import "AppButton.h"

#import "UserService.h"
#import "User.h"
#import "AddLabelViewController.h"




#define SCROLL_VIEW_TAG 20130710
#define LABEL_ID_BUTTON_OFFSET 120111109

#define WIDTH  65
#define HIGHT  105

#define TAGH  10

#define BTNWIDTH  WIDTH - TAGH
#define BTNHIGHT  HIGHT - TAGH



@interface ChangeLabelsViewController ()

{
    BOOL m_bTransform;
     NSMutableArray *m_arData;
}

@end

@implementation ChangeLabelsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)dealloc
{
    [m_arData release];
    [super dealloc];
}

-(void)clickFinishEdittingButton{
    
    if(m_bTransform==NO)
        return;
    
    for (UIView *view in self.view.subviews)
    {
        view.userInteractionEnabled = NO;
        for (UIView *v in view.subviews)
        {
            if ([v isMemberOfClass:[UIImageView class]])
                [v setHidden:YES];
        }
    }
    m_bTransform = NO;
    [self EndWobble];
    
    [self setNavigationRightButton:@"编辑" imageName:@"top_bar_commonButton.png" action:@selector(clickEditButton)];
}

-(void)clickEditButton{
    
    if (m_bTransform)
        return;
    
    for (UIView *view in self.view.subviews)
    {
        view.userInteractionEnabled = YES;
        for (UIView *v in view.subviews)
        {
            if ([v isMemberOfClass:[UIImageView class]])
                [v setHidden:NO];
        }
    }
    m_bTransform = YES;
    [self BeginWobble];
    
    
    [self setNavigationRightButton:@"完成" imageName:@"top_bar_commonButton.png" action:@selector(clickFinishEdittingButton)];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    ///设置背景
//    [self setBackgroundImageName:@"gobal_background.png"];
//    [self showBackgroundImage];
    
    
//    [self contentTypeButtonInit];
    
//    NSArray *labelId = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",nil];
    
    
    [self setNavigationRightButton:@"编辑" imageName:@"top_bar_commonButton.png" action:@selector(clickEditButton)];
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];

    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    //因为self.view 上面还有subviews 就会造成错误，所以要把他们都清除掉；
    NSArray *viewArray = self.view.subviews;
    for (UIView *v in viewArray)
    {
        if ([v isMemberOfClass:[UIImageView class]])
        {
            [v removeFromSuperview];
        }
        
        [v removeFromSuperview];

    }
    
    
    [self createData];
    [self createButtons];
    

}
- (void)contentTypeButtonInit
{
    
}

#pragma mark -
#pragma mark createButtons

-(void)createButtons{
    
    // Do any additional setup after loading the view, typically from a nib.
        
//    LabelManager  *manager = [LabelManager defaultlabelManager];
//    for (int i = 0; i < [manager.allLabel
// count]; i++)
    
        
    int width = self.view.frame.size.width/4;
    for (int i = 0; i < [m_arData count]; i++)

    {
        int t = i/4;
        int d = fmod(i, 4);
        UIView *nView = [[[UIView alloc] initWithFrame:CGRectMake(width * d + 5, HIGHT * t +10, WIDTH, HIGHT)] autorelease];
        CAppButton *appBtn = [CAppButton BtnWithType:UIButtonTypeCustom];
        [appBtn setFrame:CGRectMake(TAGH, TAGH, BTNWIDTH, BTNHIGHT)];
        [appBtn setImage:[UIImage imageNamed:@"apphead.png"] forState:UIControlStateNormal];
        
        
        [appBtn setTitle:[m_arData objectAtIndex:i] forState:UIControlStateNormal];
        
        [appBtn addTarget:self action:@selector(btnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
        appBtn.tag = i;
        [nView addSubview:appBtn];
        
        UIImageView *tagImgView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)] autorelease];
        [tagImgView setImage:[UIImage imageNamed:@"deleteTag.png"]];
        [tagImgView setHidden:YES];
        [nView addSubview:tagImgView];
        
        [self.view addSubview:nView];
        
        
        nView.userInteractionEnabled = NO;

        //最后一个按钮是可以点击的
        if (i==[m_arData count]-1) {
            nView.userInteractionEnabled = YES;
            lastButton = nView;
            [lastButton setUserInteractionEnabled:YES];
        }
    }
    
    UILongPressGestureRecognizer *lpgr = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LongPressGestureRecognizer:)] autorelease];
    [self.view addGestureRecognizer:lpgr];
    
    UITapGestureRecognizer *tapGestureTel2 = [[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TwoPressGestureRecognizer:)]autorelease];
    [tapGestureTel2 setNumberOfTapsRequired:2];
    [tapGestureTel2 setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:tapGestureTel2];    
}



- (void)createData
{
    
    LabelManager  *manager = [LabelManager defaultlabelManager];

    Label *label1 = [[Label alloc]initWithId:@"0" labelName:@"健身"];
    Label *label2 = [[Label alloc]initWithId:@"1" labelName:@"减肥"];
    Label *label3 = [[Label alloc]initWithId:@"2" labelName:@"增肌"];
    Label *label4 = [[Label alloc]initWithId:@"3" labelName:@"泡妞"];
    Label *label5 = [[Label alloc]initWithId:@"4" labelName:@"健身"];
    Label *label6 = [[Label alloc]initWithId:@"5" labelName:@"减肥"];
    Label *label7 = [[Label alloc]initWithId:@"6" labelName:@"增肌"];
    Label *label8 = [[Label alloc]initWithId:@"7" labelName:@"泡妞"];
    
    [manager addLabel:label1];
    [manager addLabel:label2];
    [manager addLabel:label3];
    [manager addLabel:label4];
    [manager addLabel:label5];
    [manager addLabel:label6];
    [manager addLabel:label7];
    [manager addLabel:label8];
    
    
    [label1 release];
    [label2 release];
    [label3 release];
    [label4 release];
    [label5 release];
    [label6 release];
    [label7 release];
    [label8 release];

    
    
    User *user = [[UserService defaultService] user];
    
    
   m_arData = [[NSMutableArray alloc] initWithObjects:@"电话", @"短信", @"通讯录", @"浏览器", @"日历", @"时钟", @"计算器", @"地图", @"天气", @"图库",@"自定义", nil];
    
//    [m_arData setArray:[manager allLabel]];
    
      [user setLabelsArray:m_arData];

    
}

- (void)btnClicked:(id)sender event:(id)event
{
    UIButton *btn = (UIButton *)sender;
    
    if (([m_arData count] -1) == (btn.tag)) {
        NSLog(@"adfasdfa");
        [lastButton setUserInteractionEnabled:YES];
        
        AddLabelViewController *vc = [[AddLabelViewController alloc]initWithNibName:@"AddLabelViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
        
        
    }else{
        [self deleteAppBtn:btn.tag];
    }
}

- (void)deleteAppBtn:(int)index
{
    NSArray *views = self.view.subviews;
    __block CGRect newframe;
    for (int i = index; i < [m_arData count]; i++)
    {
        UIView *obj = [views objectAtIndex:i];
        __block CGRect nextframe = obj.frame;
        if (i == index)
        {
            [obj removeFromSuperview];
        }
        else
        {
            for (UIView *v in obj.subviews)
            {
                if ([v isMemberOfClass:[CAppButton class]])
                {
                    v.tag = i - 1;
                    break;
                }
            }
            [UIView animateWithDuration:0.6 animations:^
             {
                 obj.frame = newframe;
             } completion:^(BOOL finished)
             {
             }];
        }
        newframe = nextframe;
    }
    [m_arData removeObjectAtIndex:index];
    
//    
//    LabelManager  *manager = [LabelManager defaultlabelManager];
//    [manager.allLabel removeObjectAtIndex:index];


}

- (void)LongPressGestureRecognizer:(UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {
        if (m_bTransform)
            return;
        
        for (UIView *view in self.view.subviews)
        {
            view.userInteractionEnabled = YES;
            for (UIView *v in view.subviews)
            {
                if ([v isMemberOfClass:[UIImageView class]])
                    [v setHidden:NO];
            }
        }
        m_bTransform = YES;
        [self BeginWobble];
        
        [self setNavigationRightButton:@"完成" imageName:@"top_bar_commonButton.png" action:@selector(clickFinishEdittingButton)];
    }
}

-(void)TwoPressGestureRecognizer:(UIGestureRecognizer *)gr
{
    if(m_bTransform==NO)
        return;
    
    for (UIView *view in self.view.subviews)
    {
        view.userInteractionEnabled = NO;
        for (UIView *v in view.subviews)
        {
            if ([v isMemberOfClass:[UIImageView class]])
                [v setHidden:YES];
        }
    }
    m_bTransform = NO;
    [self EndWobble];

    [self setNavigationRightButton:@"编辑" imageName:@"top_bar_commonButton.png" action:@selector(clickEditButton)];

    
}

-(void)BeginWobble
{
    NSAutoreleasePool* pool=[NSAutoreleasePool new];
    for (UIView *view in self.view.subviews)
    {
        srand([[NSDate date] timeIntervalSince1970]);
        float rand=(float)random();
        CFTimeInterval t=rand*0.0000000001;
        [UIView animateWithDuration:0.1 delay:t options:0  animations:^
         {
             view.transform=CGAffineTransformMakeRotation(-0.05);
         } completion:^(BOOL finished)
         {
             [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
              {
                  view.transform=CGAffineTransformMakeRotation(0.05);
              } completion:^(BOOL finished) {}];
         }];
    }
    [pool release];
}

-(void)EndWobble
{
    NSAutoreleasePool* pool=[NSAutoreleasePool new];
    for (UIView *view in self.view.subviews)
    {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             view.transform=CGAffineTransformIdentity;
             for (UIView *v in view.subviews)
             {
                 if ([v isMemberOfClass:[UIImageView class]])
                     [v setHidden:YES];
             }
         } completion:^(BOOL finished) {}];
    }
    [pool release];
}



#pragma mark -
#pragma mark these codes used to draw scrollView

- (void)createButtonsByArray:(NSArray*)array selectedlabelSet:(NSMutableSet*)selectedlabelSet
{
    NSMutableArray* buttonArray = [[NSMutableArray alloc] init];
    for (NSString* labelId in array) {
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(160, 160, 72, 32)];
        Label* label = [[LabelManager defaultlabelManager] getLabelById:labelId];
        PPDebug(@"%@",label.labelName) ;
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [button setTitle:label.labelName forState:UIControlStateNormal];
        [button setTitle:label.labelName forState:UIControlStateSelected];
        
        NSString *imageName = [self getAnRandomImage];
        [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
         
        [button setBackgroundImage:[UIImage imageNamed:@"set.png"] forState:UIControlStateSelected];
        
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTag:([label.labelId intValue] + LABEL_ID_BUTTON_OFFSET)];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonArray addObject:button];
        [button release];
    }
    
    UIScrollView *buttonScrollView = [PPViewController createButtonScrollViewByButtonArray:buttonArray buttonsPerLine:4 buttonSeparatorY:-1];
    
    [buttonArray release];
    [[self.view viewWithTag:SCROLL_VIEW_TAG] removeFromSuperview];
    buttonScrollView.tag = SCROLL_VIEW_TAG;
    [buttonScrollView setFrame:CGRectMake(0, 50, 320, 243)];
    [self.view addSubview:buttonScrollView];
    
}


- (void)buttonClicked:(id)sender
{
}

//获取随机数目图片名称；
-(NSString*)getAnRandomImage
{
    
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
