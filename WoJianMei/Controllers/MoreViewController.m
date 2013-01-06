//
//  MoreViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/14/12.
//
//

#import "MoreViewController.h"
#import "AboutViewController.h"
#import <Social/Social.h>
#import "SettingsViewController.h"

#import "UserService.h"

#import "ShareToSinaController.h"
#import "ShareToQQWeiboController.h"

#import "ImageManager.h"
#import "FontSize.h"



enum actionsheetNumber{
    LANGUAGE_SELECTION=0,
    RECOMMENDATION,
};


typedef enum {
    ACCOUNT_MANAGEMENT = 0,
    FEEDBACK,
    SHARES,
    RECOMMEN_TO_FRIENDS,
    RATE_AT_APPLE_STORE,
    ABOUT,
    UPDATE
} MORE_SELECTION;


@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize listData =_listData;

-(void)dealloc{
    
    [_listData release];
    [super dealloc];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.    
    [self optionListInit];

    
    
    
    [self setBackgroundImageName:@"BackGround.png"];
    [self showBackgroundImage];
    
    
    
    [self setTitle:@"更多"];
    [self setNavigationRightButton:@""
                          fontSize:FONT_SIZE
                         imageName:@"setting.png"
                            action:@selector(clickSettingsButton:)];
    
    [self loadView];


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
//    
//    UIViewController *nv = (UIViewController *) [self.navigationController topViewController];
//    [nv.navigationItem setTitle:@"更多"];
    //

    

        
    
    
    
}


-(void)clickSettingsButton:(id)sender{
    
    SettingsViewController *settingVC = [[SettingsViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
    [settingVC release];
}


- (void)optionListInit
{
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"账号管理", @"信息反馈", @"分享", @"推荐给好友", @"打分鼓励", @"关于我们", @"客户端更新",  nil];
    

    self.listData = array;
    [array release];
}


#pragma mark -
#pragma mark delegates



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreViewController"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MoreViewController"] autorelease];
        cell.textLabel.text = [self.listData objectAtIndex:indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        cell.textLabel.textColor=[UIColor colorWithRed:0x46/255.0 green:0x46/255.0 blue:0x46/255.0 alpha:1.0];
        
        UIImage* image = [UIImage imageNamed:@"szicon_a.png"];
        UIImageView* cellAccessoryView = [[UIImageView alloc] initWithImage:image];
        cell.accessoryView = cellAccessoryView;
        [cellAccessoryView release];
        
//        cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
//        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0x2F/255.0 green:0x76/255.0 blue:0xB9/255.0 alpha:1.0];
        
        
    }
    
    UIImage *image = nil;
    switch ([indexPath row]) {
        case ACCOUNT_MANAGEMENT:
            image = [UIImage imageNamed:@"szicon1.png"];
            break;
        case FEEDBACK:
            image = [UIImage imageNamed:@"szicon2.png"];
            break;
        case SHARES :
            image = [UIImage imageNamed:@"szicon3.png"];
            break;
        case RECOMMEN_TO_FRIENDS:
            image = [UIImage imageNamed:@"szicon4.png"];
            break;
        case RATE_AT_APPLE_STORE:
            image = [UIImage imageNamed:@"szicon5.png"];
            break;
        case ABOUT:
            image = [UIImage imageNamed:@"szicon7.png"];
            break;
        case UPDATE:
            image = [UIImage imageNamed:@"szicon8.png"];
            break;
        default:
            break;
    }
    
    cell.imageView.image = image;
    cell.textLabel.backgroundColor = [UIColor clearColor];
//    cell.contentView.backgroundColor = [UIColor clearColor];
    
    
    //set backgroudView
    UIImageView *imageView = nil;
    
    if (0 == [indexPath row] )
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"helptable_top.png"]];
    else if (8 == [indexPath row])
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"helptable_bottom.png"]];
    else
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"helptable_middle.png"]];
    
    cell.backgroundView=imageView;
    
    [imageView release];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    switch (row) {
        case ACCOUNT_MANAGEMENT:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要更换账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更换", nil];
            [alert show];
            [alert release];
                        
        }
            break;
        case FEEDBACK:
            [self showFeedback];
            break;
        case  SHARES :
            [self showShare];
            break;
        case RECOMMEN_TO_FRIENDS:
            break;
        case RATE_AT_APPLE_STORE:
            break;
        case ABOUT:
            [self showAboutView];
            break;
        case UPDATE:
           [self updateApplication];
            break;
        default:
            break;
    }
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)askFriendsToGoToWorkout{
    
}

-(void)findACoach{
    NSLog(@"find a coach");
    [self performSegueWithIdentifier:@"CoachSegue" sender:self];
}

-(void)showFeedback{
    
    [self performSegueWithIdentifier:@"FeedbackSegue" sender:self];
    
}

-(void)showWorkoutPlans{
    
       
}


-(void)showShare
{
    
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:NSLS(@"取消")
                                         destructiveButtonTitle:NSLS(@"分享到新浪微博")
                                              otherButtonTitles:NSLS(@"分享到腾讯微博"),NSLS(@"通过邮箱"),NSLS(@"通过短信"),nil];
    
  
    [share showFromTabBar:self.tabBarController.tabBar];
    [share release];

}

- (void)showRecommendation
{
    whichAcctionSheet = RECOMMENDATION;
    [self showShare];

}


-(void)showAboutView{
    
    [self performSegueWithIdentifier:@"AboutViewControllerSegue" sender:self];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
//    
//    if (LANGUAGE_SELECTION == whichAcctionSheet)
//    {
//        if (buttonIndex == actionSheet.cancelButtonIndex){
//            return;
//        }
//        
////        [LanguageManager setLanguage:buttonIndex];
////        [((FootballScoreAppDelegate *)[UIApplication sharedApplication].delegate) setSeletedTabbarIndex:TAB_REALTIME_SCORE];
////        [self popupHappyMessage:FNS(@"请刷新查看") title:nil];
//    
//    }
//    
    
    
     if (  whichAcctionSheet == RECOMMENDATION )
    {
        NSString *bodyStringBegin = @"朋友，我正在使用爱健美客户端，学习如何健身，分享，很方便很好用，下载地址是";
        NSString *bodyStringWebsite = @"http://www.aijianmei.com";
        
        NSString *bodyString = [NSString stringWithFormat:@"%@%@", bodyStringBegin, bodyStringWebsite];
        
        enum BUTTON_INDEX {
            
            SEND_SINA_WEIBO= 0,
            SEND_TENGXUN_WEIBO,
            SEND_EMAIL ,
            SEND_MESSAGE ,
            CANCLE_BUTTON
        };
        
        
        NSInteger BUTTON_INDEX ;
        BUTTON_INDEX  = buttonIndex;
        

        switch (BUTTON_INDEX) {
            case SEND_SINA_WEIBO:
            {
                
                ShareToSinaController *sc = [[ShareToSinaController alloc]init];
                [self.navigationController pushViewController:sc animated:YES];
                [sc release];
                
            }
               break;
            case SEND_TENGXUN_WEIBO:
            {
                ShareToQQWeiboController *sc = [[ShareToQQWeiboController alloc]init];
                [self.navigationController pushViewController:sc animated:YES];
                [sc release];
                
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



-(void)updateApplication{

//    [self popupHappyMessage:@"已经是最新版本" title:nil];
    
    [[UserService defaultService] queryVersion:self];

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)sinaWeiBlogshareButton:(id)sender {
    
    
    
    // 首先判断服务器是否可以访问
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
//        NSLog(@"Available server of sinaWeiBlog");
//        
//        // 使用SLServiceTypeSinaWeibo来创建一个新浪微博view Controller
//        SLComposeViewController *socialVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
//        
//        // 写一个bolck，用于completionHandler的初始化
//        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
//            if (result == SLComposeViewControllerResultCancelled) {
//                NSLog(@"cancelled\\");
//            } else
//            {
//                NSLog(@"done\\");
//            }
//            [socialVC dismissViewControllerAnimated:YES completion:Nil];
//        };
//        // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
//        socialVC.completionHandler = myBlock;
//        
//        // 给view controller初始化默认的图片，url，文字信息
//        UIImage *image = [UIImage imageNamed:@"b_menu_1s.png"];
//        
//        
//        NSURL *url = [NSURL URLWithString:@"www.google.com"];
//        
//        [socialVC setInitialText:@"www.google.com.hk"];
//        [socialVC addImage:image];
//        [socialVC addURL:url];
//        
//        // 以模态的方式展现view controller
//        [self  presentViewController:socialVC animated:YES completion:Nil];
//        
//    } else {
//        NSLog(@"UnAvailable\\");
   }


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
    }
}



@end
