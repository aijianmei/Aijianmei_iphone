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

@interface WorkoutDetailViewController ()

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

#pragma mark -
#pragma mark Hide and Show TabBar Methods

- (void)showTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
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


- (void)hideTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    _webview.delegate = self;
    [self.view addSubview:_webview];    
    
    //just for test
	[[ArticleService sharedService] findArticleInfoWithAucode:@"aijianmei" auact:@"au_getinformationdetail" articleId:_article._id channel:@" " channelType:@" " uid:@"" delegate:self];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self hideTabBar];
    [super viewWillAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self showTabBar];
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
