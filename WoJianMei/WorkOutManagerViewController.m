//
//  WorkOutManagerViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/5/13.
//
//

#import "WorkOutManagerViewController.h"
#import "ImageManager.h"
#import "IIViewDeckController.h"

@interface WorkOutManagerViewController ()

@end

@implementation WorkOutManagerViewController

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
    // Do any additional setup after loading the view from its nib.
    
    ////leftBtn
    UIButton *leftBtn = [[[UIButton alloc] init] autorelease];

    [leftBtn setBackgroundImage:[ImageManager GobalNavigationLeftSideButtonImage]
                       forState:UIControlStateNormal];
    
    leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];

    

    
//    //设置应用程序的状态栏到指定的方向
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
//    //view旋转
//    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //隐藏navigationController
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //隐藏状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //显示状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    //显示navigationController
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}



- (void)leftButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}
- (void)rightButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleRightViewAnimated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
