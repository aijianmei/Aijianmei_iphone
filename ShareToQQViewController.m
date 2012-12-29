//
//  ShareToTencentQQViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/26/12.
//
//

#import "ShareToQQViewController.h"
#import "QFObject.h"
#import "FontSize.h"
#import "ImageManager.h"



@interface ShareToQQViewController ()
@property (nonatomic, retain) UITextView *contentTextView;
@property (nonatomic, retain) UILabel *wordsNumberLabel;

@end


@implementation ShareToQQViewController
@synthesize contentTextView;
@synthesize wordsNumberLabel;

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
    // Do any additional setup after loading the view from its nib.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[[ImageManager defaultManager] allBackgroundImage]]];
    
    [self setNavigationLeftButton:NSLS(@" 返回")
                         fontSize:FONT_SIZE
                        imageName:@"back.png"
                           action:@selector(clickBack:)];
    
    [self setNavigationRightButton:NSLS(@"发送")
                          fontSize:FONT_SIZE
                         imageName:@"topmenu_btn_right.png"
                            action:@selector(sendSinaWeibo:)];
    
    self.navigationItem.title = NSLS(@"分享到新浪微博");
    
    [self createSendView];
    
    _permissions =  [[NSArray arrayWithObjects:
					  @"get_user_info",@"add_share", @"add_topic",@"add_one_blog", @"list_album",
					  @"upload_pic",@"list_photo", @"add_album", @"check_page_fans",nil] retain];
//    
//    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"100266567" andDelegate:self];
    
    /////移动应用 非社区应用。
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"100328471"
                                            andDelegate:self];
    
    [_tencentOAuth authorize:_permissions inSafari:NO];
	_tencentOAuth.redirectURI = @"www.qq.com";
    
}

-(void)getuserInfos
{
    [_tencentOAuth getUserInfo];

}


#define WEIBO_LOGO_WIDTH    98
#define WEIBO_LOGO_HEIGHT   30
#define WORDSNUMBER_WIDTH   30
#define WORDSNUMBER_HEIGHT  20
#define CONTENT_WIDTH       284
#define CONTENT_HEIGHT      132

- (void)createSendView
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((320-CONTENT_WIDTH)/2, 0, WEIBO_LOGO_WIDTH, WEIBO_LOGO_HEIGHT)];
    imageView.image = [UIImage imageNamed:@"SinaWeibo_logo.png"];
    [self.view addSubview:imageView];
    [imageView release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((320-CONTENT_WIDTH)/2+CONTENT_WIDTH-WORDSNUMBER_WIDTH, WEIBO_LOGO_HEIGHT-WORDSNUMBER_HEIGHT, WORDSNUMBER_WIDTH, WORDSNUMBER_HEIGHT)];
    label.text = @"0";
    label.textAlignment = UITextAlignmentRight;
    label.textColor = [UIColor whiteColor];
    //label.backgroundColor = [UIColor blueColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    self.wordsNumberLabel = label;
    [label release];
    
    UIImageView *textBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feedback_bg2.png"]];
    textBackgroundView.frame = CGRectMake((320-CONTENT_WIDTH)/2, WEIBO_LOGO_HEIGHT, CONTENT_WIDTH, CONTENT_HEIGHT);
    [self.view addSubview:textBackgroundView];
    [textBackgroundView release];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake((320-CONTENT_WIDTH)/2, WEIBO_LOGO_HEIGHT, CONTENT_WIDTH, CONTENT_HEIGHT)];
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:14];
//    textView.text = [NSString stringWithFormat:NSLS(@"kShareContent"),[MobClick getConfigParams:@"download_website"]];
    textView.backgroundColor = [UIColor clearColor];
    self.contentTextView = textView;
    [textView release];
    
    [self.view addSubview:wordsNumberLabel];
    [self.view addSubview:contentTextView];
    
    self.wordsNumberLabel.text = [NSString stringWithFormat:@"%d",[contentTextView.text length]];
}

- (void)sendSinaWeibo:(id)sender
{
    [contentTextView resignFirstResponder];

    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   @"腾讯内部addShare接口测试", @"title",
								   @"http://www.qq.com", @"url",
								   @"风云乔帮主",@"comment",
								   contentTextView.text,@"summary",
								   @"http://img1.gtimg.com/tech/pics/hv1/95/153/847/55115285.jpg",@"images",
								   @"4",@"source",
								   nil];
	
	[_tencentOAuth addShareWithParams:params];

    
    
    
 
}

#pragma -mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.wordsNumberLabel.text = [NSString stringWithFormat:@"%d",[textView.text length]];
}




/**
 * Called when the user successfully logged in.
 */
- (void)tencentDidLogin {
	// 登录成功
	PPDebug(@"登陆成功");
	
	NSLog(@"QQ  did login ");
    
    [self getuserInfos];
}

/**
 * Called when the user dismissed the dialog without logging in.
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
	if (cancelled){
		PPDebug(@"用户取消登录");
	}
	else {
        PPDebug(@"登录失败");
	}
}

/**
 * Called when the notNewWork.
 */
-(void)tencentDidNotNetWork
{
	PPDebug(@"无网络连接，请设置网络") ;
}


/**
 * Called when the get_user_info has response.
 */
- (void)getUserInfoResponse:(APIResponse*) response {
	if (response.retCode == URLREQUEST_SUCCEED)
	{
		
		
		NSMutableString *str=[NSMutableString stringWithFormat:@""];
		for (id key in response.jsonResponse) {
			[str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
		}
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
		
		
		
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:[NSString stringWithFormat:@"%@", response.errorMsg]
							  
													   delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
		[alert show];
	}
	  PPDebug(@"获取个人信息完成") ;
}



//TencentRequestDelegate

/**
 * Handle the auth.ExpireSession api call failure
 */
- (void)request:(TencentRequest*)request didFailWithError:(NSError*)error{
	//NSString *errorInfo = [error localizedDescription];
	NSLog(@"Failed to expire the session");
}

- (void)request:(TencentRequest *)request didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"received response");
}



/**
 * Called when a request returns and its response has been parsed into
 * an object. The resulting object may be a dictionary, an array, a string,
 * or a number, depending on the format of the API response. If you need access
 * to the raw response, use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(TencentRequest *)request didLoad:(id)result dat:(NSData *)data{
	if ([result isKindOfClass:[NSDictionary class]]) {
		NSDictionary *root = (NSDictionary *)result;
		if ([[root allKeys] count] == 0) {
			NSLog(@"received didLoad error");
			return;
		}
	}
};




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
