//
//  PostTopicViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/3/13.
//
//

#import "PostTopicViewController.h"
#import "VotesViewController.h"
#import "CTAssetsPickerController.h"
#import "CaptureVideoViewController.h"
#import "VideoManager.h"


#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>



@interface PostTopicViewController ()<CTAssetsPickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation PostTopicViewController
@synthesize videoPlayer =_videoPlayer;
@synthesize movieURL    =_movieURL;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{

    [_videoPlayer release];
    [_movieURL release];
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated{
    [self playVideo];
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    
    
    
    [self playVideo];
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];

    
    
    //rightBtn
    UIButton *rightBtn = [[[UIButton alloc] init] autorelease];
    
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"NavigationButtonBG.png"]
                        forState:UIControlStateNormal];
    
    [rightBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [rightBtn setTitle:@"发布" forState: UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];

}

-(void)clickDoneButton:(UIButton *)sender{
    
    
    
    [self popupHappyMessage:@"亲!发布内容不能够为空!" title:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickPickImagesButton:(id)sender {

    
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"照相"
                                              otherButtonTitles:@"相册",nil];
    [share showInView:self.view];
    [share release];

    

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
            [self pickAssets];
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



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        NSLog(@"0");
        
    }else {
        NSLog(@"1");
    }
}

- (IBAction)clickVideoButton:(id)sender{
    
    CaptureVideoViewController *vc =[[CaptureVideoViewController alloc]initWithNibName:@"CaptureVideoViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    self.navigationController.navigationBarHidden =YES;

    [vc release];
    
}



- (IBAction)clickVotesButton:(id)sender {
    
//    VotesViewController *vc = [[VotesViewController alloc]initWithNibName:@"VotesViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
//    [vc release];
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    [UIApplication sharedApplication].statusBarHidden =YES;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.movieURL= info[UIImagePickerControllerMediaURL];
    [[VideoManager defaultManager] setVideoPath:[NSString stringWithFormat:@"%@",self.movieURL]];
    NSLog(@"%@",[VideoManager defaultManager].videoPath);

    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark --
#pragma mark SelectPhotos

-(void)pickAssets{
  
    if (!self.assets)
        self.assets = [[NSMutableArray alloc] init];
    
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.maximumNumberOfSelection = 9;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:NULL];
    [picker release];
    
}
#pragma mark --
#pragma mark - Assets Picker Delegate
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    [self showPhotosArray];
    PPDebug(@"%d",[assets count]);
}

- (NSArray *)indexPathOfNewlyAddedAssets:(NSArray *)assets
{
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = self.assets.count; i < self.assets.count + assets.count ; i++)
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    
    return indexPaths;
}

#pragma mark --
#pragma mark - Add the photos array
-(void)showPhotosArray{


}



#pragma mark --
#pragma mark - ShowPickedVideos
-(void)playVideo{

    if (_movieURL) {
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:self.videoPlayer];
        
        
        self.videoPlayer=[[MPMoviePlayerController alloc] initWithContentURL:_movieURL];
        [self.videoPlayer.view setFrame:CGRectMake (0,320,320,200)];
        [self.videoPlayer.view setBackgroundColor:[UIColor redColor]];
        
        self.videoPlayer.movieSourceType=MPMovieSourceTypeFile;
        //本地文件播放要设置视频资源为文件类型资源，若设置为stream 则会错误
        [self.videoPlayer prepareToPlay];
        if(self.videoPlayer.isPreparedToPlay)
        {
            [self.videoPlayer play];
        }
        [self.view addSubview:self.videoPlayer.view];
    }
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
//    [self.videoPlayer stop];
//    [self.videoPlayer.view removeFromSuperview];
//    self.videoPlayer = nil;
    
}






@end
