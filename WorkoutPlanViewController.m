
//
//  WorkoutPlanViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 6/13/13.
//
//

#import "WorkoutPlanViewController.h"
#import "IIViewDeckController.h"

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


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initMoreUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
