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
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    [self setNavigationRightButton:@"发送" imageName:@"top_bar_commonButton.png" action:@selector(clickSendButton:)];
    
    [_descriptionTextField setDelegate:self];
    [_descriptionTextField setBackground:[UIImage imageNamed:@"description_BG"]];
    [_descriptionTextField setText:@"欢迎告诉我们您的意见！"];
    
    
    
}

#pragma mark -
#pragma mark - clickSendButton
-(void)clickSendButton:(UIButton *)sender{

    [[UserService defaultService] postFeedbackWithUid:@"2"
                                              content:@"我们可以做的更加好的！"  delegate:self];
}



#pragma mark -
#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    User *user =[[UserService defaultService] user];
    [user setDescription: textField.text];
    [[UserService defaultService] setUser:user];
        
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
    
    if (errorCode ==ERROR_SUCCESS )
    {
        PPDebug(@"信息反馈完成");
    
    }
    
}


@end
