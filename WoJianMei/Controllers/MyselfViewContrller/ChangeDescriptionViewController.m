//
//  ChangeDescriptionViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/9/13.
//
//

#import "ChangeDescriptionViewController.h"
#import "User.h"
#import "UserService.h"

@interface ChangeDescriptionViewController ()

@end

@implementation ChangeDescriptionViewController
@synthesize descriptionTextField =_descriptionTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [_descriptionTextField release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    [self setNavigationRightButton:@"保存" imageName:@"top_bar_commonButton.png" action:@selector(clickBack:)];
    
    User *user =[[UserService defaultService] user];
    
    [_descriptionTextField setDelegate:self];
    [_descriptionTextField setText:user.description];
    [_descriptionTextField setBackground:[UIImage imageNamed:@"description_BG"]];
    [_descriptionTextField becomeFirstResponder];
    
    
}
#pragma mark -
#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    User *user =[[UserService defaultService] user];
    user.description = textField.text;
    [[UserService defaultService] setUser:user];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
