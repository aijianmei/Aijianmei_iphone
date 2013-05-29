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


#pragma mark -
#pragma mark Hide and Show TabBar Methods

- (void)showTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0]; // UITransitionView
    UIView *window = parent.superview;
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds) - CGRectGetHeight(tabBar.frame);
                         tabBar.frame = tabFrame;
                         CGRect contentFrame = content.frame;
                         contentFrame.size.height -= tabFrame.size.height;
                     }];
}


- (void)hideTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds);
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                     }];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavigationRightButton:@"添加" imageName:@"settings.png" action:@selector(clickAddButton:)];
//    [self setNavigationLeftButton:@"返回" imageName:@"fh_1" action:@selector(clickSettingsButton:)];
    
    [self hideTabBar];

}

- (void)clickAddButton:(id)sender
{
    return;
}

- (void)removeOldData
{
    for (UIView *v in drawView.subviews) {
        [v removeFromSuperview];
    }
    [drawView removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated
{    
    [super viewDidAppear:animated];
    [self hideTabBar];
    [self removeOldData];

    drawView = [[DrawContextView alloc] initWithFrame:CGRectMake(0, 30, 320-30, [UIScreen mainScreen ].bounds.size.height-20-44-30)];
    drawView.backgroundColor = [UIColor clearColor];
   
    CGRect point1_0 = CGRectMake(40, 190, 46, 46);
    UIButton *amountButton1 = [self createButtonWithFrame: point1_0 image:[UIImage imageNamed:@"gs_1"] text:@"12个"];
    CGRect point1_1 = CGRectMake(40, 100, 46, 46);
    UIButton *timeButton1 = [self createButtonWithFrame: point1_1 image:[UIImage imageNamed:@"sj_1"] text:@"65s"];    
    CGRect point1_2 = CGRectMake(40, 250, 46, 46);
    UIButton *intensityButton1 = [self createButtonWithFrame: point1_2 image:[UIImage imageNamed:@"qd_1"] text:@"48kg"];
    [drawView addAmount:amountButton1 dayIndex:0];
    [drawView addTime:timeButton1 dayIndex:0];
    [drawView addIntensity:intensityButton1 dayIndex:0];
    
    CGRect point2_0 = CGRectMake(120, 120, 46, 46);
    UIButton *amountButton2 = [self createButtonWithFrame: point2_0 image:[UIImage imageNamed:@"gs_1"] text:@"15个"];
    CGRect point2_1 = CGRectMake(120, 200, 46, 46);
    UIButton *timeButton2 = [self createButtonWithFrame: point2_1 image:[UIImage imageNamed:@"sj_1"] text:@"48s"];
    CGRect point2_2 = CGRectMake(120, 280, 46, 46);
    UIButton *intensityButton2 = [self createButtonWithFrame: point2_2 image:[UIImage imageNamed:@"qd_1"] text:@"40kg"];
    [drawView addAmount:amountButton2 dayIndex:1];
    [drawView addTime:timeButton2 dayIndex:1];
    [drawView addIntensity:intensityButton2 dayIndex:1];
    
    [self.scrollView addSubview:drawView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}

-(void)viewWillDisappear:(BOOL)animated{

    [self showTabBar];
    [super viewWillDisappear:animated];
    
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
