//
//  MoreViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/14/12.
//
//

#import "MoreViewController.h"
#import "AboutViewController.h"
#import "FeedBackViewController.h"
#import "UserService.h"
#import "ImageManager.h"
#import "FontSize.h"
#import "DeviceDetection.h"
#import "AppDelegate.h"
//#import "MobClick.h"
#import "Result.h"
#import "VersionInfo.h"

#import "SinaWeibo.h"
#import "TLAlertView.h"
#import "UIUtils.h"


#define kAppId			@"516243132"



enum actionsheetNumber{
    LANGUAGE_SELECTION=0,
    RECOMMENDATION,
};

typedef enum {
    SHARE_To_SOCIAL_NET_WORKS = 0,
    FEEDBACK,
    LIKE_US,
    SHOW_ABOUT_VIEW,
    UPDATE_APP,
    REMMOMED_APPS,
    LOGOUT
} MORE_SELECTION;


@interface MoreViewController ()<UIActionSheetDelegate,AWActionSheetDelegate>

@end

@implementation MoreViewController
@synthesize listData =_listData;
@synthesize delegate = _delegate;


-(void)dealloc{
    
    [_listData release];
    [super dealloc];
    
}

- (void)initMoreUI
{
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    ////leftBtn
    UIButton *leftBtn = [[[UIButton alloc] init] autorelease];
    
    [leftBtn setBackgroundImage:[ImageManager GobalNavigationLeftSideButtonImage]
                       forState:UIControlStateNormal];
    
    leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    
    
    ////rightBtn
//    UIButton *rightBtn = [[[UIButton alloc] init] autorelease];
//    
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"NavigationButtonBG.png"]
//                        forState:UIControlStateNormal];
//    
//    [rightBtn setImage:[UIImage imageNamed:@"LeftSideViewIcon.png"] forState:UIControlStateNormal];
//    rightBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
//    [rightBtn addTarget:self action:@selector(rightButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];
//    
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPad)
    {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.shadowColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:22];
        self.navigationItem.titleView = label;
        [label release];
        
        
    }
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    ((UILabel *)self.navigationItem.titleView).text = title;
    [self.navigationItem.titleView sizeToFit];
}


- (void)leftButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}
- (void)rightButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleRightViewAnimated:YES];
}


-(void)initUI{
    
    ////Set the background Image
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    ///Set the right bar button 
//    [self setNavigationRightButton:@"设置"
//                          fontSize:FONT_SIZE
//                         imageName:@"setting.png"
//                            action:@selector(clickSettingsButton:)];
}

- (void)initOptionList
{
    NSArray *array = [[NSArray alloc] initWithObjects: @"分享", @"信息反馈",@"喜欢我们,打分鼓励", @"关于我们",  nil];
    self.listData = array;
    [array release];
}

-(void)clickSettingsButton:(id)sender{
   
}


-(AppDelegate *)appDelegate{
    

    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication];

    return appDelegate;

//    - (TencentOAuthManager *)tencentOAuthManager
//    {
//        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [appDelegate.tencentOAuthManager setDelegate:self];
//        return appDelegate.tencentOAuthManager;
//    }
    
}



#pragma mark -lifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initOptionList];
    [self initUI];
    [self initMoreUI];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:YES];
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
}


#pragma mark -
#pragma mark tableView delegates
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43.0f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return 3;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            PPDebug(@"Section one");
            
            return 4;

        }
            break;
        case 1:
        {
            PPDebug(@"Section two");
            
            return 2;
        }
            break;
        case 2:
        {
            PPDebug(@"Section three");
            return 1;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreViewController"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreViewController"] autorelease];

    }
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
    UIImage* image_icon = [UIImage imageNamed:@"szicon_a.png"];
    UIImageView* cellAccessoryView = [[UIImageView alloc] initWithImage:image_icon];
    cell.accessoryView = cellAccessoryView;
    cell.backgroundColor = [UIColor whiteColor];
    [cellAccessoryView release];
    
    
    // set backgroudView
    UIImageView *imageView = nil;
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_cell_background.png"]];

    if (indexPath.section ==0) {
        
        cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
        
        if (0 == [indexPath row] )
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_cell_background.png"]];
        else if (3 == [indexPath row])
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_cell_background.png"]];
        else
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"middle_cell_background.png"]];
        
    }else if(indexPath.section==1){
        // @"客户端更新",@"推荐应用",@"退出客户端"
        if (indexPath.row == 0) {
            cell.textLabel.text = @"客户端更新";
         imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_cell_background.png"]];
        }else {
            cell.textLabel.text  = @"推荐应用";
         imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_cell_background.png"]];
        }
        
    }else {
        cell.textLabel.text = @"登出";
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"singleCellBackgroud.png"]];
    }
    

    cell.backgroundView=imageView;
    [imageView release];
    
    UIImage *image = nil;
    if (indexPath.section ==0) {
        
        switch ([indexPath row] ) {
            case SHARE_To_SOCIAL_NET_WORKS:
                image = [UIImage imageNamed:@"share_social.png"];
                break;
            case FEEDBACK:
                image = [UIImage imageNamed:@"feed_back.png"];
                break;
            case LIKE_US:
                image = [UIImage imageNamed:@"Rate_Us.png"];
                break;
            case SHOW_ABOUT_VIEW:
                image = [UIImage imageNamed:@"about_us.png"];
                break;
            default:
                break;
        }

    }else if(indexPath.section ==1){
        
        switch ([indexPath row] ) {
            case 0:
                image = [UIImage imageNamed:@"update_app.png"];
                break;
            case 1:
                image = [UIImage imageNamed:@"more_apps.png"];
                break;
            default:
                break;

        }
    }else{
        image = [UIImage imageNamed:@"quit_app.png"];
    }
    
       
    cell.imageView.image = image;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        NSUInteger row = [indexPath row];
        switch (row) {
            case SHARE_To_SOCIAL_NET_WORKS:
            {
                [self shareToYourFriends];
            }
                break;
            case FEEDBACK:
            {
                [self showFeedback];
            }
                break;
            case LIKE_US:
            {
                [self likeUs];
            }
                break;
            case SHOW_ABOUT_VIEW:
            {
                [self showAboutView];
            }
                break;
            default:
                break;
        }
    }else if (indexPath.section==1){
        
        NSUInteger row = [indexPath row];
        switch (row) {
            case 0:
            {
                [self updateApplication];
            }
                break;
            case 1:
            {
                [self recommmendedApps];
                
            }
                break;
                
            default:
                break;
        }
    
    
    }else {
        
             [self logout];
    }
    
   
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




#pragma mark --Controller Methods

-(void)accountManagement{

    PPDebug(@"user goes to accountManagement");
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
    return 7;
}


-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[[AWActionSheetCell alloc] init] autorelease];

    
    //set title
    NSArray *titleArray  = [ NSArray arrayWithObjects:
                            @"新浪微博",
                            @"朋友圈",
                            @"微信",
                            @"腾讯微博",
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
                            @"tencentWeibo.png",
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
    
    NSString *bodyStringBegin = @"我正在使用爱健美客户端，学习如何健身，分享，很方便很好用，下载地址是";
    NSString *bodyStringWebsite = @"http://www.aijianmei.com";
    NSString *bodyString = [NSString stringWithFormat:@"%@%@", bodyStringBegin, bodyStringWebsite];

    
    
    enum TapOnItem {
        
        SINA_WEIBO = 0,
        FREIND_CIRCLE = 1,
        WECHAT = 2,
        TENCENT_WEIBO = 3,
        EMAIL = 4,
        MESSAGE = 5,
        COPY_LINK =6

    };
    
    int TapOnItem = index;
    
    
    switch (TapOnItem) {
        case SINA_WEIBO:
        {
            PPDebug(@"分享到新浪微博");
            NSString *status = @"TESTING";
            UIImage *pic =[UIImage imageNamed:@"Default-568h@2x.png"];
            
            
            NSMutableDictionary * params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           status, @"status",pic,@"pic",nil];
            
            
            [[SinaWeiboManager sharedManager].sinaweibo requestWithURL:@"statuses/upload.json"
                                                                params:params
                                                            httpMethod:@"POST"
                                                              delegate:self];
            

            [self showActivityWithText:@"正在分享"];

        }
            break;
        case FREIND_CIRCLE:
        {
            
        }
            break;
        case WECHAT:
        {
            
        }
            break;
        case TENCENT_WEIBO:
        {
            
        }
            break;
        case EMAIL:
        {
            [self sendEmailTo:nil
                 ccRecipients:nil
                bccRecipients:nil
                      subject:@"下载爱健美客户端，学习如何健身"
                         body:bodyString
                       isHTML:NO
                     delegate:self];
            
        }
            break;
        case MESSAGE:
        {
            [self sendSms:nil body:bodyString];
            
        }
            break;
        case COPY_LINK:
        {
            //copy one link
            NSString *downloadAPPUrl = [NSString stringWithFormat:@"www.aijianmei.com"];
            UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
            [gpBoard setString:downloadAPPUrl];
                
        }
            break;
        default:
            break;
    }

}

- (void)shareToYourFriends
{
    
    if ([DeviceDetection isOS6]){

        [self showAWSheet];
        
    }
    else{
        whichAcctionSheet = RECOMMENDATION;
        [self shareToSocialnetWorks];
    
    }
}

-(void)showFeedback{
    FeedBackViewController *fbVc = [[FeedBackViewController alloc]initWithNibName:@"FeedBackViewController" bundle:nil];
    [self.navigationController pushViewController:fbVc animated:YES];
    [fbVc release];
}

-(void)likeUs{
    PPDebug(@"Users likes us !");
}

-(void)showAboutView{
    
    AboutViewController *abVC = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    [self.navigationController pushViewController:abVC animated:YES];
    [abVC release];
}

-(void)updateApplication{    
    
    [[UserService defaultService] queryVersionWithDelegate:self];
    
}

-(void)recommmendedApps{
    
    PPDebug(@"Show me the recommended Apps");
}
-(void)logout{
    
    PPDebug(@"User is trying to logout");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要退出账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];

}

#pragma mark -
#pragma mark --AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    
    
    if ([alertView.title isEqualToString:@"版本更新"])
    {
        switch (buttonIndex) {
            case 0:
            {
                PPDebug(@"取消更新");
            }
                break;
            case 1:
            {
                PPDebug(@"1");
                //跳到更新页面
                [UIUtils openApp:kAppId];
            }
                break;
            default:
                break;
        }
        

    }
    if ([alertView.title isEqualToString:@"退出账号"])
    {
    
    switch (buttonIndex) {
        case 0:
        {
            PPDebug(@"0");
        }
            break;
        case 1:
        {
            PPDebug(@"1");
            
            NSString *userId = [[[UserService defaultService] user] uid];
            NSString *uid  =nil;
            
            if (userId)
            {
            uid = [[[NSString  alloc]initWithString:userId] autorelease];
                [uid retain];
            }
             
            if ([uid integerValue]) {
                [[UserService defaultService] deleteUserByUid:uid];
            }
        }
            break;
        default:
            break;
    }

    }
}


#pragma mark --actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (whichAcctionSheet == RECOMMENDATION )
    {
        NSString *bodyStringBegin = @"朋友，我正在使用爱健美客户端，学习如何健身，分享，很方便很好用，下载地址是";
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
                
                [[UserService defaultService] shareThroughSinaWeiboWithImageArray:nil TextContent:nil delegate:self];
                [self showActivityWithText:@"正在分享"];
                
            }
                break;
            case SEND_WECHAT_SOCIAL:
            {
                
            }
            case SEND_WECHAT_FRIENDS:
            {
                ///调用微信接口
                [self sendAppContent];
                
            }
                break;
            case SEND_EMAIL:
                
            {
                
                [self sendEmailTo:nil
                     ccRecipients:nil
                    bccRecipients:nil
                          subject:@"向你推荐爱健美的客户端"
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

////Wechat
- (void)sendAppContent
{
    
    
    if (_delegate  && [_delegate respondsToSelector:@selector(sendAppContent)]
)
    {
        PPDebug(@"Share to Wechat！");

        [_delegate sendAppContent];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - 
#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        NSLog(@"******%@",[error description]);
        [self showActivityWithText:@"分享失败"];

    }
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        NSLog(@"******%@",[result description]);
        [self hideActivity];
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
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects count: %d", [objects count]);
    [self hideActivity];

    NSObject *result =[objects objectAtIndex:0];
    
    if ([result isMemberOfClass:[VersionInfo class]]){
        
        
    VersionInfo *versionInfo =[objects objectAtIndex:0];
    NSLog(@"当前版本是:%@,下载URL:%@,标题:%@,更新内容:%@",      versionInfo.version,
          versionInfo.downloadurl,
          versionInfo.updateTitle,
          versionInfo.updateContent);
    
    NSString *latestVersion = versionInfo.version;
    NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
//    NSString *localVersion =@"1.0";
    if ([latestVersion isEqualToString:localVersion])
    {
        [self popupHappyMessage:@"已经是最新版本" title:nil];
    }
    else
    {
        UIAlertView *myalertView =[[UIAlertView alloc]initWithTitle:@"版本更新" message:versionInfo.updateContent delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
        [myalertView setTag:11];
       
        [myalertView show];
    }
 }
}





 @end
