//
//  WorkOutProcessViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 5/25/13.
//
//

#import "WorkOutProcessViewController.h"
#import "DrawContextView.h"

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.hidesBottomBarWhenPushed = YES;

    drawView = [[DrawContextView alloc] initWithFrame:CGRectMake(0, 30, 320, [UIScreen mainScreen ].bounds.size.height-20-44-30-49)];
    drawView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:drawView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
