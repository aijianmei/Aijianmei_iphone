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
    //    drawView = [[DrawContextView alloc] initWithFrame:CGRectMake(0, 30, 320, [UIScreen mainScreen ].bounds.size.height-20-44-30-49)];
    //    drawView.backgroundColor = [UIColor clearColor];
    //    [self.scrollView addSubview:drawView];
    
    [self hideTabBar:YES];
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self hideTabBar:NO];
    [super viewDidDisappear:animated];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
