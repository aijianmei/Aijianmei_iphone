//
//  ChangeDescriptionViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/9/13.
//
//

#import "FeedBackViewController.h"
#import "User.h"
#import "UserManager.h"
#import "Result.h"
#import "PPNetworkRequest.h"



@interface FeedBackViewController ()

@end

@implementation FeedBackViewController
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
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    [self setNavigationRightButton:@"发送" imageName:@"top_bar_commonButton.png" action:@selector(clickSendButton:)];
    
    
    [_descriptionTextField setDelegate:self];
    [_descriptionTextField setBackground:[UIImage imageNamed:@"description_BG.png"]];
    [_descriptionTextField setText:@"欢迎告诉我们您的意见！"];

    
    
    //停顿一会儿之后显示键盘
    float duration =0.4;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                  target:self
                                                selector:@selector(showKeyBoard)
                                                userInfo:nil
                                                 repeats:NO];
    
}

#pragma mark -
#pragma mark - clickSendButton
-(void)clickSendButton:(UIButton *)sender{
 
    [_descriptionTextField resignFirstResponder];
    
    User *getuser =[[UserManager defaultManager] user];
    NSString  *uid =getuser.uid;
    PPDebug(@"********用户UID%@,开始信息发送反馈*******",uid);
    
    [[UserService defaultService] postFeedbackWithUid:uid
                                              content:_descriptionTextField.text
                                             viewController:self];
    
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
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - RKObjectLoaderDelegate
- (void)didGetFeedbackErrorCode:(int)errorCode
{

    
    User *user =[[UserManager defaultManager] user];
    NSString *uid =user.uid;
    
    if (errorCode ==ERROR_SUCCESS )
    {
        PPDebug(@"********用户UID%@,信息反馈完成*******",uid);
        [self popupHappyMessage:@"信息反馈成功" title:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
