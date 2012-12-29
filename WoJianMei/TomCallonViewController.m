//
//  TomCallonViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TomCallonViewController.h"
#import "TKAlertCenter.h"
#import <MessageUI/MessageUI.h>
#import "AGIPCToolbarItem.h"




@interface TomCallonViewController ()

@end

@implementation TomCallonViewController
@synthesize loadingView =_loadingView;
@synthesize alertView =_alertView;
@synthesize  backgroundImageName =_backgroundImageName;
@synthesize imagefromPicker = _imagefromPicker;
@synthesize imageArrayFromImagePicker = _imageArrayFromImagePicker;





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
    

    self.imageArrayFromImagePicker = [NSMutableArray array];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
#pragma mark activity loading view

- (TKLoadingView*)getActivityViewWithText:(NSString*)loadingText withCenter:(CGPoint)point
{
	if (_loadingView == nil){
		self.loadingView = [[[TKLoadingView alloc] initWithTitle:@"" message:loadingText] autorelease];
        _loadingView.center = point;
		[self.view addSubview:_loadingView];
	}
	
	return _loadingView;
}

- (TKLoadingView*)getActivityViewWithText:(NSString*)loadingText
{
	if (_loadingView == nil){
		self.loadingView = [[[TKLoadingView alloc] initWithTitle:@"" message:loadingText] autorelease];
        _loadingView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2+10);
		[self.view addSubview:_loadingView];
	}
	
	return _loadingView;
}

- (void)showActivityWithText:(NSString*)loadingText withCenter:(CGPoint)point
{
	_loadingView = [self getActivityViewWithText:loadingText withCenter:point];
	[_loadingView setMessage:loadingText];
	[_loadingView startAnimating];
	_loadingView.hidden = NO;
}

- (void)showActivityWithText:(NSString*)loadingText
{
	_loadingView = [self getActivityViewWithText:loadingText];
	[_loadingView setMessage:loadingText];
	[_loadingView startAnimating];
	_loadingView.hidden = NO;
    [self.view bringSubviewToFront:_loadingView];
}

- (void)showActivity
{
    [self showActivityWithText:@""];;
}

- (void)hideActivity
{
	[_loadingView stopAnimating];
	_loadingView.hidden = YES;
}

#pragma mark background selector execution

- (void)performSelectorStopLoading:(NSString*)selectorString
{
	[self performSelector:NSSelectorFromString(selectorString) withObject:nil];
	[self hideActivity];
}

- (void)performSelectorWithLoading:(SEL)aSelector loadingText:(NSString*)loadingText
{	
	[self performSelector:@selector(performSelectorStopLoading:) withObject:NSStringFromSelector(aSelector) afterDelay:0.0];
	CGPoint point = CGPointMake(160, 290);
    [self showActivityWithText:loadingText withCenter:point];
}


#pragma mark background and navigation bar buttons

#define	kAlertViewShowTimerInterval		2

- (void)popupMessage:(NSString*)msg title:(NSString*)title
{
    
    //	if (self.alertView == nil){
    //        // TODO why cannot autorelease AlertView, crash if using autorelease here
    //		self.alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    //	}
    //	else {
    //		[self.alertView dismissWithClickedButtonIndex:0 animated:NO];
    //		[alertView setMessage:msg];
    //		[alertView setTitle:title];
    //	}
    //
    //    NSLog(@"alert view retain count=%d", [alertView retainCount]);
    //
    //	[alertView show];
    //	[NSTimer scheduledTimerWithTimeInterval:kAlertViewShowTimerInterval target:self selector:@selector(dismissAlertView:) userInfo:nil repeats:NO];
    
    if (title == nil){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:msg];
    }
    else if (msg == nil){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:title];
    }
    else{
        [[TKAlertCenter defaultCenter] postAlertWithMessage:
         [NSString stringWithFormat:@"%@", msg]];
    }
}

- (void)popupHappyMessage:(NSString*)msg title:(NSString*)title
{
//	NSString* newMsg = [NSString stringWithFormat:@"%@ %@", kHappyFace, msg];
//	[self popupMessage:newMsg title:title];
}

- (void)popupUnhappyMessage:(NSString*)msg title:(NSString*)title
{
//	NSString* newMsg = [NSString stringWithFormat:@"%@ %@", kUnhappyFace, msg];
//	[self popupMessage:newMsg title:title];
    
}

- (void)dismissAlertView:(id)sender
{
    NSLog(@"alert view retain count=%d", [_alertView retainCount]);
	[self.alertView dismissWithClickedButtonIndex:0 animated:NO];
}



- (void)showBackgroundImage
{
//	[self.view setBackgroundImageView:self.backgroundImageName];
//	
//	if ([self respondsToSelector:@selector(dataTableView)]){
//		UITableView* tableView = [self performSelector:@selector(dataTableView)];
//		tableView.backgroundColor = [UIColor clearColor];
//	}
}

- (void)setNavigationLeftButton:(NSString*)title imageName:(NSString*)imageName action:(SEL)action
{
//	UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc]
//                                      initWithCustomView:[UIBarButtonItem getButtonWithTitle:title
//                                                                                   imageName:imageName
//                                                                                      target:self
//                                                                                      action:action]
//                                      ];
//	
//	self.navigationItem.leftBarButtonItem = barButtonItem;
//	[barButtonItem release];
	
}

#define INSET_TOP 12
#define INSET_LEFT 10

- (UIButton *)createButtonWithTitle:(NSString*)title imageName:(NSString*)imageName target:(id)target action:(SEL)action
{
	UIButton* button = [[[UIButton alloc] init] autorelease];
    UIImage* image = [UIImage imageNamed:imageName];
	[button setImage:image forState:UIControlStateNormal];
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
	button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    CGRect rect = CGRectMake(0, 0, image.size.width + INSET_LEFT, image.size.height + INSET_TOP);
    button.frame = rect;
	return button;
}

- (void)setNavigationLeftButton:(NSString*)title imageName:(NSString*)imageName action:(SEL)action hasEdgeInSet:(BOOL)hasEdgeInSet
{
    UIButton* button = [self createButtonWithTitle:title imageName:imageName target:self action:action];
    [button setImageEdgeInsets:UIEdgeInsetsMake(INSET_TOP, INSET_LEFT, 0, 0)];
    
	UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	[barButtonItem release];
}

- (void)setNavigationRightButton:(NSString*)title imageName:(NSString*)imageName action:(SEL)action
{
//	UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc]
//                                      initWithCustomView:[UIBarButtonItem getButtonWithTitle:title
//                                                                                   imageName:imageName
//                                                                                      target:self
//                                                                                      action:action]
//                                      ];
//	
//	self.navigationItem.rightBarButtonItem = barButtonItem;
//	[barButtonItem release];
}

- (void)setNavigationRightButton:(NSString*)title imageName:(NSString*)imageName action:(SEL)action hasEdgeInSet:(BOOL)hasEdgeInSet
{
    UIButton* button = [self createButtonWithTitle:title imageName:imageName target:self action:action];
    [button setImageEdgeInsets:UIEdgeInsetsMake(INSET_TOP, 0, 0, INSET_LEFT)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(INSET_TOP, 0, 0, INSET_LEFT)];
    
	UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	self.navigationItem.rightBarButtonItem = barButtonItem;
	[barButtonItem release];
}

- (void)setNavigationRightButton:(NSString*)title image:(UIImage*)strectableImage action:(SEL)action hasEdgeInSet:(BOOL)hasEdgeInSet
{
    UIButton* button = [self createButtonWithTitle:title imageName:nil target:self action:action];
    [button setContentEdgeInsets:UIEdgeInsetsMake(INSET_TOP, 0, 0, INSET_LEFT)];
    [button setBackgroundImage:strectableImage forState:UIControlStateNormal];
    
	UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
	self.navigationItem.rightBarButtonItem = barButtonItem;
	[barButtonItem release];
}


- (void)setNavigationRightButton:(NSString*)title action:(SEL)action
{
	UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:self action:action];
	
	self.navigationItem.rightBarButtonItem = barButtonItem;
	[barButtonItem release];
}

- (void)setNavigationLeftButton:(NSString*)title action:(SEL)action
{
	UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:self action:action];
	
	self.navigationItem.leftBarButtonItem = barButtonItem;
	[barButtonItem release];
}



- (void)setNavigationRightButtonWithSystemStyle:(UIBarButtonSystemItem)systemItem action:(SEL)action
{
	UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:self action:action];
	self.navigationItem.rightBarButtonItem = barButtonItem;
	[barButtonItem release];
}

- (void)setNavigationLeftButtonWithSystemStyle:(UIBarButtonSystemItem)systemItem action:(SEL)action
{
	UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:self action:action];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	[barButtonItem release];
}

- (void)setNavigationTitle:(NSString*)title textColor:(UIColor*)textColor textFont:(UIFont*)textFont
{
    
//	[self.navigationItem setRichTextTitleView:title
//									textColor:textColor
//										 font:textFont];
}



-(void)setNavigationLeftButtonHidden:(BOOL)hidden{
    
    [self.navigationItem setLeftBarButtonItem:nil];

}
-(void)setNavigationRightButtonHidden:(BOOL)hidden{
    
    [self.navigationItem setRightBarButtonItem:nil];
    
}


#pragma mark SMS Methods

-(void)sendSms:(NSString*)receiver body:(NSString*)body
{
	NSLog(@"<sendSms> receiver=%@, body=%@", receiver, body);
	MFMessageComposeViewController* vc = [[MFMessageComposeViewController alloc] init];
    vc.messageComposeDelegate = self;
	vc.body = body;
    
    if (receiver){
        vc.recipients = [NSArray arrayWithObject:receiver];
    }
    else{
        vc.recipients = nil;
    }
	
	if ([MFMessageComposeViewController canSendText] == NO){
		return;
	}
	
	[self presentModalViewController:vc animated:YES];
}

-(void)sendSmsWithReceivers:(NSArray*)receivers body:(NSString*)body
{
	NSLog(@"<sendSms> receiver=%@, body=%@", [receivers description], body);
	MFMessageComposeViewController* vc = [[[MFMessageComposeViewController alloc] init] autorelease];
	vc.messageComposeDelegate = self;
	vc.body = body;
	vc.recipients = receivers;
	
	if ([MFMessageComposeViewController canSendText] == NO){
		return;
	}
	
	[self presentModalViewController:vc animated:YES];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	NSLog(@"<sendSms> result=%d", result);
	[self dismissModalViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark Workaround

// Launches the Mail application on the device.
-(void)launchMailAppOnDeviceTo:(NSString*)toRecipient
				  ccRecipients:(NSArray*)ccRecipients
//				 bccRecipients:(NSArray*)bccRecipients
					   subject:(NSString*)subject
						  body:(NSString*)body
//						isHTML:(BOOL)isHTML
//					  delegate:(id)delegate
{
	
	// compose cc string
	NSMutableString* ccString = [[NSMutableString alloc] init];
	int index = 0;
	for (NSString* cc in ccRecipients){
		if (index > 0)
			[ccString appendFormat:@",%@", cc];
		else
			[ccString appendFormat:@"%@", cc];
		index ++;
	}
	
	NSString *email = [NSString stringWithFormat:@"mailto:%@?cc=%@&subject=%@&body=%@", toRecipient, ccString, subject, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
	
	[ccString release];
}

- (BOOL)sendEmailTo:(NSArray*)toRecipients
	   ccRecipients:(NSArray*)ccRecipients
	  bccRecipients:(NSArray*)bccRecipients
			subject:(NSString*)subject
			   body:(NSString*)body
			 isHTML:(BOOL)isHTML
		   delegate:(id)delegate
{
	NSString* firstRecipient = @"";
	if (toRecipients && [toRecipients count] > 0)
		firstRecipient = [toRecipients objectAtIndex:0];
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheetTo:toRecipients ccRecipients:ccRecipients bccRecipients:bccRecipients subject:subject body:body isHTML:isHTML delegate:delegate];
		}
		else
		{
			[self launchMailAppOnDeviceTo:firstRecipient ccRecipients:ccRecipients subject:subject body:body];
		}
	}
	else
	{
		[self launchMailAppOnDeviceTo:firstRecipient ccRecipients:ccRecipients subject:subject body:body];
	}
	
	return YES;
}

#pragma mark Email Methods

- (void)displayComposerSheetTo:(NSArray*)toRecipients
				  ccRecipients:(NSArray*)ccRecipients
				 bccRecipients:(NSArray*)bccRecipients
					   subject:(NSString*)subject
						  body:(NSString*)body
						isHTML:(BOOL)isHTML
					  delegate:(id)delegate

{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	
	if (delegate != nil){
		picker.mailComposeDelegate = delegate;
	}
	else {
		picker.mailComposeDelegate = self;
	}
    
	
	[picker setSubject:subject];
	
	[picker setToRecipients:toRecipients];
	[picker setCcRecipients:ccRecipients];
	[picker setBccRecipients:bccRecipients];
	
	// Attach an image to the email, not used
	//	NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
	//    NSData *myData = [NSData dataWithContentsOfFile:path];
	//	[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
	
	// Fill out the email body text
	[picker setMessageBody:body isHTML:isHTML];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
// This method is mainly for copy & paste
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	NSString* text = nil;
	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			text = @"<MFMailComposeViewController.didFinishWithResult> Result: canceled";
			break;
		case MFMailComposeResultSaved:
			text = @"<MFMailComposeViewController.didFinishWithResult> Result: saved";
			break;
		case MFMailComposeResultSent:
			text = @"<MFMailComposeViewController.didFinishWithResult> Result: sent";
			break;
		case MFMailComposeResultFailed:
			text = @"<MFMailComposeViewController.didFinishWithResult> Result: failed";
			break;
		default:
			text = @"<MFMailComposeViewController.didFinishWithResult> Result: not sent";
			break;
	}
	
	NSLog(@"%@", text);
	[self dismissModalViewControllerAnimated:YES];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - static method

//if buttonSeparatorY < 0, we will use the default value.
+ (UIScrollView*)createButtonScrollViewByButtonArray:(NSArray*)buttons
                                      buttonsPerLine:(int)buttonsPerLine buttonSeparatorY:(CGFloat)buttonSeparatorY
{
    float buttonLen;
    float buttonHeight;
    int fitButtonsPerLine;
    int rowIndex;
    int columnIndex;
    UIScrollView* scrollView = [[[UIScrollView alloc] init] autorelease];
    
    if (buttons && [buttons count]>0) {
        UIButton* button1 = [buttons objectAtIndex:0];
        buttonLen = button1.frame.size.width;
        buttonHeight = button1.frame.size.height;
        fitButtonsPerLine = 320/buttonLen;
    }
    
    
    if (buttonLen*buttonsPerLine <=  320 && buttonsPerLine >= 0) {
        fitButtonsPerLine = buttonsPerLine;
    }
    
    float buttonSeparatorX = (320-fitButtonsPerLine*buttonLen)/(fitButtonsPerLine+1);
    if (buttonSeparatorY < 0) {
        buttonSeparatorY =2 * buttonHeight/fitButtonsPerLine;
    }
    
    for (int i=0; i<[buttons count]; i++) {
        //
        rowIndex = i/buttonsPerLine;
        columnIndex = i%buttonsPerLine;
        UIButton *button = [buttons objectAtIndex:i];
        button.frame = CGRectMake(buttonSeparatorX+columnIndex*(buttonSeparatorX+buttonLen), rowIndex*(buttonHeight+buttonSeparatorY),buttonLen, buttonHeight);
        [scrollView addSubview:button];
    }
    [scrollView setContentSize:CGSizeMake(320, ([buttons count]/fitButtonsPerLine+1)*(buttonHeight+buttonSeparatorY))];
    [scrollView setBackgroundColor:[UIColor colorWithRed:0xF8/255.0
                                                   green:0xFC/255.0
                                                    blue:0xFE/255.0
                                                   alpha:1]];
    return scrollView;
}



#pragma mark - TAKE OR GET IMAGE  Methods
- (void)addSinglePhoto
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.navigationBar.tintColor = [UIColor colorWithRed:72.0/255.0 green:106.0/255.0 blue:154.0/255.0 alpha:1.0];
	imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = NO;
	[self presentModalViewController:imagePickerController animated:YES];
	[imagePickerController release];
}

- (void)addMultiplePhotos
{
    
    AGImagePickerController *imagePickerController = [[AGImagePickerController alloc] initWithFailureBlock:^(NSError *error) {
        NSLog(@"Fail. Error: %@", error);
        
        if (error == nil) {
            NSLog(@"User has cancelled.");
            [self dismissModalViewControllerAnimated:YES];
        } else {
            
            // We need to wait for the view controller to appear first.
            [self.imageArrayFromImagePicker removeAllObjects];

            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self dismissModalViewControllerAnimated:YES];
            });
        }
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        
    } andSuccessBlock:^(NSArray *info) {
        [self.imageArrayFromImagePicker setArray:info];
        
        NSLog(@"Info: %@", info);
        [self dismissModalViewControllerAnimated:YES];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }];
    
    // Show saved photos on top
    imagePickerController.shouldShowSavedPhotosOnTop = YES;
    imagePickerController.selection = self.imageArrayFromImagePicker;
    
    // Custom toolbar items
    AGIPCToolbarItem *selectAll = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"+ Select All" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease] andSelectionBlock:^BOOL(NSUInteger index, ALAsset *asset) {
        return YES;
    }];
    
    
    AGIPCToolbarItem *flexible = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease] andSelectionBlock:nil];
    
    
    AGIPCToolbarItem *selectOdd = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"+ Select Odd" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease] andSelectionBlock:^BOOL(NSUInteger index, ALAsset *asset) {
        return !(index % 2);
    }];
    
    
    AGIPCToolbarItem *deselectAll = [[AGIPCToolbarItem alloc] initWithBarButtonItem:[[[UIBarButtonItem alloc] initWithTitle:@"- Deselect All" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease] andSelectionBlock:^BOOL(NSUInteger index, ALAsset *asset) {
        return NO;
    }];
    
    
    imagePickerController.toolbarItemsForSelection = [NSArray arrayWithObjects:selectAll, flexible, selectOdd, flexible, deselectAll, nil];
    //    imagePickerController.toolbarItemsForSelection = [NSArray array];
    [selectOdd release];
    [flexible release];
    [selectAll release];
    [deselectAll release];
    
    
    //    imagePickerController.maximumNumberOfPhotos = 3;
    [self presentModalViewController:imagePickerController animated:YES];
    [imagePickerController release];


}

- (void)takePhoto
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"该设备不支持拍照功能"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"好", nil];
        [alert show];
        [alert release];
    }
    else
    {
        UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        [self presentModalViewController:imagePickerController animated:YES];
        [imagePickerController release];
    }
}

-(void)addImageAlert
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"插入图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"系统相册",@"拍摄", nil];
    [alert show];
    [alert release];
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    UIImage * image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.imagefromPicker = image;

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"index = %d",buttonIndex);
    if (buttonIndex == 1)
    {
        [self addSinglePhoto];
    }
    else if(buttonIndex == 2)
    {
        [self takePhoto];
    }
}



@end
