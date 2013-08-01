//
//  PlayVideoViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/31/13.
//
//

#import "PlayVideoViewController.h"
#import "SDSegmentedControl.h"
#import "Video.h"
#import <MediaPlayer/MediaPlayer.h>


@interface PlayVideoViewController ()

@end

@implementation PlayVideoViewController
@synthesize video =_video;
@synthesize segmentedController =_segmentedController;
@synthesize descriptionView =_descriptionView;
@synthesize titleLabel =_titleLabel;
@synthesize timeLabel =_timeLabel;
@synthesize playerWebView =_playerWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       self.playerWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];

        
    }
    return self;
}
-(void)dealloc{
    [super dealloc];
    [_video release];
    [_segmentedController release];
    [_titleLabel release];
    [_descriptionView release];
    [_timeLabel release];
    [_playerWebView release];
}

#pragma mark-- addButtonScrollView Method
-(void)addTitleButtonsSegmentedController{
    ////Configure The ButtonScrollView
    
    NSArray *buttonTitleArray =[NSArray arrayWithObjects:@"详情",@"评论",nil];
    
    self.segmentedController=[[SDSegmentedControl alloc]initWithItems:buttonTitleArray];
    [_segmentedController setFrame:CGRectMake(0, 150, 320, 40)];
    [_segmentedController setSelectedSegmentIndex:0];
    [_segmentedController addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_segmentedController];
}
#pragma mark-- ButtonClicked Method
-(void)buttonClicked:(SDSegmentedControl *)sender{
    
    SDSegmentedControl * segmentedControl =( SDSegmentedControl *)sender;
    
    if (segmentedControl.selectedSegmentIndex ==0)
    {
        
    }
    if (segmentedControl.selectedSegmentIndex ==1)
    {
        
    }
}


-(void)initVideoWebView{
    self.playerWebView.delegate = self;
    self.playerWebView.scrollView.scrollEnabled = NO;
    self.playerWebView.clipsToBounds = YES;
}

#pragma mark - Webview Delegates

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showActivityWithText:@"加载中..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideActivity];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideActivity];
}

#pragma mark - MoviePlayer Methods
- (void)playVideo:(NSString *)urlString withWebView:(UIWebView*)videoView  {
    
    NSString *embedHTML =@"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    background-color: transparent;\
    color: white;\
    }\
    </style>\
    <script>\
    function load(){document.getElementById(\"yt\").play();}\
    </script>\
    </head><body onload=\"load()\"style=\"margin:0\">\
   <iframe height=\"%0.0f\" width=\"%0.0f\" src=\"%@\"  frameborder=0 allowfullscreen></iframe></body></html>";

    
    
    videoView.backgroundColor   =  [UIColor redColor];    
    NSString *html = [NSString stringWithFormat:
                      embedHTML,
                      videoView.frame.size.height,
                      videoView.frame.size.width,
                      urlString];
    
    [videoView loadHTMLString:html baseURL:nil];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayStarted:) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoPlayFinished:) name:@"UIMoviePlayerControllerDidExitFullscreenNotification" object:nil];
    
}

-(void)videoPlayStarted:(NSNotification *)notification{
    //self.isInFullScreenMode = YES;
    
    PPDebug(@"video start to paly ");
}

-(void)videoPlayFinished:(NSNotification *)notification{
    // your code here
    // self.isInFullScreenMode = NO;
    PPDebug(@"video finish to paly ");
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addTitleButtonsSegmentedController];
    
    [self initVideoWebView];

    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];

    
    [self.titleLabel setText:self.video.title];
    [self.descriptionView setText:self.video.brief];
     self.descriptionView.backgroundColor = [UIColor clearColor];
    [self.descriptionView setEditable:NO];
    [self.timeLabel setText:self.video.create_time];
    

    [self.view addSubview:self.playerWebView];
    
    [self playVideo:self.video.shareurl withWebView:self.playerWebView];


}
-(void)viewDidUnload{
    
   
    [super viewDidUnload];
    [self setTitleLabel:nil];
    [self setDescriptionView:nil];
    [self setTimeLabel:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{

    return YES;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
