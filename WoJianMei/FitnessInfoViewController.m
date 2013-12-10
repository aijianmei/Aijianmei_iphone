//
//  FitnessInfoViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "FitnessInfoViewController.h"
#import "IIViewDeckController.h"
#import "ImageManager.h"
#import "AppDelegate.h"


#import "HomeViewController.h"
#import "WorkoutViewController.h"
#import "WorkoutPlanViewController.h"
#import "NutriViewController.h"
#import "SupplementViewController.h"
#import "LifeStytleViewController.h"


@interface FitnessInfoViewController ()

@end

@implementation FitnessInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc {
    
    [_homeViewController release];
    [_workoutPlanViewController release];
    [_workoutViewController release];
    [_nutriViewController release];
    [_supplementViewController release];
    [_lifeStytleViewController release];
    
    [super dealloc];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    ////leftBtn
    UIButton *leftBtn = [[[UIButton alloc] init] autorelease];
    [leftBtn setImage:[ImageManager GobalNavigationLeftSideButtonImage] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    
    
    [self initHomeViewController];
}

- (void)leftButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

#pragma mark --
#pragma mark - initViewControllers
-(void)initHomeViewController
{
    if (self.homeViewController ==nil) {
        HomeViewController *vc =[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    self.homeViewController = vc;
        
        self.homeViewController.title = @"首页";

        [vc release];
    }
    [self.homeViewController.view setFrame:CGRectMake(0, 50, self.homeViewController.view.frame.size.width, self.homeViewController.view.frame.size.height)];
    
    [self.view insertSubview:self.homeViewController.view atIndex:1];
    
}

-(void)initWorkoutPlanViewController{
    if (self.workoutPlanViewController ==nil) {
        WorkoutPlanViewController *vc =[[WorkoutPlanViewController alloc] initWithNibName:@"WorkoutPlanViewController" bundle:nil];
        self.workoutPlanViewController =vc;
        [vc release];
        self.workoutPlanViewController.title = @"健身计划";
    }
    
    [self.workoutPlanViewController.view setFrame:CGRectMake(0, 50, self.workoutPlanViewController.view.frame.size.width, self.workoutPlanViewController.view.frame.size.height)];

    [self.view insertSubview:self.workoutPlanViewController.view atIndex:1];
}


-(void)initWorkOutViewController{
    
    if (self.workoutViewController ==nil) {
        
        WorkoutViewController *vc =[[WorkoutViewController alloc] initWithNibName:@"WorkoutViewController" bundle:nil];
        self.workoutViewController =vc;
        [vc release];
        self.workoutViewController.title = @"锻炼";
    }
    
    [self.workoutViewController.view setFrame:CGRectMake(0, 50, self.homeViewController.view.frame.size.width, self.homeViewController.view.frame.size.height)];

    [self.view insertSubview:self.workoutViewController.view atIndex:1];

}
-(void)initSupplementViewController{
    if (self.supplementViewController ==nil) {
        
        self.supplementViewController =[[SupplementViewController alloc] initWithNibName:@"SupplementViewController" bundle:nil];
        self.supplementViewController.title = @"补充";
        
    }
    [self.supplementViewController.view setFrame:CGRectMake(0, 50, self.supplementViewController.view.frame.size.width, self.supplementViewController.view.frame.size.height)];

    [self.view insertSubview:self.supplementViewController.view atIndex:1];
    
}
-(void)initNutriViewController{
    
    if (self.nutriViewController ==nil) {
        
        self.nutriViewController =[[NutriViewController alloc] initWithNibName:@"NutriViewController" bundle:nil];
        self.nutriViewController.title = @"营养";
    }
    
    [self.nutriViewController.view setFrame:CGRectMake(0, 50, self.homeViewController.view.frame.size.width, self.homeViewController.view.frame.size.height)];

    [self.view insertSubview:self.nutriViewController.view atIndex:1];
    
}

-(void)initLifeStytleViewController{
    
    if (self.lifeStytleViewController ==nil) {
        
        self.lifeStytleViewController =[[LifeStytleViewController alloc] initWithNibName:@"LifeStytleViewController" bundle:nil];
        self.lifeStytleViewController.title = @"生活方式";
    }
    [self.lifeStytleViewController.view setFrame:CGRectMake(0, 50, 320, 9000)];

    [self.view insertSubview:self.lifeStytleViewController.view atIndex:1];
    
}


- (IBAction)clickFitnessMenueButton:(UIButton *)sender {
  
    
    typedef enum{
        
        //draw main menu
        FitnessMenuTypeHome = 1000,
        FitnessMenuTypeWorkout,
        FitnessMenuTypePlan,
        FitnessMenuTypeNutri,
        FitnessMenuTypeSupplement,
        FitnessMenuTypeLifeStyle,

    } FitnessInfoMenuType;

    
    [self.homeViewController.view removeFromSuperview];
    [self.workoutPlanViewController.view removeFromSuperview];
    [self.workoutViewController.view removeFromSuperview];
    [self.nutriViewController.view removeFromSuperview];
    [self.supplementViewController.view removeFromSuperview];
    [self.lifeStytleViewController.view removeFromSuperview];

    
    switch (sender.tag) {
        case FitnessMenuTypeHome:
        {
            PPDebug(@"%d",sender.tag);
            
            [self initHomeViewController];
            
        }
            break;
       
        case FitnessMenuTypePlan:
        {
            PPDebug(@"%d",sender.tag);
            [self initWorkoutPlanViewController];

        }
            break;
        case FitnessMenuTypeWorkout:
        {
            PPDebug(@"%d",sender.tag);
            [self initWorkOutViewController];
            
        }
            break;

        case FitnessMenuTypeNutri:
        {
            PPDebug(@"%d",sender.tag);
            [self initNutriViewController];

        }
            break;
        case FitnessMenuTypeSupplement:
        {
            PPDebug(@"%d",sender.tag);
            [self initSupplementViewController];

        }
            break;
        case FitnessMenuTypeLifeStyle:
        {
            PPDebug(@"%d",sender.tag);
            [self initLifeStytleViewController];

        }
            break;
        default:
            break;
    }
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
