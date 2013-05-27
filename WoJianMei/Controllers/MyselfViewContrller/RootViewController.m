//
//  RootViewController.m
//  REComposeViewControllerExample
//
//  Created by Roman Efimov on 10/19/12.
//  Copyright (c) 2012 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "REComposeViewController.h"


#import "WorkoutNoteViewController.h"
#import "WorkoutDatasViewController.h"


@interface RootViewController ()

@end

@implementation RootViewController
@synthesize workoutNoteButton =_workoutNoteButton;
@synthesize workoutImageButton =_workoutImageButton;
@synthesize workoutDatasButton =_workoutDatasButton;



@synthesize scrollView =_scrollView;



-(void)setButtons{
    
    UIButton *workoutNoteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    workoutNoteButton.frame = CGRectMake(30, 10, 240, 150);
    [workoutNoteButton addTarget:self action:@selector(workoutNoteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [workoutNoteButton setTitle:@"健身日记" forState:UIControlStateNormal];

    
    
    UIButton *workoutImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    workoutImageButton.frame = CGRectMake(30, 190, 240, 150);
    [workoutImageButton addTarget:self action:@selector(workoutImageButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [workoutImageButton setTitle:@"健身图片" forState:UIControlStateNormal];
    
    UIButton *workoutDatasButton= [UIButton buttonWithType:UIButtonTypeCustom];
    workoutDatasButton.frame = CGRectMake(30, 380, 240, 150);
    [workoutDatasButton addTarget:self action:@selector(workoutDatasButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [workoutDatasButton setTitle:@"健身数据" forState:UIControlStateNormal];
    
    
    
    UIScrollView *scView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 880)];
    
    [scView setContentSize:CGSizeMake(320, 1300)];
    
    
    self.workoutNoteButton  =workoutNoteButton;
    self.workoutImageButton =workoutImageButton;
    self.workoutDatasButton =workoutDatasButton;
    
    [scView addSubview:_workoutNoteButton];
    [scView addSubview:_workoutImageButton];
    [scView addSubview:_workoutDatasButton];
    
    
    
    
    
    self.scrollView = scView;
    
    
    
    [scView setScrollEnabled:YES];
    [scView setScrollsToTop:YES];
    
    [self.view addSubview:_scrollView];
    
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = [UIColor whiteColor];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    ////set the buttons
    [self setButtons];
    
    
    
    ///set the right buttons
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(clickEditButton:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
   
    [self setNavigationRightButton:@"设置" imageName:@"settings.png" action:@selector(clickEditButton:)];
    
    
    
   
    
    ///set the gobal  backbutton 
    UIImage *btnTrnspBgrImg30 = [[UIImage imageNamed:@"top_bar_backButton.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:btnTrnspBgrImg30      forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    
    
    [self upgradeUI];
}


-(void)clickEditButton:(UIButton *)sender {

    
    [self.workoutNoteButton  setBackgroundColor:[UIColor redColor]];
    
    [self.workoutNoteButton setFrame:CGRectMake(0, 0, 70, 90)];
    
    [self.workoutImageButton setBackgroundColor:[UIColor redColor]];
    [self.workoutDatasButton setBackgroundColor:[UIColor redColor]];
    
    
}

#pragma mark -
#pragma mark Button actions

- (void)workoutNoteButtonPressed
{
    WorkoutNoteViewController *notecomposeViewController = [[WorkoutNoteViewController alloc] init];
    notecomposeViewController.title = @"健身日记";
    notecomposeViewController.hasAttachment = NO;
    notecomposeViewController.delegate = self;
    notecomposeViewController.text = @"亲，写下你的健身心得吧！";
    [self presentViewController:notecomposeViewController animated:YES completion:nil];
    
}

- (void)workoutImageButtonPressed
{
//    REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
//    composeViewController.title = @"健身图片";
//    composeViewController.hasAttachment = YES;
//    composeViewController.text = @"点击添加图片！！！";
//    composeViewController.attachmentImage = [UIImage imageNamed:@"Flower.jpg"];
//    composeViewController.delegate = self;
//    [self presentViewController:composeViewController animated:YES completion:nil];
    
    
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"照相"
                                              otherButtonTitles:@"相册",nil];
    [share showFromTabBar:self.tabBarController.tabBar];
    [share release];
    
    
    
    
}

- (void)workoutDatasButtonPressed
{
    WorkoutDatasViewController *datasVC = [[WorkoutDatasViewController alloc] init];
    datasVC.title = @"健身数据";
    datasVC.hasAttachment = YES;
    datasVC.attachmentImage = [UIImage imageNamed:@"Flower.jpg"];

    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"foursquare-logo"]];
    titleImageView.frame = CGRectMake(0, 0, 110, 30);
    datasVC.navigationItem.titleView = titleImageView;
    
    // UIApperance setup
    [datasVC.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg"] forBarMetrics:UIBarMetricsDefault];
    datasVC.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:60/255.0 green:165/255.0 blue:194/255.0 alpha:1];
    datasVC.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:29/255.0 green:118/255.0 blue:143/255.0 alpha:1];
    
    // Alternative use with REComposeViewControllerCompletionHandler
    datasVC.completionHandler = ^(REComposeResult result) {
        if (result == REComposeResultCancelled) {
            NSLog(@"Cancelled");
        }
        
        if (result == REComposeResultPosted) {
            NSLog(@"Text = %@", datasVC.text);
            
            
        }
    };
    
    [self presentViewController:composeViewController animated:YES completion:nil];
}

#pragma mark -
#pragma mark Orientation

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

#pragma mark -
#pragma mark REComposeViewControllerDelegate

- (void)composeViewController:(REComposeViewController *)composeViewController didFinishWithResult:(REComposeResult)result
{
    if (result == REComposeResultCancelled) {
        NSLog(@"Cancelled");
    }
    
    if (result == REComposeResultPosted) {
        NSLog(@"Text = %@", composeViewController.text);
    
    }
    
    
    [self.workoutNoteButton setTitle:composeViewController.text forState:UIControlStateNormal];
    
    
    
}


-(void)upgradeUI{
    
    
    
   ///set the note button
    UIImage *noteBG = [UIImage imageNamed:@"note_background.png"];
    [self.workoutNoteButton setBackgroundImage:noteBG forState:UIControlStateNormal];
    
    ///set the image button 
    UIImage *imageBG = [UIImage imageNamed:@"image_background.png"];
    [self.workoutImageButton setBackgroundImage:imageBG forState:UIControlStateNormal];
    
    ///set the note button
    UIImage *datasBG = [UIImage imageNamed:@"note_background.png"];
    [self.workoutDatasButton setBackgroundImage:datasBG forState:UIControlStateNormal];
    
    

    

}




#pragma mark --actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        {
            [self takePhoto];
        }
            break;
        case 1:
        {
            [self selectPhoto];
            
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



#pragma mark -
#pragma mark - ImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image != nil){
        
        [self.navigationController  dismissViewControllerAnimated:YES completion:^{
            
            [self.workoutImageButton setImage:image forState:UIControlStateNormal];
            
        }];
    }
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
}


@end
