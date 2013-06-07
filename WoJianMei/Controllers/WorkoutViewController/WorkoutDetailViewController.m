//
//  WorkoutDetailViewController.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-6.
//
//

#import "WorkoutDetailViewController.h"

@interface WorkoutDetailViewController ()

@end

@implementation WorkoutDetailViewController
@synthesize article =_article;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)dealloc{
    [_article release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    ///set the gobal  backbutton
    UIImage *btnTrnspBgrImg30 = [[UIImage imageNamed:@"top_bar_backButton.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:btnTrnspBgrImg30      forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [self hideTabBar];
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];



    NSString *shareurl =  [self.article  img];

    PPDebug(@"imageurl :%@",shareurl);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillDisappear:(BOOL)animated{

    
    [self showTabBar];
    [super viewWillDisappear:YES];
    
}

@end
