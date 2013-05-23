//
//  ProductListViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreFoundation/CoreFoundation.h>

#import "VideosListViewController.h"
#import "VideoListCell.h"
#import "Video.h"
#import "VideoManager.h"
#import "WorkOut.h"
#import "MFSideMenu.h"


#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark - action method
#define BODY_PART_BASE_BUTTON_TAG 1600
#define BODY_PART_MY_PLAN_TAG 1604

#define BODY_PART_END_BUTTON_TAG BODY_PART_MY_PLAN_TAG


#define HHNetDataCacheNotification @"HHNetDataCacheNotification"


@interface VideosListViewController ()

@end

@implementation VideosListViewController
@synthesize mainArray =_mainArray;
@synthesize selectedButton =_selectedButton;
@synthesize myFollowButton =_myFollowButton;
//@synthesize myFollowCountView =_myFollowCountView;
@synthesize showBigImageViewController =_showBigImageViewController;

@synthesize userID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}


-(void)dealloc{
    
    
    [_mainArray release];
    [_myFollowButton release];
    [_selectedButton release];
    [_showBigImageViewController release];
    
    self.userID = nil;

    [super dealloc];

}


#pragma mark -
#pragma mark -Send WeiBlog


-(void)sendWeiBlog{
    NSLog(@"Send Weibo now");

}


#pragma mark -
#pragma mark -View LifyStytle


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
   
    

   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forBarMetrics:UIBarMetricsDefault]; 
    
    ////init the follow count badge view
    [self myFollowCountBadgeViewInit];
        
    UIBarButtonItem *retwitterBtn = [[UIBarButtonItem alloc]initWithTitle:@"发微博" style:UIBarButtonItemStylePlain target:self action:@selector(sendWeiBlog)];
    self.navigationController.navigationItem.rightBarButtonItem = retwitterBtn;
    [retwitterBtn release];
   
    
    
    
    [self initWorkOutDatas];
    [self clickButtons:self.selectedButton];
    
    
    
    

    
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
       self.selectedButton = nil;
    self.myFollowButton =nil;
    self.dataTableView =nil;
    self.showBigImageViewController = nil;
}



-(void)viewWillAppear:(BOOL)animated{
    //    self.dataTableView.hidden = TRUE;
    
    
    [super viewWillAppear:animated];
    
    UIViewController *nv =[self.navigationController topViewController];
    [nv.navigationController.navigationBar setUserInteractionEnabled:YES];

    [nv.navigationItem setTitle:@"健身视频"];
    [nv.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStyleBordered target:self action:nil];
    [bar setTitle:@"碧珍"];
    [nv.navigationItem setRightBarButtonItem:bar];
    
    [bar setAction:@selector(iamTomsGirlfriend)];
    
    
    UIBarButtonItem *rightbarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered target:self action:nil];
    [nv.navigationItem setLeftBarButtonItem:rightbarButton];
    
//    
//    [MFSideMenuManager sharedManager].navigationController.menuState = MFSideMenuStateVisible;
//    [MFSideMenuManager sharedManager].navigationController.menuState = MFSideMenuStateHidden;
    

 }

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self showTabBar];
}

#pragma mark -
#pragma mark - UIdataTableViewDelegate

- (NSInteger)numberOfSectionsIndataTableView:(UITableView *)dataTableView {
    
    
    return 1;		// default implementation
	
}

// Customize the number of rows in the table view.
- (NSInteger)dataTableView:(UITableView *)dataTableView numberOfRowsInSection:(NSInteger)sectio
{
    
    return [dataList count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)dataTableView:(UITableView *)thedataTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [VideoListCell getCellIdentifier];
   VideoListCell *cell = (VideoListCell*)[self.dataTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (!cell) {
     cell  = [[[VideoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
;
    }
    

    cell.delegate = self;
//    cell.indexPath = indexPath;
    Video *video  = [dataList objectAtIndex:indexPath.row];
    if (video) {
        [cell setCellInfo:video];
    }

    return cell;
}


- (void)dataTableView:(UITableView *)dataTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  [self performSegueWithIdentifier:@"VideoSegue" sender:self];
    
}

- (CGFloat)dataTableView:(UITableView *)dataTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (isPad) {
        return 210.f;
    }
    return  [VideoListCell getCellHeight];
}



#pragma mark -
#pragma mark MYFollowCountBadgeView Methods
- (void)myFollowCountBadgeViewInit
{
//    NSInteger tagLen = 20;
//    CGRect rect = [_myFollowButton bounds];    
//    UIBadgeView *badgeView = [[UIBadgeView alloc] initWithFrame:CGRectMake(rect.size.width-tagLen, -1, tagLen, tagLen)];
//    self.myFollowCountView = badgeView;
//    [badgeView release];
//    
//    [self.myFollowCountView setShadowEnabled:NO];
//    [self.myFollowCountView setBadgeColor:[UIColor redColor]];
//    [self.myFollowButton addSubview:_myFollowCountView];
//    [self reloadMyFollowCount];
}

- (void)reloadMyFollowCount
{
//    VideoManager *manager = [VideoManager defaultManager];
//    int followMatchCount = [[manager getAllFollowVideo] count];
//    self.myFollowCountView.badgeString = [NSString stringWithFormat:@"%d", followMatchCount];
//    if (followMatchCount == -1) {
//        [_myFollowCountView setHidden:YES];
//    }
//    else {
//        [_myFollowCountView setHidden:NO];
//    }
}

#pragma mark -
#pragma mark VideosDetailCellDelegate Methods

- (void)reloadMyFollowList
{
    VideoManager *manager = [VideoManager defaultManager];
    if ([manager getAllFollowVideo]==nil) {
        return;
        
        
    }
    self.dataList  = [manager getAllFollowVideo];
   [self.dataTableView reloadData];
}

- (void)didClickFollowButton:(id)sender atIndex:(NSIndexPath *)indexPath{
    
    VideoManager *manager  =[VideoManager defaultManager];
    Video* video = [dataList objectAtIndex:indexPath.row];
    
    if (video.isFollow == [NSNumber numberWithBool:YES]){
//        [GlobalGetMatchService() unfollowMatch:[UserManager getUserId] match:match];
    [manager unfollowVideo:video];
//    [ShowAlertTextViewController show:self.view message:@"已取消该计划"];
    }
    else{
//        [GlobalGetMatchService() followMatch:[UserManager getUserId] match:match]; 
    [manager followVideo:video];
//    [ShowAlertTextViewController show:self.view message:@"已添加到计划中"];

    }
    
   if (matchSelectStatus == BODY_PART_MY_PLAN_TAG){
        // only unfollow is possible here... so just update data list and delete the row
        Video* videoInVideoArray = [manager getVideoById:video.videoId];
        [videoInVideoArray setIsFollow:[NSNumber numberWithBool:NO]];//because in 
      [self reloadMyFollowList];    // I am lazy today so I just reload the table view
    }
    else{
        [self.dataTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
                                  withRowAnimation:UITableViewRowAnimationNone];
    }
        [self reloadMyFollowCount];
}


- (void)didClickBuyButton:(id)sender atIndex:(NSIndexPath *)indexPath{
    
    //    UIAlertView *alertView  = [[UIAlertView alloc]initWithTitle:@"Buy This Video" message:@"Are you sure want to buy this Video ?" delegate:self cancelButtonTitle:@"Cancle" otherButtonTitles:@"I buy it next time !",@"yeah babe, i want to buy it ! ",nil] ;
    //
    //    [alertView show];
    //    [alertView release];
    
    
    
    
}



-(void)didClickSinaWeiBlogButton:(id)sender atIndex:(NSIndexPath *)indexPath{
  
//   Video *video = [_dataList objectAtIndex:indexPath.row];
//
//    if(kCFCoreFoundationVersionNumber >kCFCoreFoundationVersionNumber_iOS_5_1)
//    {
//        NSLog( @"After Version 5.0" );
//        // 首先判断服务器是否可以访问
//        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
//            NSLog(@"Available server of sinaWeiBlog");
//            
//            // 使用SLServiceTypeSinaWeibo来创建一个新浪微博view Controller
//            SLComposeViewController *socialVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
//            
//            // 写一个bolck，用于completionHandler的初始化
//            SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result) {
//                if (result == SLComposeViewControllerResultCancelled) {
//                    NSLog(@"cancelled\\");
//                } else
//                {
//                    NSLog(@"done\\");
//                }
//                [socialVC dismissViewControllerAnimated:YES completion:Nil];
//            };
//            // 初始化completionHandler，当post结束之后（无论是done还是cancell）该blog都会被调用
//            socialVC.completionHandler = myBlock;
//            
//            // 给view controller初始化默认的图片，url，文字信息
//            UIImage *shareImage = video.image;
//            
//            NSURL *url = [NSURL URLWithString:@"www.aijianmei.com"];
//            NSString *workMethod = [NSString stringWithFormat:@"在中华健美客户端的帮助下,我练习了<<%@>>%@,每组%@,一共%@",video.title,video.workOut.sets,video.workOut.repeatTimes,video.workOut.workOutTimeLength];
//
//            [socialVC setInitialText:workMethod];
//            [socialVC addImage:shareImage];
//            [socialVC addURL:url];
//            
//            // 以模态的方式展现view controller
//            [self  presentViewController:socialVC animated:YES completion:Nil];
//            
//        } else {
//            NSLog(@"UnAvailable\\");
//        }
//    }
//    else
//    {
//        NSLog( @"Version 4.0 or earlier" );
//        TwitterVC *tv = [[TwitterVC alloc]initWithNibName:@"TwitterVC" bundle:nil];
//        tv.demoWorkOutImage = [video image];
//        
//        ///练习了3组，4次，共30分钟；
//        tv.demoWorkOutMethods = [NSString stringWithFormat:@"<<%@>>%@,每组%@,一共%@",video.title,video.workOut.sets,video.workOut.repeatTimes,video.workOut.workOutTimeLength];
//        
//        [self.navigationController pushViewController:tv animated:YES];
//        [tv release];
//
//    }
    
}



-(void)clickShowBigImage:(id)sender atIndex:(NSIndexPath *)indexPath{
          
   
}

- (void)didDetectDoubleTap:(UITapGestureRecognizer *)tap{
    
    [tap.view removeFromSuperview];
    NSLog(@"Dismiss the ImageView");
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

#pragma mark -
#pragma mark BodyButtons Methods
- (IBAction)clickButtons:(id)sender{
    UIButton *button = (UIButton *)sender;
    button.selected = YES;
    for (int i = BODY_PART_BASE_BUTTON_TAG; i <= BODY_PART_MY_PLAN_TAG; ++ i) {
        if (i != button.tag) {
            UIButton *unselectedButton = (UIButton *)[self.view viewWithTag:i];
            unselectedButton.selected = NO;
        }
    }
    enum BODDY_PART_TAG {
        ALL_AREA_PART= BODY_PART_BASE_BUTTON_TAG,
        UPPER_BODY_PART ,
        MIDDLE_BODY_PART,
        LOWER_BODY_PART,
        MY_PLAN_PART
    }
    
    BODDY_PART_TAG = button.tag;
    ///at the my plan_button
    matchSelectStatus = BODDY_PART_TAG;

    switch (BODDY_PART_TAG) {
        case ALL_AREA_PART:
            [self clickAllVideosButton:nil];
            break;
        case UPPER_BODY_PART:
            [self clickUpperBodyButton:nil];
            break;
        case MIDDLE_BODY_PART:
            [self clickMiddleBodyButton:nil];
            break;
        case LOWER_BODY_PART:
            [self clickLowerBodyButton:nil];
            break;
        case MY_PLAN_PART:
            [self clickMyPlanButton:nil];
            break;
        default:
            break;
    }
    
}
- (void)clickUpperBodyButton:(id)sender
{
    VideoManager *manager =[VideoManager defaultManager];
    self.dataList =manager.videoList;
    NSMutableArray *upperBodyArray  =[[NSMutableArray alloc]init];
    [upperBodyArray addObjectsFromArray: [dataList objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 5)]]];
    self.dataList =upperBodyArray;
    [upperBodyArray release];
    [self.dataTableView reloadData];
}
- (void)clickMiddleBodyButton:(id)sender {
    VideoManager *manager =[VideoManager defaultManager];
    self.dataList =manager.videoList;
    NSMutableArray *middleBodyArray =[[NSMutableArray alloc]init] ;
    [middleBodyArray addObjectsFromArray:[dataList objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 5)]]];
    self.dataList =middleBodyArray;
    [middleBodyArray release];
    [self.dataTableView reloadData];
}
- (void)clickLowerBodyButton:(id)sender {
    VideoManager *manager =[VideoManager defaultManager];
    self.dataList =manager.videoList;
    NSMutableArray *lowerBoddyArray =[[NSMutableArray alloc]init];
    for (int i=10; i<=14; i++) {
        [lowerBoddyArray addObject:[dataList objectAtIndex:i]];
    }
    self.dataList = lowerBoddyArray;
    [lowerBoddyArray release];
    [self.dataTableView reloadData];
}

- (void)clickAllVideosButton:(id)sender {
    
    VideoManager *manager =[VideoManager defaultManager];
    self.dataList =manager.videoList;
    [self.dataTableView reloadData];
}

- (void)clickMyPlanButton:(id)sender {
    
   [self reloadMyFollowList];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void)initWorkOutDatas{
    
    //    Upper Area
    //    Trapezius ( neck ) >
    //    Deltoid ( shoulders ) >
    //    Biceps ( arms ) >
    //    Triceps ( arms ) >
    //    Forearm ( wrists ) >
    
    //////Upper Area
    WorkOut *workOut =[[WorkOut alloc]init];
    workOut.workOutTimeLength = @"40minutes";
    workOut.repeatTimes = @"7 -12 次";
    workOut.sets = @"6-7组";
    Video *video1 = [[Video alloc]initWithId:@"1"
                                       title:@"Neck_exercises_s"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"neck_exercises_s.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video2 = [[Video alloc]initWithId:@"2"
                                       title:@"Shoulder-Exercises"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"Shoulder-Exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    
    Video *video3 = [[Video alloc]initWithId:@"3"
                                       title:@"Biceps-Exercises"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"Biceps-Exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video4 = [[Video alloc]initWithId:@"4"
                                       title:@"Triceps-Exercises"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"Triceps-Exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video5 = [[Video alloc]initWithId:@"5"
                                       title:@"Forearm-exercises"
                                   timeLeght:@"30minutes"
                                       image:[UIImage imageNamed:@"forearm-exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    //////Middle  Area
    //    Pectoral ( chest ) >
    //    Abs ( abdomen ) >
    //    Oblique Abs ( lateral abdomen ) >
    //    Dorsal ( back ) >
    //    Lumbar ( lower back ) >
    
    
    
    Video *video6 = [[Video alloc]initWithId:@"6"
                                       title:@"Chest-Exercises_s"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"Chest-Exercises_s.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video7 = [[Video alloc]initWithId:@"7"
                                       title:@"Abs-Exercises_s"
                                   timeLeght:@"20minutes"
                                       image:[UIImage imageNamed:@"Abs-Exercises_s.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video8 = [[Video alloc]initWithId:@"8"
                                       title:@"Oblique-abdominal-exercises"
                                   timeLeght:@"30minutes"
                                       image:[UIImage imageNamed:@"Oblique-abdominal-exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video9 = [[Video alloc]initWithId:@"9"
                                       title:@"ack-Exercises"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"Back-Exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video10 = [[Video alloc]initWithId:@"10"
                                        title:@"Lower-Back-Exercises"
                                    timeLeght:@"50minutes"
                                        image:[UIImage imageNamed:@"Lower-Back-Exercises.jpg"]
                                     isFollow:NO
                                      workOut:workOut ];
    
    
    
    //    Lower Area
    //    Gluteus ( buttocks ) >
    //    Adductor ( internal thigh ) >
    //    Quadriceps ( legs ) >
    //    Femoral ( hamstring ) >
    //    Calf ( ankles )
    
    
    Video *video11= [[Video alloc]initWithId:@"11"
                                       title:@"buttocks-exercises"
                                   timeLeght:@"12minutes"
                                       image:[UIImage imageNamed:@"buttocks-exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut ];
    Video *video12 = [[Video alloc]initWithId:@"12"
                                        title:@"adductor-exercises"
                                    timeLeght:@"34minutes"
                                        image:[UIImage imageNamed:@"adductor-exercises.jpg"]
                                     isFollow:NO
                                      workOut:workOut ];
    Video *video13 = [[Video alloc]initWithId:@"13"
                                        title:@"Quadriceps-exercises"
                                    timeLeght:@"45minutes"
                                        image:[UIImage imageNamed:@"quadriceps-exercises.jpg"]
                                     isFollow:NO
                                      workOut:workOut ];
    Video *video14 = [[Video alloc]initWithId:@"14"
                                        title:@"Hamstring-exercises"
                                    timeLeght:@"40minutes"
                                        image:[UIImage imageNamed:@"hamstring-exercises.jpg"]
                                     isFollow:NO
                                      workOut:workOut ];
    Video *video15 = [[Video alloc]initWithId:@"15"
                                        title:@"Calf-exercises"
                                    timeLeght:@"40minutes"
                                        image:[UIImage imageNamed:@"calf-exercises.jpg"]
                                     isFollow:NO
                                      workOut:workOut ];
    
    [workOut release];
    
    
    
    VideoManager *mangager =[VideoManager defaultManager];
    [mangager addVideo:video1];
    [mangager addVideo:video2];
    [mangager addVideo:video3];
    [mangager addVideo:video4];
    [mangager addVideo:video5];
    [mangager addVideo:video6];
    [mangager addVideo:video7];
    [mangager addVideo:video8];
    [mangager addVideo:video9];
    [mangager addVideo:video10];
    [mangager addVideo:video11];
    [mangager addVideo:video12];
    [mangager addVideo:video13];
    [mangager addVideo:video14];
    [mangager addVideo:video15];
    
    [video1 release];
    [video2 release];
    [video3 release];
    [video4 release];
    [video5 release];
    [video6 release];
    [video7 release];
    [video8 release];
    [video9 release];
    [video10 release];
    [video11 release];
    [video12 release];
    [video13 release];
    [video14 release];
    [video15 release];
    
    
    for (int i =0; i <[mangager.followVideoList  count]; i++) {
        ///get all the follow videos
        Video *video =[[mangager getAllFollowVideo] objectAtIndex:i];
        if (video.isFollow) {
            Video *notFollowVideo =[mangager getVideoById:video.videoId];
            notFollowVideo.isFollow =[NSNumber  numberWithBool:YES];
            NSLog(@"%d",[video.isFollow intValue]);
            NSLog(@"%d",[video.isFollow intValue]);
        }
    }
}



@end
