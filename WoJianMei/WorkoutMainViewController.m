//
//  WorkoutMainViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/13/13.
//
//

#import "WorkoutMainViewController.h"
#import "NumberDataViewController.h"
#import "SDSegmentedControl.h"

@interface WorkoutMainViewController ()

@end

@implementation WorkoutMainViewController
@synthesize numberDataViewController =_numberDataViewController;
@synthesize segmentedController =_segmentedController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    
    [_numberDataViewController release];
    [_segmentedController release];
    [super dealloc];

}
//默认为No
- (BOOL)shouldAutorotate{
    return NO;
}


#pragma mark-- addButtonSegcontrol  Method
-(void)addButtonControl{
    ////Configure The Buttons
    
    NSArray *buttonTitleArray =[NSArray arrayWithObjects:@"最新文章",@"最章",@"最新视频",@"最热视频", nil];
    

    self.segmentedController=[[SDSegmentedControl alloc]initWithItems:buttonTitleArray];
    [_segmentedController setFrame:CGRectMake(0, 0, 480, 40)];
    [_segmentedController setSelectedSegmentIndex:0];
    [_segmentedController addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventValueChanged];
    [_segmentedController setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.view addSubview:_segmentedController];

}

#pragma mark-- ButtonClicked Method
-(void)buttonClicked:(SDSegmentedControl *)sender{



}

//点击页面的时候要隐藏键盘
-(void)tap{
    
    TPKeyboardAvoidingTableView *tableView =  (TPKeyboardAvoidingTableView *)self.numberDataViewController.dataTableView;
    [tableView  hideKeyboard];

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //设置应用程序的状态栏到指定的方向
   [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    
    
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    //view旋转
    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    
    [self addButtonControl];
    
    if (self.numberDataViewController ==nil) {
         NumberDataViewController *numberDataView =[[NumberDataViewController alloc]initWithNibName:@"NumberDataViewController" bundle:nil];
        self.numberDataViewController =numberDataView;
    }
    
    [_numberDataViewController.view setFrame:CGRectMake(80, 50, 474, 285)];
    [self.view addSubview:_numberDataViewController.view];
        
    
        
    //轻触手势（单击）
    UITapGestureRecognizer *tapCgr=nil;
    tapCgr=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                  action:@selector(tap)];
    tapCgr.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tapCgr];
    [tapCgr release];

}

-(void)viewWillAppear:(BOOL)animated
{
    //隐藏navigationController
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    //显示navigationController
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

//返回前一页
- (IBAction)clickBack:(id)sender {
    
    
    TPKeyboardAvoidingTableView *tableView =  (TPKeyboardAvoidingTableView *)self.numberDataViewController.dataTableView;
    
    if (tableView._keyboardVisible) {
        //隐藏键盘
        [self tap];
        
        //停顿一会儿之后显示键盘
        float duration =0.7;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                      target:self
                                                    selector:@selector(popToRootView)
                                                    userInfo:nil
                                                     repeats:NO];
    }else{
    
        [self popToRootView];
    
    }

}

-(void)popToRootView{

    [self.timer invalidate];
    //状态栏旋转
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    [self.navigationController popToRootViewControllerAnimated:YES];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
