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
#import "WorkoutMainViewController.h"
#import "WeightManagerViewController.h"
#import "RankingViewController.h"
#import "CheckWorkoutDatasViewController.h"


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

    
    
    
    //设置顶部导航栏
//    [self setRightBarButtons];

    
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
//   [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
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

- (void)setRightBarButtons
{
    float buttonHigh = 27.5;
    float buttonLen = 47.5;
    float seporator = 5;
    float leftOffest = 20;
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    UIView *rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 3*(buttonLen+seporator) +30, buttonHigh)];
    
   
    
    UIButton *likeButton = [[UIButton alloc] initWithFrame:CGRectMake(leftOffest, 3, 22, 22)];
    [likeButton setImage:[ImageManager GobalArticelLikeButtonBG] forState:UIControlStateNormal];
    [likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [likeButton.titleLabel setFont:font];
    [likeButton addTarget:self action:@selector(clickLikeButton:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:likeButton];
    
    
    
    UIButton * commentBarButton = [[UIButton alloc] initWithFrame:CGRectMake(leftOffest+buttonLen+seporator,3, 22, 22)];
    [commentBarButton addTarget:self action:@selector(clickCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    [commentBarButton setImage:[ImageManager GobalArticelCommentButtonBG] forState:UIControlStateNormal];
    [commentBarButton setTitle:@"评论" forState:UIControlStateNormal];
    [commentBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentBarButton.titleLabel setFont:font];
    [rightButtonView addSubview:commentBarButton];
    [commentBarButton release];
    
    
    UIButton *shareBarButton = [[UIButton alloc]initWithFrame:CGRectMake(leftOffest+(buttonLen+seporator)*2 +30, 0, 22, 22)];
    [shareBarButton setImage:[ImageManager GobalArticelShareButtonBG] forState:UIControlStateNormal];
    [shareBarButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBarButton addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [shareBarButton.titleLabel setFont:font];
    [rightButtonView addSubview:shareBarButton];
    [shareBarButton release];
    
    
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]
                                       initWithCustomView:rightButtonView];
    [rightButtonView release];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    [rightBarButton release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickWeightManagerButton:(id)sender {
    
    WeightManagerViewController *control = [[WeightManagerViewController alloc]initWithNibName:@"WeightManagerViewController" bundle:nil];
    [self.navigationController pushViewController:control animated:YES];
    [control release];

}

- (IBAction)clickWorkoutManagerButton:(id)sender {
    WorkoutMainViewController *control = [[WorkoutMainViewController alloc]initWithNibName:@"WorkoutMainViewController" bundle:nil];
    [self.navigationController pushViewController:control animated:YES];
    [control release];
}

- (IBAction)clickCheckoutWorkoutDatasButton:(id)sender {
    
    
    CheckWorkoutDatasViewController *control = [[CheckWorkoutDatasViewController alloc]initWithNibName:@"CheckWorkoutDatasViewController" bundle:nil];
    [self.navigationController pushViewController:control animated:YES];
    [control release];

}








- (IBAction)clickRankingButton:(id)sender {
    RankingViewController *control = [[RankingViewController alloc]initWithNibName:@"RankingViewController" bundle:nil];
    [self.navigationController pushViewController:control animated:YES];
    [control release];
}






- (IBAction)clickMoreButton:(id)sender {
    
    
}
@end
