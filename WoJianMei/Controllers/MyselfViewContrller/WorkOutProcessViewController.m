//
//  WorkOutProcessViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 5/25/13.
//
//

#import "WorkOutProcessViewController.h"
#import "DrawContextView.h"
#import "AppDelegate.h"

@interface WorkOutProcessViewController ()

@end

@implementation WorkOutProcessViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    
    
    
}

- (void)hideTabBar:(BOOL)isHide
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate hideTabBar:isHide];

}

- (void)viewDidAppear:(BOOL)animated
{    
    [super viewDidAppear:animated];
    [self hideTabBar:YES];

    drawView = [[DrawContextView alloc] initWithFrame:CGRectMake(0, 30, 320-30, [UIScreen mainScreen ].bounds.size.height-20-44-30)];
    drawView.backgroundColor = [UIColor clearColor];
    
    CGRect point0 = CGRectMake(-30, 210, 1, 1);
    UIButton *button0 = [self createButtonWithFrame: point0 image:nil text:@"15个"];
    CGRect point1 = CGRectMake(40, 190, 46, 46);
    UIButton *button1 = [self createButtonWithFrame: point1 image:[UIImage imageNamed:@"gs_1"] text:@"12个"];
    CGRect point2 = CGRectMake(120, 120, 46, 46);
    UIButton *button2 = [self createButtonWithFrame: point2 image:[UIImage imageNamed:@"gs_1"] text:@"15个"];
    [drawView addToList1:button0];
    [drawView addToList1:button1];
    [drawView addToList1:button2];
    
    CGRect point1_0 = CGRectMake(-30, 130, 1, 1);
    UIButton *button1_0 = [self createButtonWithFrame: point1_0 image:nil text:@"15个"];
    CGRect point1_1 = CGRectMake(40, 100, 46, 46);
    UIButton *button1_1 = [self createButtonWithFrame: point1_1 image:[UIImage imageNamed:@"sj_1"] text:@"12个"];
    CGRect point1_2 = CGRectMake(120, 200, 46, 46);
    UIButton *button1_2 = [self createButtonWithFrame: point1_2 image:[UIImage imageNamed:@"sj_1"] text:@"15个"];
    [drawView addToList2:button1_0];
    [drawView addToList2:button1_1];
    [drawView addToList2:button1_2];
    
    CGRect point2_0 = CGRectMake(-30, 210, 1, 1);
    UIButton *button2_0 = [self createButtonWithFrame: point2_0 image:nil text:@"15个"];
    CGRect point2_1 = CGRectMake(40, 250, 46, 46);
    UIButton *button2_1 = [self createButtonWithFrame: point2_1 image:[UIImage imageNamed:@"qd_1"] text:@"12个"];
    CGRect point2_2 = CGRectMake(120, 280, 46, 46);
    UIButton *button2_2 = [self createButtonWithFrame: point2_2 image:[UIImage imageNamed:@"qd_1"] text:@"15个"];
    [drawView addToList3:button2_0];
    [drawView addToList3:button2_1];
    [drawView addToList3:button2_2];

    
    [self.scrollView addSubview:drawView];
    [self.scrollView addSubview:button0];
    [self.scrollView addSubview:button1];
    [self.scrollView addSubview:button2];
    [self.scrollView addSubview:button1_0];
    [self.scrollView addSubview:button1_1];
    [self.scrollView addSubview:button1_2];
    [self.scrollView addSubview:button2_0];
    [self.scrollView addSubview:button2_1];
    [self.scrollView addSubview:button2_2];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [self hideTabBar:NO];
    [super viewDidDisappear:animated];

}

- (UIButton*)createButtonWithFrame:(CGRect)frame image:(UIImage*)image text:(NSString*)text
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.userInteractionEnabled = NO;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.textColor = [UIColor whiteColor];
    return button;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
