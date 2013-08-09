//
//  RootViewController.m
//  REComposeViewControllerExample
//
//  Created by Roman Efimov on 10/19/12.
//  Copyright (c) 2012 Roman Efimov. All rights reserved.
//

#import "WorkOutDataViewController.h"
#import "REComposeViewController.h"
#import "WorkoutDataComposeViewController.h"
#import "WorkOutInfo.h"


@interface WorkOutDataViewController ()

@end

@implementation WorkOutDataViewController
@synthesize workoutNoteButton =_workoutNoteButton;
@synthesize workoutImageButton =_workoutImageButton;
@synthesize workoutDatasButton =_workoutDatasButton;
@synthesize workOutInfo =_workOutInfo;

@synthesize scrollView =_scrollView;



-(void)dealloc{

  
    
    [_workoutNoteButton release];
    [_workoutImageButton release];
    [_workoutDatasButton release];
    [_workOutInfo release];

    
    
    [super dealloc];
}


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
    
    [workoutNoteButton release];
    [workoutDatasButton release];
    [workoutImageButton release];

    
    
    
    self.scrollView = scView;
    
    
    
    [scView setScrollEnabled:YES];
    [scView setScrollsToTop:YES];
    
    [self.view addSubview:_scrollView];
    [scView release];
    
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
	self.view.backgroundColor = [UIColor whiteColor];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    ////set the buttons
    [self setButtons];
    
    
    
//    ///set the right buttons
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(clickEditButton:)];
//    [self.navigationItem setRightBarButtonItem:rightBarButton];
   
    [self setNavigationRightButton:@"设置" imageName:@"settings.png" action:@selector(clickEditButton:)];
    
   [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    
    
    
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
//    WorkoutNoteViewController *notecomposeViewController = [[WorkoutNoteViewController alloc] init];
//    notecomposeViewController.title = @"健身日记";
//    notecomposeViewController.hasAttachment = YES;
//    notecomposeViewController.delegate = self;
//    notecomposeViewController.text = @"亲，写下你的健身心得吧！";
//    [self presentViewController:notecomposeViewController animated:YES completion:nil];
    
}

- (void)workoutImageButtonPressed
{

    
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
    WorkoutDataComposeViewController *datasVC = [[WorkoutDataComposeViewController alloc] init];
    datasVC.title = @"健身数据";
    datasVC.hasAttachment = YES;
    datasVC.delegate = self;
//    datasVC.attachmentImage = [UIImage imageNamed:@"Flower.jpg"];

//    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"foursquare-logo"]];
//    titleImageView.frame = CGRectMake(0, 0, 110, 30);
//    datasVC.navigationItem.titleView = titleImageView;
    
    // UIApperance setup
//    [datasVC.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg"] forBarMetrics:UIBarMetricsDefault];
//    datasVC.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:60/255.0 green:165/255.0 blue:194/255.0 alpha:1];
//    datasVC.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:29/255.0 green:118/255.0 blue:143/255.0 alpha:1];
    
    
    
    
    
    // Alternative use with REComposeViewControllerCompletionHandler
//    datasVC.completionHandler = ^(WorkoutDataComposeResult result) {
//        if (result == WorkoutDataComposeResultCancelled) {
//            NSLog(@"Cancelled");
//        }
//        
//        if (result == WorkoutDataComposeResultPosted) {
//            NSLog(@"Text = %@", datasVC.text);
//            
//            
//        }
//    };
//    
    [self presentViewController:datasVC animated:YES completion:nil];
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
        
        ////健身日记数据接口
        NSLog(@"健身日记数据:Text = %@", composeViewController.text);
    
    }
    
    
    [self.workoutNoteButton setTitle:composeViewController.text forState:UIControlStateNormal];
    
    
    ////保存健身日记
    self.workOutInfo.note = composeViewController.text;
    
    
    
}

#pragma mark -
#pragma mark WorkoutDataComposeViewControllerDelegate
- (void)dataComposeViewController:(WorkoutDataComposeViewController *)composeViewController didFinishWithResult:(WorkoutDataComposeResult)result
{
    if (result == WorkoutDataComposeResultCancelled) {
        NSLog(@"Cancelled");
    }
    
    if (result == WorkoutDataComposeResultPosted) {
        /*
         第1行数据  强度         1 4 7 10 13
         第2行数据  数量         2 5 8 11 14
         第3行数据  时间         3 6 9 12 15
         第4行数据  补充文字      你好，今天我健身了！

         */
        NSLog(@"第一行数据 = %@", [composeViewController.dataArray objectAtIndex:0]);
        NSLog(@"第二行数据 =%@", [composeViewController.dataArray objectAtIndex:1]);
        NSLog(@"第三行数据 =%@", [composeViewController.dataArray objectAtIndex:2]);
        NSLog(@"第四行数据 =%@",[[composeViewController.dataArray objectAtIndex:3] objectAtIndex:0]);

        
        
//        self.superViewController.intensityList = [composeViewController.dataArray objectAtIndex:0];
//        self.superViewController.amountList = [composeViewController.dataArray objectAtIndex:1];
//        self.superViewController.timeList = [composeViewController.dataArray objectAtIndex:2];
//        
//        ///获取最后一个，数据框的字符串
//        self.superViewController.moreNote = [[composeViewController.dataArray objectAtIndex:3] objectAtIndex:0];
        
        
        ////保存健身精确数据;
        
        [self.workOutInfo setDatas: composeViewController.dataArray];
        
        
    }
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
            
            
            ////保存健身照片;
            [self.workOutInfo setImage:image];
            
        }];
    }
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
}


@end
