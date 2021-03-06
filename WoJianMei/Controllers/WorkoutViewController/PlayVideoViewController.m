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
#import "CommentViewController.h"
#import "AppDelegate.h"
#import "ImageManager.h"
#import "BaiduMobStat.h"
#import "DeviceDetection.h"


#define kAppKey @"3622140445"
#define kAppSecret @"f94d063d06365972215c62acaadf95c3"
#define KAppRedirectURI @"http://aijianmei.com"

enum actionsheetNumber{
    LANGUAGE_SELECTION=0,
    RECOMMENDATION,
};

enum TapOnItem {
    
    SINA_WEIBO = 0,
    FREIND_CIRCLE = 1,
    WECHAT = 2,
    EMAIL = 3,
    MESSAGE = 4,
    COPY_LINK =5
};


@interface PlayVideoViewController ()<UIActionSheetDelegate,AWActionSheetDelegate>


@end

@implementation PlayVideoViewController
@synthesize video =_video;
@synthesize segmentedController =_segmentedController;
@synthesize descriptionView =_descriptionView;
@synthesize titleLabel =_titleLabel;
@synthesize timeLabel =_timeLabel;
@synthesize playerWebView =_playerWebView;
@synthesize commentViewController =_commentViewController;
@synthesize delegate = _delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       self.playerWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];

        CommentViewController *comVC =[[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
        [comVC.view setFrame:CGRectMake(0, 235, 320, 220)];
        [comVC.dataTableView setBackgroundColor:[UIColor clearColor]];        
        self.commentViewController = comVC;
        [comVC release];
       
        
        //Set the wechat deletgate
        self.delegate =[self getAppDelegate];
        
    }
    return self;
}
-(void)dealloc{
    
    [_video release];
    [_segmentedController release];
    [_titleLabel release];
    [_descriptionView release];
    [_timeLabel release];
    [_playerWebView release];
    [_commentViewController release];
    [super dealloc];
    
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
        [self.commentViewController.view removeFromSuperview];
    }
    if (segmentedControl.selectedSegmentIndex ==1)
    {
        [self.view addSubview:self.commentViewController.view];
        self.commentViewController.video = [self video];
        [self.commentViewController loadDatas];
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

////点击分享按钮
-(void)clickShareButton:(UIButton *)sender{
    
    
    PPDebug(@"////点击分享按钮");

    if ([DeviceDetection isOS6]){
        
        [self showAWSheet];
        
    }
    else{
        whichAcctionSheet = RECOMMENDATION;
        [self shareToSocialnetWorks];
        
    }
    
}



-(void)shareToSocialnetWorks
{
    whichAcctionSheet = RECOMMENDATION;
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:NSLS(@"取消")
                                         destructiveButtonTitle:NSLS(@"分享到新浪微博")
                                              otherButtonTitles:NSLS(@"分享给微信好友"),NSLS(@"分享到微信朋友圈"),NSLS(@"通过邮箱"),NSLS(@"通过短信"),nil];
    
    [share showInView:self.view];
    [share release];
    
}



/////only avaiable at ios 6
- (void)showAWSheet
{
    AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet showInView:self.view];
    [sheet release];
}

-(int)numberOfItemsInActionSheet
{
    return 6;
}


-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[[AWActionSheetCell alloc] init] autorelease];
    
    
    //set title
    NSArray *titleArray  = [ NSArray arrayWithObjects:
                            @"新浪微博",
                            @"朋友圈",
                            @"微信",
                            @"邮件",
                            @"短信",
                            @"复制链接",
                            nil];
    [[cell titleLabel] setText:[NSString stringWithFormat:@"%@",[titleArray objectAtIndex:index]]];
    
    
    //set icons
    NSArray *imageArray  = [ NSArray arrayWithObjects:
                            @"sina.png",
                            @"friendsCircle.png",
                            @"wechat.png",
                            @"email.png",
                            @"message.png",
                            @"copylink.png",
                            nil];
    
    NSString *imageName = [NSString stringWithFormat:@"%@",[imageArray objectAtIndex:index]];
    UIImage *image = [UIImage imageNamed:imageName];
    [[cell iconView] setImage:image];
    
    
    
    cell.index = index;
    
    
    return cell;
    
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    PPDebug(@"tap on %d",index);
    
    int TapOnItem = index;
    
    
    switch (TapOnItem) {
        case SINA_WEIBO:
        {
            [self clickSinaShareButton];
        }
            break;
        case FREIND_CIRCLE:
        {
            [self onSelectTimelineScene];
            
            UIImage *image = [self getImageFromURL:_video.img];
            postImage = image;
            
            [self sendAppContentWithTitle:_video.title description:_video.brief image:postImage  urlLink:_video.shareurl];
            
        }
            break;
        case WECHAT:
        {
            
            [self onSelectSessionScene];
            UIImage *image = [self getImageFromURL:_video.img];
            postImage = image;
            [self sendAppContentWithTitle:_video.title description:_video.brief image:postImage urlLink:_video.shareurl];
            
        }
            break;
        case EMAIL:
        {
            
            NSString *title =_video.title;
            NSString *description = _video.brief;
            NSString *downLoadLink  =_video.url;
            
            NSString *postInfo = [NSString stringWithFormat:@"【%@】\n\n%@ 阅读链接:%@",title,description,downLoadLink];
            [self sendEmailTo:nil
                 ccRecipients:nil
                bccRecipients:nil
                      subject:_video.title
                         body:postInfo
                       isHTML:NO
                     delegate:self];
            
        }
            break;
        case MESSAGE:
        {
            NSString *title =_video.title;
            NSString *description = _video.brief;
            NSString *downLoadLink  =_video.url;
            NSString *postInfo = [NSString stringWithFormat:@"【%@】\n\n%@ 阅读链接:%@",title,description,downLoadLink];
            [self sendSms:nil body:postInfo];
        }
            break;
        case COPY_LINK:
        {
            //copy one link
            NSString *downloadAPPUrl = [NSString stringWithFormat:@"www.aijianmei.com"];
            UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
            [gpBoard setString:downloadAPPUrl];
            [self popupHappyMessage:@"已成功复制下载链接" title:nil];
            
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark --actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (whichAcctionSheet == RECOMMENDATION )
    {
        NSString *bodyStringBegin = @"我正在使用 @爱健美网 iphone手机客户端，学习专业的运动、健身、健康资信，里边的健身运动小知识，和健身计划很适合要增肌、减肥的用户哦！下载地址是";
        NSString *bodyStringWebsite = @"http://www.aijianmei.com";
        
        NSString *bodyString = [NSString stringWithFormat:@"%@%@", bodyStringBegin, bodyStringWebsite];
        
        enum BUTTON_INDEX {
            
            SEND_SINA_WEIBO= 0,
            SEND_WECHAT_SOCIAL,
            SEND_WECHAT_FRIENDS,
            SEND_EMAIL ,
            SEND_MESSAGE ,
            CANCLE_BUTTON
        };
        
        NSInteger BUTTON_INDEX  =buttonIndex;
        
        switch (BUTTON_INDEX) {
            case SEND_SINA_WEIBO:
            {
                [self clickSinaShareButton];
            }
                break;
            case SEND_WECHAT_SOCIAL:
            {
                [self onSelectTimelineScene];
                
                UIImage *image =[UIImage imageNamed:@"Default.png"];
                
                [self sendAppContentWithTitle:@"下载爱健美iphone客户端" description:@"学习专业的运动、健身、健康资讯，就下载爱健美手机客户端啦！" image:image urlLink:@"www.aijianmei.com" ];
            }
            case SEND_WECHAT_FRIENDS:
            {
                ///调用微信接口
                [self  onSelectSessionScene];
                UIImage *image =[UIImage imageNamed:@"Default.png"];
                [self sendAppContentWithTitle:@"下载爱健美iphone客户端" description:@"学习专业的运动、健身、健康资讯，就下载爱健美手机客户端啦！" image:image urlLink:@"www.aijianmei.com" ];
                
            }
                break;
            case SEND_EMAIL:
                
            {
                [self sendEmailTo:nil
                     ccRecipients:nil
                    bccRecipients:nil
                          subject:@"向你推荐爱健美iphone客户端"
                             body:bodyString
                           isHTML:NO
                         delegate:self];
            }
                break;
            case SEND_MESSAGE:
            {
                [self sendSms:nil body:bodyString];
            }
                break;
            case CANCLE_BUTTON:
            {
                PPDebug(@"Click the cancle button");
                
            }
                break;
                
            default:
                break;
        }
    }
    
    
}


- (void)doOAuth
{
    if (_delegate)
    {
        [_delegate doAuth];
    }
}

- (void)onSelectSessionScene{
    [_delegate changeScene:WXSceneSession];
    [self popupHappyMessage:@"分享场景:会话" title:nil];
    
}

- (void)onSelectTimelineScene{
    
    if (_delegate && [_delegate respondsToSelector:@selector(changeScene:)]) {
        
        [_delegate changeScene:WXSceneTimeline];
        [self popupHappyMessage:@"分享场景:朋友圈" title:nil];
        
    }
    
    
}

////Wechat
- (void) sendAppContentWithTitle:(NSString*)title  description:(NSString *)descriptoin image:(UIImage *)image urlLink :(NSString*)urlLink
{
    if (_delegate  && [_delegate respondsToSelector:@selector(sendAppContentWithTitle:description:image:urlLink:)]
        )
    {
        PPDebug(@"Share to Wechat！");
        
        [_delegate sendAppContentWithTitle:title description:descriptoin image:image urlLink:urlLink];
    }
}


-(void)sendNewsContent{
    
    if (_delegate  && [_delegate respondsToSelector:@selector(sendNewsContent)]
        )
    {
        PPDebug(@"Share to Wechat！");
        
        [_delegate sendNewsContent];
    }
    
    
}

- (AppDelegate*)getAppDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

//从网络下载图片
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}


- (void)clickSinaShareButton
{
    
    UIImage *image = [self getImageFromURL:_video.img];
    postImage = image;
    
    _sinaweiboManager = [SinaWeiboManager sharedManager];
    [_sinaweiboManager createSinaweiboWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:KAppRedirectURI delegate:self];
    
    
    if([_sinaweiboManager.sinaweibo isAuthValid])
    {
        REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
        composeViewController.hasAttachment = YES;
        composeViewController.attachmentImage =postImage;
        
        
        NSString *appendString =@"(分享自  @爱健美网)";
        NSString *articleTitle =_video.title;
        NSString *shareUrl = [NSString stringWithFormat:@"   详情点击:%@",_video.url];
        
        NSString *postText = [NSString stringWithFormat:@"%@%@%@",articleTitle,appendString,shareUrl];
        
        [composeViewController setText:postText];
        
        
        
        UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        titleImageView.frame = CGRectMake(0, 0, 110, 30);
        composeViewController.navigationItem.titleView = titleImageView;
        
        // UIApperance setup
        [composeViewController.navigationBar setBackgroundImage:[UIImage imageNamed:@"topmenu_bg.png"] forBarMetrics:UIBarMetricsDefault];
        
        
        [self presentViewController:composeViewController animated:YES completion:nil];
        [composeViewController release];
        
        // Alternative use with REComposeViewControllerCompletionHandler
        composeViewController.completionHandler = ^(REComposeResult result) {
            if (result == REComposeResultCancelled) {
                NSLog(@"Cancelled");
                
            }
            
            if (result == REComposeResultPosted) {
                NSLog(@"Text = %@", composeViewController.text);
                [self shareVideoWithTitle: composeViewController.text image:composeViewController.attachmentImage ];
                
            }
        };
        
    }if(![_sinaweiboManager.sinaweibo isAuthValid])
    {
        [_sinaweiboManager.sinaweibo logIn];
    }
    
}

-(void)shareVideoWithTitle:(NSString*)title image:(UIImage *)image{
    
    NSMutableDictionary * params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   title, @"status",image,@"pic",nil];
    [[SinaWeiboManager sharedManager].sinaweibo requestWithURL:@"statuses/upload.json"
                                                        params:params
                                                    httpMethod:@"POST"
                                                      delegate:self];
    [self showActivityWithText:@"正在分享"];
}



- (void)setRightBarButtons
{
    float buttonHigh = 27.5;
    float buttonLen = 47.5;
    float seporator = 5;
    float leftOffest = 20;
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    UIView *rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 3*(buttonLen+seporator) +30, buttonHigh)];
    
    
    UIButton *shareBarButton = [[UIButton alloc]initWithFrame:CGRectMake(leftOffest+(buttonLen+seporator)*2 +30, 0, 22, 22)];
    [shareBarButton setImage:[ImageManager GobalArticelShareButtonBG] forState:UIControlStateNormal];
    [shareBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBarButton addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [shareBarButton.titleLabel setFont:font];
    [rightButtonView addSubview:shareBarButton];
    [shareBarButton release];
    
    
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]
                                       initWithCustomView:rightButtonView];
    
    [rightButtonView release];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [rightBarButton release];
}


#pragma mark -
#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"PlayVideoView"];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"PlayVideoView"];
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
 
    
    [self setRightBarButtons];
    
    
    [self.view addSubview:self.commentViewController.view];


    
    [self.titleLabel setText:self.video.title];
    [self.descriptionView setText:self.video.brief];
     self.descriptionView.backgroundColor = [UIColor clearColor];
    [self.descriptionView setEditable:NO];
    [self.timeLabel setText:self.video.create_time];
    

    
    
    [self.view addSubview:self.playerWebView];

    
    
    [self playVideo:self.video.shareurl withWebView:self.playerWebView];
    
    
    
    /////设置开始
    [_segmentedController setSelectedSegmentIndex:0];
    [self buttonClicked:_segmentedController];
    
    
}
-(void)viewDidUnload{
    [super viewDidUnload];
    [self setTitleLabel:nil];
    [self setDescriptionView:nil];
    [self setTimeLabel:nil];
    [self setCommentViewController:nil];
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
