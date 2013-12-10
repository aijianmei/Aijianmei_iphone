//
//  PostTopicViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/3/13.
//
//

#import "PostTopicViewController.h"
#import "VotesViewController.h"


@interface PostTopicViewController ()

@end

@implementation PostTopicViewController

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

    
    
    //rightBtn
    UIButton *rightBtn = [[[UIButton alloc] init] autorelease];
    
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"NavigationButtonBG.png"]
                        forState:UIControlStateNormal];
    
    [rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [rightBtn setTitle:@"发布" forState: UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];

}

-(void)clickDoneButton:(UIButton *)sender{
    
    [self popupHappyMessage:@"亲!发布内容不能够为空!" title:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickPickImagesButton:(id)sender {
    
    
    [self selectPhoto];
}

- (IBAction)clickVotesButton:(id)sender {
    
    VotesViewController *vc = [[VotesViewController alloc]initWithNibName:@"VotesViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
}
@end
