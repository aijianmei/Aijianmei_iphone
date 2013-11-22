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
#import "UserManager.h"
#import "ImageManager.h"
#import "FontSize.h"
#import "DeviceDetection.h"
#import "AppDelegate.h"
#import "Result.h"
#import "VersionInfo.h"

#import "SinaWeibo.h"
#import "UIUtils.h"
#import "StatusView.h"
#import "UIImageUtil.h"
#import "UIImage+Scale.h"
#import "IIViewDeckController.h"




#define kAppId			@"683646344"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define TIPSLABEL_TAG 10086

//239725454
//e2064ac8fab9d889a9eccecc5babad11

//爱健美网
//#define kAppKey @"3622140445"
//#define kAppSecret @"f94d063d06365972215c62acaadf95c3"


//爱健美
#define kAppKey @"239725454"
#define kAppSecret @"e2064ac8fab9d889a9eccecc5babad11"
#define KAppRedirectURI @"http://aijianmei.com"



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
   // REMMOMED_APPS,
    LOGOUT
} MORE_SELECTION;


enum TapOnItem {
    
    SINA_WEIBO = 0,
    FREIND_CIRCLE = 1,
    WECHAT = 2,
    //       TENCENT_WEIBO = 3,
    EMAIL = 3,
    MESSAGE = 4,
    COPY_LINK =5
};


enum BUTTON_INDEX {
    
    SEND_SINA_WEIBO= 0,
    SEND_WECHAT_SOCIAL,
    SEND_WECHAT_FRIENDS,
    SEND_EMAIL ,
    SEND_MESSAGE ,
    CANCLE_BUTTON
};





@interface MoreViewController ()<UIActionSheetDelegate,AWActionSheetDelegate>

@end

@implementation MoreViewController
@synthesize listData =_listData;
@synthesize delegate = _delegate;


-(void)dealloc{
    
    [_listData release];
    [_uid release];
    [super dealloc];
    
}

- (void)initMoreUI
{
    ////leftBtn
    UIButton *leftBtn = [[[UIButton alloc] init] autorelease];
    [leftBtn setImage:[ImageManager GobalNavigationLeftSideButtonImage] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    

    
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

}

- (void)initOptionList
{
    NSArray *array = [[NSArray alloc] initWithObjects: @"分享", @"信息反馈",@"喜欢我们,打分鼓励", @"关于我们",  nil];
    self.listData = array;
    [array release];
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

    
    self.delegate =[AppDelegate getAppDelegate];
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section==0) {
        return 60;
    }

    return 0;
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
            
            return 1;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreViewCell"];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreViewCell"] autorelease];

    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
    UIImage* image_icon = [UIImage imageNamed:@"szicon_a.png"];
    
    UIImageView* cellAccessoryView = [[UIImageView alloc] initWithImage:image_icon];
    cell.accessoryView = cellAccessoryView;
    [cellAccessoryView release];
    
    cell.textLabel.textColor =[UIColor grayColor];

    if (indexPath.section ==0) {
        
        cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
        
    }else if(indexPath.section==1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"客户端更新";
            
        }        
    }else {
        cell.textLabel.text = @"退出当前账号";
        
        User *user = [[UserManager defaultManager] user];

        if (user.uid) {
            cell.textLabel.textColor =[UIColor redColor];
        }
    }
    

    
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
//                            @"tencentWeibo.png",
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
    NSString *bodyStringWebsite = @"https://itunes.apple.com/us/app/ai-jian-mei/id683646344?ls=1&mt=8";
    NSString *bodyString = [NSString stringWithFormat:@"%@%@", bodyStringBegin, bodyStringWebsite];

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
            
            UIImage *image =[UIImage imageNamed:@"Default.png"];
            
            postImage = [image scaleToSize:CGSizeMake(100,100)];

            [self sendAppContentWithTitle:@"下载爱健美手机客户端" description:@"学习专业的运动、健身、健康资讯，就下载爱健美手机客户端啦！" image:postImage urlLink:@"https://itunes.apple.com/us/app/ai-jian-mei/id683646344?ls=1&mt=8"];
            
            
        }
            break;
        case WECHAT:
        {
            [self onSelectSessionScene];
            
            UIImage *image =[UIImage imageNamed:@"Default.png"];
            postImage = [image scaleToSize:CGSizeMake(100,100)];
            
            [self sendAppContentWithTitle:@"爱健美手机客户端" description:@"专业的健身、运动、健康资讯，就下载爱健美手机客户端啦！" image:postImage urlLink:@"https://itunes.apple.com/us/app/ai-jian-mei/id683646344?ls=1&mt=8" ];
            
            
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
}

-(void)clickSinaShareButton
{
    
    [[SinaWeiboManager sharedManager]
     createSinaweiboWithAppKey:kAppKey
     appSecret:kAppSecret
     appRedirectURI:KAppRedirectURI
     delegate:[AppDelegate getAppDelegate]];
    
    
    if([[SinaWeiboManager sharedManager].sinaweibo isAuthValid]){
        
        NSString *bodyStringBegin = @"我正在使用 @爱健美网 iphone手机客户端，学习专业的运动、健身、健康资信，里边的健身运动小知识，和健身计划很适合要增肌、减肥的用户哦！下载地址是";
        NSString *bodyStringWebsite = @"http://www.aijianmei.com";
        NSString *bodyString = [NSString stringWithFormat:@"%@%@", bodyStringBegin, bodyStringWebsite];
        
        NSString *status = bodyString;
        UIImage *pic =[UIImage imageNamed:@"Default.png"];
        
        NSMutableDictionary * params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       status, @"status",pic,@"pic",nil];
        
        
        [[SinaWeiboManager sharedManager].sinaweibo requestWithURL:@"statuses/upload.json"
                                                            params:params
                                                        httpMethod:@"POST"
                                                          delegate:        [AppDelegate getAppDelegate]];
        
         
        
        [StatusView showtStatusText:@"正在分享..."
                            vibrate:NO
                           duration:30];

    
    }if(![[SinaWeiboManager sharedManager].sinaweibo isAuthValid])
    {
        [[SinaWeiboManager sharedManager].sinaweibo logIn];
        
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
    [UIUtils openApp:kAppId];
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"若退出当前账号,您的所有用户数据将会被清楚！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];

}



#pragma mark -
#pragma mark --AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    PPDebug(@"***%@*****",alertView.title);

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
    
    if ([alertView.title hasPrefix:@"提示"])
    {
    
    switch (buttonIndex) {
        case 0:
        {
            PPDebug(@"0");
        }
            break;
        case 1:
        {
            
             self.uid = [[[UserManager defaultManager] user] uid];
            
            if (self.uid)
            {
                
                [[UserManager defaultManager] deleteUserByUid:self.uid];
                [dataTableView reloadData];
                
                [[AppDelegate getAppDelegate] showLoginView];

            }else {
                
            PPDebug(@"******User does not exit********");
                
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
        NSString *bodyStringBegin = @"我正在使用 @爱健美网 iphone手机客户端，学习专业的运动、健身、健康资信，里边的健身运动小知识，和健身计划很适合要增肌、减肥的用户哦！下载地址是";
        NSString *bodyStringWebsite = @"http://www.aijianmei.com";
        
        NSString *bodyString = [NSString stringWithFormat:@"%@%@", bodyStringBegin, bodyStringWebsite];
        
                     
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
                
                
                postImage =[image scaleToSize:CGSizeMake(70,70)];

                [self sendAppContentWithTitle:@"下载爱健美iphone客户端" description:@"学习专业的运动、健身、健康资讯，就下载爱健美手机客户端啦！" image:postImage urlLink:@"https://itunes.apple.com/us/app/ai-jian-mei/id683646344?ls=1&mt=8" ];
                
            }
            case SEND_WECHAT_FRIENDS:
            {
                ///调用微信接口
                [self  onSelectSessionScene];
                UIImage *image =[UIImage imageNamed:@"Default.png"];
                
                
                postImage =[image scaleToSize:CGSizeMake(70,70)];

                [self sendAppContentWithTitle:@"下载爱健美iphone客户端" description:@"学习专业的运动、健身、健康资讯，就下载爱健美手机客户端啦！" image:postImage urlLink:@"https://itunes.apple.com/us/app/ai-jian-mei/id683646344?ls=1&mt=8" ];
                
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
}

- (void)onSelectTimelineScene{
    
    if (_delegate && [_delegate respondsToSelector:@selector(changeScene:)]) {
        [_delegate changeScene:WXSceneTimeline];
    }
}



////Wechat
- (void) sendAppContentWithTitle:(NSString*)title  description:(NSString *)descriptoin image:(UIImage *)image urlLink :(NSString*)urlLink
{
    if (_delegate  && [_delegate respondsToSelector:@selector(sendAppContentWithTitle:description:image:urlLink:)]
)
    {
        [_delegate sendAppContentWithTitle:title
                               description:descriptoin
                                     image:image
                                   urlLink:urlLink];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark -
#pragma mark - MessageComposeController Delegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    NSLog(@"<sendSms> result=%d", result);
    switch (result)
    {
        case MessageComposeResultCancelled:
            [self popupHappyMessage:@"信息取消" title:nil];
            break;
        case MessageComposeResultSent:
            [self popupHappyMessage:@"信息已发送"title:nil];
            break;
        case MessageComposeResultFailed:
            [self popupUnhappyMessage:@"信息发送失败" title:nil];
            break;
        default:
            break;
    }

    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -
#pragma mark - MailComposeController Delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [self popupHappyMessage:@"邮件取消" title:nil];
            break;
        case MFMailComposeResultSaved:
            [self popupHappyMessage:@"邮件已保存" title:nil];
            break;
        case MFMailComposeResultSent:
            [self popupHappyMessage:@"邮件已发送"title:nil];
            break;
        case MFMailComposeResultFailed:
            [self popupUnhappyMessage:@"邮件发送失败" title:nil];
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}




#pragma mark -
#pragma mark - RKObjectLoaderDelegate
-(void)didLoadUpdateVersionInfo:(VersionInfo*)versionInfo errorCode:(int)errorCode
{
    

    NSLog(@"当前版本是:%@,下载URL:%@,标题:%@,更新内容:%@",versionInfo.version,
          versionInfo.downloadurl,
          versionInfo.updateTitle,
          versionInfo.updateContent);
    
    NSString *latestVersion = versionInfo.version;
    NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        

        if ([latestVersion isEqualToString:localVersion])
    {
        [self popupHappyMessage:@"已经是最新版本" title:nil];
    }
    else{
                
        CommonDialog *dialog = [CommonDialog createDialogWithTitle:@"新版本升级提示!"
                    subTitle:versionInfo.updateTitle
                     content:versionInfo.updateContent
               OKButtonTitle:@"立刻升级"
           cancelButtonTitle:@"稍后提醒"
                    delegate:self];
                [self.view addSubview:dialog];
        }
    
    
}


#pragma mark -
#pragma CommonDialogDelegate methods
- (void)didClickOkButton
{
    [UIUtils openApp:kAppId];
}

- (void)didClickCancelButton
{
    return;
}


 @end
