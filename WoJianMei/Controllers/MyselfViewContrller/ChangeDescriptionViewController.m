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
    [_descriptionTextField setBackground:[UIImage imageNamed:@"description_BG"]];
    [_descriptionTextField setText:user.description];
    [_descriptionTextField setFont:[UIFont systemFontOfSize:15]];

    
    
    //停顿一会儿之后显示键盘
    float duration =0.4;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                  target:self
                                                selector:@selector(showKeyBoard)
                                                userInfo:nil
                                                 repeats:NO];
 
    
    
    
    //轻触手势（单击，双击）
    UITapGestureRecognizer *tapCgr=nil;
    tapCgr=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                  action:@selector(tap)];
    tapCgr.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tapCgr];
    [tapCgr release];

    
    
}

#pragma mark -
#pragma mark - ShowKeyBoard Method
-(void)tap{
    [_descriptionTextField resignFirstResponder];
    
}
#pragma mark -
#pragma mark - ShowKeyBoard Method
-(void)showKeyBoard{
        [_descriptionTextField becomeFirstResponder];
        [self.timer invalidate];

    
}
#pragma mark -
#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    User *user =[[UserService defaultService] user];
    [user setDescription: textField.text];
    [[UserService defaultService] setUser:user];
    [[UserService defaultService] storeUserInfoByUid:user.uid];

        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
