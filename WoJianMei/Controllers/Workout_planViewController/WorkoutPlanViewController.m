
//
//  WorkoutPlanViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 6/13/13.
//
//

#import "WorkoutPlanViewController.h"
#import "IIViewDeckController.h"
#import "ImageManager.h"
#import "IIViewDeckController.h"
#import "AppDelegate.h"
#import "PublicMyselfViewController.h"
#import "Myself_SettingsViewController.h"



@interface WorkoutPlanViewController ()

@end

@implementation WorkoutPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
    }
    return self;
}


- (void)initMoreUI
{
    ////leftBtn
    UIButton *leftBtn = [[[UIButton alloc] init] autorelease];
    [leftBtn setImage:[ImageManager GobalNavigationLeftSideButtonImage] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    
    ////rightBtn
    UIButton *rightBtn = [[[UIButton alloc] init] autorelease];
    [rightBtn setImage:[ImageManager GobalNavigationAvatarImage] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0.0, 0.0, 49.0, 29.0);
    [rightBtn addTarget:self action:@selector(rightButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPad)
    {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.shadowColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:22];
        self.navigationItem.titleView = label;
        [label release];
    }
}
- (void)leftButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}


- (void)rightButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleRightViewAnimated:YES];
    
    
    User *user = [[UserService defaultService] user];
    
    if (user.uid) {
        
        
        //    PublicMyselfViewController *publicStatusViewController = [[AppDelegate getAppDelegate] initPublicStatusViewController];
        //    [self.navigationController pushViewController:publicStatusViewController animated:YES];
        
        Myself_SettingsViewController *vc =[[Myself_SettingsViewController alloc]initWithNibName:@"Myself_SettingsViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
    }else{
        
        [[AppDelegate  getAppDelegate] showLoginView];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    
    [self initMoreUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
