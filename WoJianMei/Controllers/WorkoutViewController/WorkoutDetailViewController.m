//
//  WorkoutDetailViewController.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-6.
//
//

#import "WorkoutDetailViewController.h"
#import "ArticleService.h"
#import "NSString+HTML.h"
#import "ImageManager.h"


@interface WorkoutDetailViewController ()<UIActionSheetDelegate,AWActionSheetDelegate>


@end

@implementation WorkoutDetailViewController
@synthesize article =_article;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    return 7;
}


-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[[AWActionSheetCell alloc] init] autorelease];
    
//    [[cell iconView] setBackgroundColor:
//     [UIColor colorWithRed:rand()%255/255.0f
//                     green:rand()%255/255.0f
//                      blue:rand()%255/255.0f
//                     alpha:1]];
//    
    NSArray *array  = [ NSArray arrayWithObjects:@"新浪微博",@"朋友圈",@"微信",@"腾讯微博",@"邮件",@"短信",@"复制链接", nil];
    
    [[cell titleLabel] setText:[NSString stringWithFormat:@"%@",[array objectAtIndex:index]]];
    [[cell iconView] setImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
    cell.index = index;
    
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    PPDebug(@"tap on %d",index);
    
}



////点击喜欢按钮
-(void)clickLikeButton:(UIButton *)sender{
    
    PPDebug(@"////点击喜欢按钮");
   
}
////点击评论按钮
-(void)clickCommentButton:(UIButton *)sender{
    
    
    PPDebug(@"////点击评论按钮");

}
////点击分享按钮
-(void)clickShareButton:(UIButton *)sender{
    
    
    PPDebug(@"////点击分享按钮");
    
    [self showAWSheet];

}

- (void)setRightBarButtons
{
    float buttonHigh = 27.5;
    float buttonLen = 47.5;
    float shareBarButtonLen = 47.5;
    float seporator = 5;
    float leftOffest = 20;
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    UIView *rightButtonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 3*(buttonLen+seporator) +30, buttonHigh)];
    
    UIButton * likeButton = [[UIButton alloc] initWithFrame:CGRectMake(leftOffest, 0, buttonLen, buttonHigh)];
    [likeButton setBackgroundImage:[ImageManager GobalNavigationCommonButtonBG] forState:UIControlStateNormal];
    [likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [likeButton.titleLabel setFont:font];
    [likeButton addTarget:self action:@selector(clickLikeButton:) forControlEvents:UIControlEventTouchUpInside];
    [rightButtonView addSubview:likeButton];
    
    
    UIButton * commentBarButton = [[UIButton alloc] initWithFrame:CGRectMake(leftOffest+buttonLen+seporator, 0, buttonLen, buttonHigh)];
    [commentBarButton addTarget:self action:@selector(clickCommentButton:) forControlEvents:UIControlEventTouchUpInside];
    [commentBarButton setBackgroundImage:[ImageManager GobalNavigationCommonButtonBG] forState:UIControlStateNormal];
    [commentBarButton setTitle:@"评论" forState:UIControlStateNormal];
    [commentBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentBarButton.titleLabel setFont:font];
    [rightButtonView addSubview:commentBarButton];
    [commentBarButton release];
    
    
    UIButton *shareBarButton = [[UIButton alloc]initWithFrame:CGRectMake(leftOffest+(buttonLen+seporator)*2, 0, shareBarButtonLen, buttonHigh)];
    [shareBarButton setBackgroundImage:[ImageManager GobalNavigationCommonButtonBG] forState:UIControlStateNormal];
    [shareBarButton setTitle:@"分享" forState:UIControlStateNormal];
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    [self setRightBarButtons];
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    
    
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    _webview.delegate = self;
    _webview.scrollView.delegate = self;
    [self.view addSubview:_webview];
    
    
    UILabel *articleTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320,150)];
    articleTitleLabel.backgroundColor = [UIColor colorWithHue:12 saturation:34 brightness:32 alpha:0.3];
    [articleTitleLabel setText:self.article.title];
    [articleTitleLabel setTextColor:[UIColor whiteColor]];
    articleTitleLabel.textAlignment =UITextAlignmentCenter;
    [self.view addSubview:articleTitleLabel];
    [articleTitleLabel release];
    
    /////重新定位，设定NavigationBar 的位置
   [self.navigationController.navigationBar setFrame:CGRectMake(0, 420, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height)];
    
    
    //just for test
	[[ArticleService sharedService] findArticleInfoWithAucode:@"aijianmei" auact:@"au_getinformationdetail" articleId:_article._id channel:@" " channelType:@" " uid:@"" delegate:self];
    
    
    
}


#pragma mark -
#pragma mark Hide and Show TabBar Methods

- (void)showNavigationBar {
    UINavigationBar *tabBar = self.navigationController.navigationBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0]; // UITransitionView
    UIView *window = parent.superview;
    [UIView animateWithDuration:0.5
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



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{   [self showNavigationBar];
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
	NSString *picName = [[request URL] absoluteString];
	NSLog(@"picName is %@",picName);
    
    
	if ([picName hasPrefix:@"src"]) {
//		[self showBigImage:[picName substringFromIndex:4]];
		return NO;
	}else {
		return YES;
	}
    
    
}





- (void)loadWebViewWithHtmlString:(NSString*)htmlString
{
    //处理html特殊字符
    NSString *html = [htmlString stringByDecodingHTMLEntities];
    [_webview loadHTMLString:html baseURL:nil];
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    // called on finger up as we are moving
    PPDebug(@"#############11111");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    PPDebug(@"#############22222");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    PPDebug(@"#############333333");
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    [self showNavigationBar];
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
    _articleDetail = [objects objectAtIndex:0];
    [self loadWebViewWithHtmlString:_articleDetail.content];
    [_webview sizeToFit];
    PPDebug(@"Article ：%@",_articleDetail.content);
}

@end
