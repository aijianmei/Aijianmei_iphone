//
//  CompostViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/20/13.
//
//

#import "CompostViewController.h"
#import "ComposeViewCell.h"
#import "ComposeViewCellInfo.h"

enum BUTTON_TYPE {
    
    BUTTON_TYPE_ONE = 0,
    BUTTON_TYPE_TWO,
    BUTTON_TYPE_THREE,
    BUTTON_TYPE_FOUR,
    BUTTON_TYPE_FIVE
};


@interface CompostViewController ()

@end

@implementation CompostViewController
@synthesize textView, textAccessoryView;


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
	// Do any additional setup after loading the view.
    [self initDatas];
    [self setBackgroundImageName:@"BackGround.png"];
    [self showBackgroundImage];
    
    NSArray *array  = [NSArray arrayWithObjects:@"微博",@"爱问",@"预约", nil] ;
    
    
    [self createDefaultNavigationTitleToolbar: array defaultSelectIndex:0];

    [self setNavigationLeftButton:@"返回" imageName:@"back_composeView.png" action:@selector(didClickBackButton:)];
    
    [self setNavigationRightButton:@"发送" imageName:@"setting.png" action:@selector(didClickBackButton:)];
    
    // Observe keyboard hide and show notifications to resize the text view appropriately.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   
    textView.delegate = self;
}


-(void)didClickBackButton:(UIButton *)button{
    
    

}


- (IBAction)tappedMe:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    NSArray *textViewSubviews = [textView subviews];
    NSLog(@"This is the Button %@ at index %d",[textViewSubviews objectAtIndex:[button tag]],[button tag]);
    
    NSInteger  BUTTON_TYPE = [button tag];
    switch (BUTTON_TYPE) {
        case BUTTON_TYPE_ONE:
        {
            PPDebug(@"Button %d",[button tag]);
            [self didclickChooseImagesButotn];
            
        }
            break;
        case BUTTON_TYPE_TWO:
        {
            PPDebug(@"Button %d",[button tag]);

        }
            break;
        case BUTTON_TYPE_THREE:
        {
            PPDebug(@"Button %d",[button tag]);

        }
            break;
        case BUTTON_TYPE_FOUR:
        {
            PPDebug(@"Button %d",[button tag]);

        }
            break;
        case BUTTON_TYPE_FIVE:
        {
            PPDebug(@"Button %d",[button tag]);
            [textView resignFirstResponder];
        }
            break;
        default:
            break;
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.textView = nil;
    self.textAccessoryView = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    
    // Make the keyboard appear when the application launches.
    [super viewWillAppear:animated];
//     [textView becomeFirstResponder];
    
    
}


#pragma mark -
#pragma mark Text view delegate methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)aTextView {
    
    /*
     You can create the accessory view programmatically (in code), in the same nib file as the view controller's main view, or from a separate nib file. This example illustrates the latter; it means the accessory view is loaded lazily -- only if it is required.
     */
    
    if (textView.inputAccessoryView == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"AccessoryView" owner:self options:nil];

        textView.inputAccessoryView = textAccessoryView;

        // Loading the AccessoryView nib file sets the accessoryView outlet.
//        textView.inputAccessoryView = accessoryView;
        // After setting the accessory view for the text view, we no longer need a reference to the accessory view.
        self.textAccessoryView = nil;
    }
    
    return YES;
}


- (BOOL)textViewShouldEndEditing:(UITextView *)aTextView {
    [aTextView resignFirstResponder];
    return YES;
}


#pragma mark -
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    textView.frame = newTextViewFrame;
    
    [UIView commitAnimations];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    textView.frame = self.view.bounds;
    [UIView commitAnimations];
}






#pragma mark -
#pragma mark - ImagePickerControllerDelegate
-(void)didclickChooseImagesButotn{
    
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"照相"
                                              otherButtonTitles:@"相册",nil];
    [share showInView:self.view];
    [share release];
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image != nil){
        
        PPDebug(@"You have chosen a image ");
    }
    
    [self.navigationController dismissModalViewControllerAnimated:YES
     ];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}


#pragma mark --actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    enum ACTION_SHEET_ACTION_TYPE {
        TAKE_PICTURES =0,
        CHOOSE_FROM_ALBLUM
        
    };
    
    NSInteger ACTION_SHEET_ACTION_TYPE = buttonIndex;
    switch (ACTION_SHEET_ACTION_TYPE) {
        case TAKE_PICTURES:
        {
            [self takePhoto];
        }
            break;
        case CHOOSE_FROM_ALBLUM:
        {
            [self  selectPhoto];
            
        }
            break;
        case 2:
            
        {
            NSLog(@"Button index :%d",buttonIndex);
        }
            break;
        default:
            break;
    }
}

#pragma mark --
#pragma mark --UITableViewDeleageMethod

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{


}


-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    return  [ComposeViewCell getCellHeight];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataList count];;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ComposeViewCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:[ComposeViewCell getCellIdentifier]];
    
    // Configure the cell...
    if (cell) {
        
        cell = [[[ComposeViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:[ComposeViewCell getCellIdentifier]] autorelease];
                       
    }
    
    cell.delegate = self;
    [cell.textLabel setText:@"hihihihiihihihihhi"];
    
    return cell;
    
}

-(void)initDatas{
    
    ComposeViewCellInfo *sinaInfo = [[ComposeViewCellInfo alloc]init];
    sinaInfo.name = @"同步到新浪微博";
    sinaInfo.avatarImageName =@"sina_weibo.png";
    sinaInfo.connectButtonName = @"tick_frame.png";
    
    ComposeViewCellInfo *tencentQQInfo = [[ComposeViewCellInfo alloc]init];
    tencentQQInfo.name = @"同步到腾讯QQ";
    tencentQQInfo.avatarImageName =@"sina_weibo.png";
    tencentQQInfo.connectButtonName = @"tick_frame.png";
    
    ComposeViewCellInfo *tencentWeiBoInfo = [[ComposeViewCellInfo alloc]init];
    tencentWeiBoInfo.name = @"同步到腾讯微博";
    tencentWeiBoInfo.avatarImageName =@"sina_weibo.png";
    tencentWeiBoInfo.connectButtonName = @"tick_frame.png";
    
    
    NSMutableArray *array = [[NSMutableArray  alloc]initWithCapacity:3];
    
    [array         addObject:sinaInfo];
    [array    addObject:tencentQQInfo];
    [array addObject:tencentWeiBoInfo];
    
    [sinaInfo         release];
    [tencentQQInfo    release];
    [tencentWeiBoInfo release];
    
    self.dataList = array;
    [array release];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
