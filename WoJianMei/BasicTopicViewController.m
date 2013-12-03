//
//  BasicTopicViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/3/13.
//
//

#import "BasicTopicViewController.h"
#import "PostTopicViewController.h"


@interface BasicTopicViewController ()

@end

@implementation BasicTopicViewController

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
    
    
    [self initUI];
}
- (id)initUI
{
    //rightBtn
    UIButton *rightBtn = [[[UIButton alloc] init] autorelease];

    [rightBtn setBackgroundImage:[UIImage imageNamed:@"NavigationButtonBG.png"]
                        forState:UIControlStateNormal];

    [rightBtn setImage:[UIImage imageNamed:@"LeftSideViewIcon.png"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [rightBtn addTarget:self action:@selector(clickPostButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];
}


#pragma mark--
#pragma mark--ClickPostMethod
-(void)clickPostButton:(id)sender{
    
    
    PostTopicViewController *vc = [[PostTopicViewController alloc]initWithNibName:@"PostTopicViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];

}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
