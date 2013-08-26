//
//  WorkoutDetailViewController.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-6.
//
//

#import "CommonArticleViewController.h"
#import "ArticleService.h"
#import "NSString+HTML.h"
#import "ImageManager.h"
#import "CommentViewController.h"
#import "ArticleDetail.h"
#import "UserService.h"
#import "Result.h"
#import "REComposeViewController.h"
#import "CustomURLCache.h"
#import "AppDelegate.h"
#import "BaiduMobStat.h"
#import "DeviceDetection.h"
#import "StatusView.h"



#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

//239725454
//e2064ac8fab9d889a9eccecc5babad11

//爱健美网
//#define kAppKey @"3622140445"
//#define kAppSecret @"f94d063d06365972215c62acaadf95c3"


//爱健美
#define kAppKey @"239725454"
#define kAppSecret @"e2064ac8fab9d889a9eccecc5babad11"


#define KAppRedirectURI @"http://aijianmei.com"



enum TapOnItem {
    
    SINA_WEIBO = 0,
    FREIND_CIRCLE = 1,
    WECHAT = 2,
    EMAIL = 3,
    MESSAGE = 4,
    COPY_LINK =5
};


enum actionsheetNumber{
    LANGUAGE_SELECTION=0,
    RECOMMENDATION,
};




@interface CommonArticleViewController ()<UIActionSheetDelegate,AWActionSheetDelegate>


@end

@implementation CommonArticleViewController
@synthesize article =_article;
@synthesize toolBar =_toolBar;
@synthesize likeButton =_likeButton;
@synthesize articleDetail =_articleDetail;
@synthesize delegate = _delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.delegate =[AppDelegate getAppDelegate];
    }
    return self;
}


-(void)dealloc
{
    [_toolBar release];
    [_likeButton release];
    [_article release];
    [_webview release];
    [_articleDetail release];
    [super dealloc];
}

#pragma mark -
#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"CommentArticleView"];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"CommentArticleView"];
}

-(void)viewDidUnload{
    
    
    [self setLikeButton:nil];
    [self setWebview:nil];
    [self setToolBar:nil];
    [self setWebview:nil];
    [super viewDidUnload];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden =YES;

    [super viewWillAppear:YES];

}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden =NO;
    [super viewWillDisappear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view  setBounds:CGRectMake(0, 0, 320, 480)];
    
    [self setRightBarButtons];
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    
 
    

    [self.webview setFrame:CGRectMake(0, 0, 320, UIScreen.mainScreen.bounds.size.height)];
    [self.webview setDelegate:self];
    [self.webview.scrollView setDelegate:self];
    self.navigationController.navigationBarHidden =YES;
    
    

    
    
    /////重新定位，设定NavigationBar 的位置
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 420, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height)];
    
    
    //548 480
//        if (IS_IPHONE5) {
    /////重新定位，设定NavigationBar 的位置
//    [self.navigationController.navigationBar setFrame:CGRectMake(0, 508, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height)];
    //    }
    

    
    [[ArticleService sharedService] findArticleInfoWithAucode:@"aijianmei" auact:@"au_getinformationdetail" articleId:_article._id channel:@" " channelType:@" " uid:@"" delegate:self];
    
    
}

- (AppDelegate*)getAppDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}


////点击喜欢按钮
-(void)clickLikeButton:(id)sender{    
   ArticleDetail *article =[self articleDetail];
   User *user =  [[UserService defaultService] user];
    
    if ( user.uid ==nil) {
        return;
    }
    
    
   [[UserService defaultService] sendLikeWithContentId:[article _id] userId:user.uid  channeltype:@"1"  delegate:self];
    
}
////点击评论按钮
-(void)clickCommentButton:(UIButton *)sender{
    
    PPDebug(@"////点击评论按钮");
    CommentViewController *cVC = [[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
    [self.navigationController pushViewController:cVC animated:YES];
    cVC.article =self.article;
    
    [cVC release];
    

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

- (void)setRightBarButtons
{
    float buttonHigh = 44.0f;
    float seporator = 50;
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    UIView *rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320, buttonHigh)];
    
    
    
    [rightButtonView setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    UIButton * BackBarButton = [[UIButton alloc] initWithFrame:CGRectMake(0,9, 48, 29)];
    [BackBarButton addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    [BackBarButton setBackgroundImage:[ImageManager GobalNavigationBackButtonBG] forState:UIControlStateNormal];
    [BackBarButton setTitle:@"返回" forState:UIControlStateNormal];
    [BackBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [BackBarButton.titleLabel setFont:font];
    [rightButtonView addSubview:BackBarButton];
    [BackBarButton release];

    
    
    
    
    
    
    
    
    self.likeButton = [[UIButton alloc] initWithFrame:CGRectMake(270 - 2 * seporator,12, 25, 25)];
    [_likeButton setImage:[ImageManager GobalArticelLikeButtonBG] forState:UIControlStateNormal];
    [_likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
    [_likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_likeButton.titleLabel setFont:font];
    [_likeButton addTarget:self action:@selector(clickLikeButton:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:self.likeButton];
    
    
    UIButton * commentBarButton = [[UIButton alloc] initWithFrame:CGRectMake(270 - seporator,12, 25, 25)];
    [commentBarButton addTarget:self action:@selector(clickCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    [commentBarButton setImage:[ImageManager GobalArticelCommentButtonBG] forState:UIControlStateNormal];
    [commentBarButton setTitle:@"评论" forState:UIControlStateNormal];
    [commentBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentBarButton.titleLabel setFont:font];
    [rightButtonView addSubview:commentBarButton];
    [commentBarButton release];
    
    
    UIButton *shareBarButton = [[UIButton alloc]initWithFrame:CGRectMake(270,12, 25, 25)];
    [shareBarButton setImage:[ImageManager GobalArticelShareButtonBG] forState:UIControlStateNormal];
    [shareBarButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBarButton addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
    [shareBarButton.titleLabel setFont:font];
    [rightButtonView addSubview:shareBarButton];
    [shareBarButton release];

    
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]
                                       initWithCustomView:rightButtonView];
    
    [rightButtonView release];
    
    
    
    [self.toolBar setItems:[NSArray arrayWithObject:rightBarButton] animated:YES];
    

    [[UIToolbar appearance] setBackgroundImage:[UIImage imageNamed:@"topmenu_bg.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];

}


- (void)clickBack:(id)sender
{
    
    if ([self.webview isLoading]) {
        [self.webview   stopLoading];
        PPDebug(@"webView stop loading");
    }
    
    
    
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height)];

	[self.navigationController popViewControllerAnimated:YES];
}


//从网络下载图片
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

-(void)tap{
    
    [self hideNavigationBar];

}


#pragma mark -
#pragma mark Hide and Show TabBar Methods

- (void)showNavigationBar {
    UINavigationBar *tabBar = self.navigationController.navigationBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0]; // UITransitionView
    UIView *window = parent.superview;
    [UIView animateWithDuration:1.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds) - CGRectGetHeight(tabBar.frame);
                         tabBar.frame = tabFrame;
                         CGRect contentFrame = content.frame;
                         contentFrame.size.height -= tabFrame.size.height;
                     }];
}


- (void)hideNavigationBar {
    UINavigationBar *tabBar = self.navigationController.navigationBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds);
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                     }];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    [urlCache removeAllCachedResponses];

}

-(void)updateUserInterface{
    
     [_likeButton setImage:[UIImage imageNamed:@"like_icon.png"] forState:UIControlStateNormal];
    
    NSString *newLike = _articleDetail.like;
    int likeValue = [newLike integerValue];
    
    if (likeValue ==1) {
        
        [_likeButton setImage:[UIImage imageNamed:@"Press_like_icon.png"] forState:UIControlStateNormal];
    }
}



-(void)shareArticleWithTitle:(NSString*)title image:(UIImage *)image

{
    
    
    NSMutableDictionary * params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   title, @"status",image,@"pic",nil];
    [[SinaWeiboManager sharedManager].sinaweibo requestWithURL:@"statuses/upload.json"
                                                        params:params
                                                    httpMethod:@"POST"
                                                      delegate:[AppDelegate getAppDelegate]];
    
    [StatusView showtStatusText:@"正在分享..." vibrate:NO duration:30];
    
    
}


- (void)clickSinaShareButton
{
    
    UIImage *image = [self getImageFromURL:_article.img];
    postImage = image;
    
    [[SinaWeiboManager sharedManager] createSinaweiboWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:KAppRedirectURI delegate:self];
    
    
    if([[SinaWeiboManager sharedManager].sinaweibo isAuthValid])
    {
        REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
        composeViewController.hasAttachment = YES;
        composeViewController.attachmentImage =postImage;
        
        
        NSString *appendString =@"(分享自  @爱健美网)";
        NSString *articleTitle =_article.title;
        NSString *shareUrl = [NSString stringWithFormat:@"   详情点击:%@",_article.shareurl];
        
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
                [self shareArticleWithTitle: composeViewController.text image:composeViewController.attachmentImage ];
                
            }
        };
        
               

    }if(![_sinaweiboManager.sinaweibo isAuthValid])
    {
        [_sinaweiboManager.sinaweibo logIn];
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
            
            UIImage *image = [self getImageFromURL:_article.img];
            postImage = image;
            
            [self sendAppContentWithTitle:_article.title description:_article.brief image:postImage  urlLink:_article.shareurl];
            
        }
            break;
        case WECHAT:
        {
            
            [self onSelectSessionScene];
            UIImage *image = [self getImageFromURL:_article.img];
            postImage = image;
            [self sendAppContentWithTitle:_article.title description:_article.brief image:postImage urlLink:_article.shareurl];
            
        }
            break;
        case EMAIL:
        {
            
            NSString *title =_article.title;
            NSString *description = _article.brief;
            NSString *downLoadLink  =_article.url;
            
            NSString *postInfo = [NSString stringWithFormat:@"【%@】\n\n%@ 阅读链接:%@",title,description,downLoadLink];
            [self sendEmailTo:nil
                 ccRecipients:nil
                bccRecipients:nil
                      subject:_article.title
                         body:postInfo
                       isHTML:NO
                     delegate:self];
            
        }
            break;
        case MESSAGE:
        {
            NSString *title =_article.title;
            NSString *description = _article.brief;
            NSString *downLoadLink  =_article.url;
            NSString *postInfo = [NSString stringWithFormat:@"【%@】\n\n%@ 阅读链接:%@",title,description,downLoadLink];
            [self sendSms:nil body:postInfo];
        }
            break;
        case COPY_LINK:
        {
            //copy one link
            NSString *downloadAPPUrl = [NSString stringWithFormat:@"http://www.aijianmei.com/AppDownload.html"];
            UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
            [gpBoard setString:downloadAPPUrl];
            
            //停顿一会儿之后显示键盘
            float duration =0.7;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                          target:self
                                                        selector:@selector(popHappyNewsByTimer)
                                                        userInfo:nil
                                                         repeats:NO];
            
            
            
        }
            break;
            
        default:
            break;
    }
    
}


-(void)popHappyNewsByTimer{

    [self popupHappyMessage:@"已成功复制下载链接" title:nil];
    [self.timer invalidate];

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

#pragma mark -
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationTyp
{
	NSString *picName = [[request URL] absoluteString];    
    
	if ([picName hasPrefix:@"src"]) {
		return NO;
	}else {
		return YES;
	}
}

#pragma mark -
#pragma mark - webview

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    PPDebug(@"Webview did finish loading");
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    PPDebug(@"Webview did fail to  load with error :%@",error);

}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    PPDebug(@"web view did start to load");
}


- (void)loadWebViewWithHtmlString:(NSString*)htmlString
{
    //处理html特殊字符
    NSString *html = [htmlString stringByDecodingHTMLEntities];
    [self.webview loadHTMLString:html baseURL:nil];
}
#pragma mark -
#pragma SinaWeiboDelegate methods
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    [_sinaweiboManager storeAuthData];
    //微博登陆后获取用户数据
    [[UserService defaultService] fetchSinaUserInfo:sinaweibo.userID delegate:self];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [_sinaweiboManager removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [_sinaweiboManager removeAuthData];
}


#pragma mark -
#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        NSLog(@"******%@",[error description]);
        [self hideActivity];
        [self popupHappyMessage:@"分享失败" title:@""];
    }
    
    if ([request.url hasSuffix:@"users/show.json"])
    {
        NSLog(@"******%@",[error description]);
        [self hideActivity];
        [self popupHappyMessage:@"用户资料获取失败" title:@""];
    }

}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        NSLog(@"******%@",[result description]);
        [self hideActivity];
        [self popupHappyMessage:@"分享成功" title:@""];
    }
    
    if ([request.url hasSuffix:@"users/show.json"])
    {
        [[UserService defaultService] storeSinaUserInfo:result];
        
        NSDictionary *userInfo = result;
        NSLog(@"<storeSinaUserInfo>:%@",[[userInfo objectForKey:@"id"] stringValue]);
        
       
        [self  clickSinaShareButton];
    }

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
    [self showActivityWithText:@"数据加载中..."];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects count: %d", [objects count]);
    [self hideActivity];

    NSObject *object = [objects objectAtIndex:0];

    if ([object isMemberOfClass:[ArticleDetail class]])
    {
        
        ArticleDetail *article  = [objects objectAtIndex:0];
        [self setArticleDetail:article];
        [self loadWebViewWithHtmlString:self.articleDetail.content];
        [_webview sizeToFit];
        [_webview scalesPageToFit];
        [_webview setUserInteractionEnabled:YES];
        [_webview setFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height + 100)];
        [_webview.scrollView setContentSize:CGSizeMake(320, 400)];
        
        
    }
    
    
    if ([object isMemberOfClass:[Result class]])
    {
        
      //  10001 参数错误 缺少uid用户id或者缺少文章id
      //  10002 用户已经赞过
      //  0 提交成功
        
        
        enum ErrorCode
        {
            ERROR_SUCCESS =0,
            LACK_OF_PARAMATERS =10001,
            REPEATED_POST =10002
        };
        
        Result *result = [objects objectAtIndex:0];
        NSInteger errorCode =  [[result errorCode] integerValue];
        
        
        if (errorCode ==ERROR_SUCCESS)
        {
          [self popupHappyMessage:@"赞了该这篇文章" title:nil];
            
            [self.articleDetail setLike:@"1"];
        }
        if (errorCode ==LACK_OF_PARAMATERS) {
            [self popupHappyMessage:@"未知错误" title:nil];
        }
        if (errorCode ==REPEATED_POST) {
            [self popupUnhappyMessage:@"已经赞了该文章,不可以贪心哦！" title:nil];
        }
}
    [self updateUserInterface];
}




@end
