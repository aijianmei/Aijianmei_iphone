//
//  AboutViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/21/12.
//
//

#import "AboutViewController.h"
#import "DeviceDetection.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize versionLable =_versionLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{

    [_versionLabel release];
    [super dealloc];

}

-(void)viewDidUnload{
    
    [self setVersionLable:nil];
    [super viewDidUnload];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    
    [self setBackgroundImageName:@"gobal_background.png"];
    
    
    if([DeviceDetection isIPhone5])
    {
        [self setBackgroundImageName:@"640X1136.png"];
    }
    else
    {
        [self setBackgroundImageName:@"640X960.png"];
    }
    [self showBackgroundImage];
    
    
    
    
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    [self setTitle:@"关于我们"];
    NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    NSString *versionNumber = [NSString stringWithFormat:@"%@版本",localVersion];
    [self.versionLable setText:versionNumber];
    [self.versionLable setTextColor:[UIColor whiteColor]];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
	// Do any additional setup after loading the view.
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
