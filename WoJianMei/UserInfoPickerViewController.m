//
//  GenderViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/8/13.
//
//

#import "UserInfoPickerViewController.h"
#import "UserService.h"
#import "User.h"

@interface UserInfoPickerViewController ()

@end

@implementation UserInfoPickerViewController

@synthesize femaleButton =_femaleButton;
@synthesize maleButton =_maleButton;
@synthesize buttonBack =_buttonBack;
@synthesize buttonForward =_buttonForward;
@synthesize finishButton =_finishButton;
@synthesize weightLabel =_weightLabel;
@synthesize heightLabel =_heightLabel;
@synthesize ageLabel =_ageLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc {
    [_femaleButton release];
    [_maleButton release];
    [_buttonForward release];
    [_buttonBack release];
    [_finishButton release];
    [_weightLabel release];
    [_heightLabel release];
    [_ageLabel release];
    [super dealloc];

}


-(void)clickFemaleButton:(id)sender{
     
     User *user = [[UserService defaultService] user];
     [user setGender:@"0"];
    [[UserService defaultService] storeUserInfoByUid:user.uid];

}
-(void)clickMaleButton:(id)sender{
    User *user = [[UserService defaultService] user];
    [user setGender:@"1"];
    [[UserService defaultService] storeUserInfoByUid:user.uid];
    
}

-(void)clickForwardButton:(id)sender{
    
    
}
-(void)clickBackButton:(id)sender{
    
    
}


-(void)initUI{
    
    self.femaleButton  =[[UIButton alloc] init];
    [self.femaleButton addTarget:self action:@selector(clickFemaleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.maleButton    =[[UIButton alloc] init];
    [self.maleButton addTarget:self action:@selector(clickMaleButton:) forControlEvents:UIControlEventTouchUpInside];

    self.buttonForward =[[UIButton alloc] init];
    [self.buttonForward addTarget:self action:@selector(clickForwardButton:) forControlEvents:UIControlEventTouchUpInside];

    self.buttonBack    =[[UIButton alloc] init];
    [self.buttonBack addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.weightLabel   =[[UILabel  alloc]  init];
    self.heightLabel   =[[UILabel  alloc]  init];
    self.ageLabel      =[[UILabel  alloc]  init];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    [self initUI];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
