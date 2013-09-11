//
//  BMIViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/2/13.
//
//

#import "BMIViewController.h"

@interface BMIViewController ()

@end

@implementation BMIViewController

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
 
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
//    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    [self setNavigationRightButton:@"" imageName:@"top_bar_commonButton.png" action:@selector(clickDismissButton:)];
}

-(void)clickDismissButton:(id)sender{

    [self dismissModalViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
