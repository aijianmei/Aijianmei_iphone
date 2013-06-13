//
//  MoreViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/14/12.
//
//

#import "MoreViewController.h"
#import "AboutViewController.h"
#import "More_SettingsViewController.h"
#import "UserService.h"
#import "ImageManager.h"
#import "FontSize.h"
#import "DeviceDetection.h"
#import "AppDelegate.h"
#import "MobClick.h"



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
    
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"NavigationButtonBG.png"]
                       forState:UIControlStateNormal];
    
    [leftBtn setImage:[UIImage imageNamed:@"LeftSideViewIcon.png"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    
    
    ////rightBtn
    UIButton *rightBtn = [[[UIButton alloc] init] autorelease];
    
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"NavigationButtonBG.png"]
                        forState:UIControlStateNormal];
    
    [rightBtn setImage:[UIImage imageNamed:@"LeftSideViewIcon.png"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [rightBtn addTarget:self action:@selector(rightButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];
    
    
    
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
//    [self setTitle:@"更多"];
    [self setNavigationRightButton:@"设置"
                          fontSize:FONT_SIZE
                         imageName:@"setting.png"
                            action:@selector(clickSettingsButton:)];
}

- (void)initOptionList
{
    NSArray *array = [[NSArray alloc] initWithObjects: @"分享", @"信息反馈",@"喜欢我们,打分鼓励", @"关于我们",  nil];
    self.listData = array;
    [array release];
}

-(void)clickSettingsButton:(id)sender{
    
    More_SettingsViewController *vc = [[More_SettingsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
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
    
    
    [MobClick event:@"More"];

    
    
    
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
        else if (4 == [indexPath row])
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
        cell.textLabel.text = @"退出客户端";
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
                [self shareToSocialnetWorks];
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
    [share showFromTabBar:self.tabBarController.tabBar];
    [share release];
    
}


/////only avaiable at ios 6
- (void)showAWSheet
{
    AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet showFromTabBar:self.tabBarController.tabBar];
    [sheet release];
}

-(int)numberOfItemsInActionSheet
{
    return 13;
}


-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[[AWActionSheetCell alloc] init] autorelease];
    
    [[cell iconView] setBackgroundColor:
     [UIColor colorWithRed:rand()%255/255.0f
                     green:rand()%255/255.0f
                      blue:rand()%255/255.0f
                     alpha:1]];
    [[cell titleLabel] setText:[NSString stringWithFormat:@"item %d",index]];
    [[cell iconView] setImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
    cell.index = index;
    
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    PPDebug(@"tap on %d",index);

}

- (void)shareToYourFriends
{
    
    if ([DeviceDetection isOS6]){

        [self showAWSheet];
        
    }
    else{
        whichAcctionSheet = RECOMMENDATION;
        [self shareToSocialnetWorks];
        PPDebug(@"Users share to his friends");
    
    }
        
}

-(void)showFeedback{
    
    [self performSegueWithIdentifier:@"FeedbackSegue" sender:self];
    PPDebug(@"Users show feedback");
    
}

-(void)likeUs{

    PPDebug(@"Users likes us !");

}

-(void)showAboutView{
    
    [self performSegueWithIdentifier:@"AboutViewControllerSegue" sender:self];
    
    PPDebug(@"Users Trying to show the aboutView");
}

-(void)updateApplication{
    
    [[UserService defaultService] queryVersion:self];
    PPDebug(@"Users are trying to upgrad the app");
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
                
        NSInteger BUTTON_INDEX ;
        BUTTON_INDEX  = buttonIndex;

        switch (BUTTON_INDEX) {
            case SEND_SINA_WEIBO:
            {
                
                                
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

 @end
