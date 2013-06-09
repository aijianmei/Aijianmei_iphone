//
//  WorkoutDetailViewController.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-6.
//
//

#import "WorkoutDetailViewController.h"
#import "ArticleService.h"

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



- (void)viewDidLoad
{
    [super viewDidLoad];
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:_webview];    
    
    //just for test
	[[ArticleService sharedService] findArticleInfoWithAucode:@"aijianmei" auact:@"au_getinformationdetail" articleId:_article._id channel:@" " channelType:@" " uid:@"" delegate:self];
    
    [self hideTabBar];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [_webview loadHTMLString:_articleDetail.content baseURL:nil];

}


-(void)viewWillDisappear:(BOOL)animated
{
    [self showTabBar];
    [super viewWillDisappear:YES];
    
    
}

@end
