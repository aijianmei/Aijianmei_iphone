//
//  ChangeDescriptionViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/9/13.
//
//

#import "FeedBackViewController.h"
#import "User.h"
#import "UserService.h"
#import "Result.h"

enum errorCode {
    ERROR_SUCCESS =0,
};



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
    
    User *getuser =[[UserService defaultService] user];
    NSString  *uid =getuser.uid;
    PPDebug(@"********用户UID%@,开始信息发送反馈*******",uid);
    
    [[UserService defaultService] postFeedbackWithUid:uid
                                              content:_descriptionTextField.text
                                             delegate:self];
    
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
- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Response code: %d", [response statusCode]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)requestDidStartLoad:(RKRequest *)request
{
    NSLog(@"Start load request...");
    [self showActivityWithText:@"加载中"];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects count: %d", [objects count]);
    Result *result = [objects objectAtIndex:0];
    PPDebug(@"The error code : %@",result.errorCode);
    [self hideActivity];
    
    NSInteger errorCode =  [result.errorCode integerValue];
    
    User *user =[[UserService defaultService] user];
    NSString *uid =user.uid;
    
    if (errorCode ==ERROR_SUCCESS )
    {
        PPDebug(@"********用户UID%@,信息反馈完成*******",uid);
        [self popupHappyMessage:@"信息反馈成功" title:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
