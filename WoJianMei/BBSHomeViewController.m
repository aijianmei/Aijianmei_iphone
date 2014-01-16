//
//  BBSHomeViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "BBSHomeViewController.h"
#import "IIViewDeckController.h"
#import "ImageManager.h"
#import "BBSViewController.h"
#import "DeviceDetection.h"
#import "BBSHomeCell.h"
#import "BBSPostDetailController.h"
#import "UserManager.h"
#import "PostStatus.h"





#define MAIN_MENU_ORIGIN_Y ISIPAD ? 365 : 0



@interface BBSHomeViewController ()

@end

@implementation BBSHomeViewController
@synthesize myHeaderView =_myHeaderView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc{
    [_myHeaderView release];
    [super dealloc];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self.homeMainMenuPanel animatePageButtons];

}

#pragma mark  Reload and LoadMore Method
//加载新的数据
- (void)reloadTableViewDataSource{
    
    _reloading = YES;
    User *user =[[UserManager defaultManager]user];
    [[PostService sharedService] loadStatusWithUid:user.uid
                                         targetUid:nil
                                          gymGroup:@"0"
                                             start:@"0"
                                            offSet:@"5"
                                    viewController:self];
    
}
//加载更多数据
- (void)loadMoreTableViewDataSource {
    _reloading = NO;
    User *user =[[UserManager defaultManager]user];
    [[PostService sharedService] loadStatusWithUid:user.uid
                                         targetUid:nil
                                          gymGroup:@"0"
                                             start:@"0"
                                            offSet:[NSString stringWithFormat:@"%d", _start]
                                    viewController:self];
    
}

-(void)loadPublicPostDatas
{
    _reloading = YES;
    shouldLoad =YES;
    
    User *user =[[UserManager defaultManager]user];
    
    
    [[PostService sharedService] loadStatusWithUid:user.uid
                                         targetUid:nil
                                          gymGroup:@"0"
                                             start:@"0"
                                            offSet:@"5"
                                    viewController:self];
}

- (void)viewDidLoad
{
    
    self.supportRefreshHeader = YES;
    self.supportRefreshFooter = YES;

    
    [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
    

    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    
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

    
    
    [self initTableHeaderView];
    
    ///添加主页按钮
    [self addMainMenuView];
    
    
    
//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(handleStaticTimer:) userInfo:nil repeats:YES];
 
    
    
    
    [self loadPublicPostDatas];
    
}


- (void)leftButtonClickHandler:(id)sender
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

- (void)updateView:(UIView *)view originY:(CGFloat)y
{
    CGRect frame = view.frame;
    CGPoint origin = frame.origin;
    origin.y = y;
    frame.origin = origin;
    view.frame = frame;
}

- (float)getMainMenuOriginY
{
    return MAIN_MENU_ORIGIN_Y;
}



- (void)addMainMenuView
{
    self.homeMainMenuPanel = [HomeMainMenuPanel createView:self];
    [self.dataTableView.tableHeaderView addSubview:self.homeMainMenuPanel];
    
    [self.homeMainMenuPanel setBackgroundColor:[UIColor redColor]];
    
    //TODO update frame
    [self updateView:self.homeMainMenuPanel originY:[self getMainMenuOriginY]];
    
}

-(void)initTableHeaderView{
    UIView *headerView =[[UIView alloc]init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 244)];
    }else{
        [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 360.0f)];
    }
    self.myHeaderView = headerView;
    [headerView release];
    [self.dataTableView setTableHeaderView:_myHeaderView];
}




#pragma mark - get && update statistic
- (void)handleStaticTimer:(NSTimer *)theTimer
{
    PPDebug(@"<handleStaticTimer>: get static");
    //    [[UserService defaultService] getStatistic:self];
    
    
    
    ///假装已经获得数据
    [self didSyncStatisticWithResultCode:0];
    
    
    [self dataSourceDidFinishLoadingNewData];
    [self dataSourceDidFinishLoadingMoreData];
    
    
}

- (HomeCommonView *)panelForType:(HomeMenuType)type
{
    return self.homeMainMenuPanel;
}

- (void)updateBadgeWithType:(HomeMenuType)type badge:(NSInteger)badge
{
    HomeCommonView *panel = [self panelForType:type];
    [panel updateMenu:type badge:badge];
}

- (void)updateAllBadge
{
    [self updateBadgeWithType:HomeMenuTypeDrawMessage badge:2];
    [self updateBadgeWithType:HomeMenuTypeDrawFriend badge:2];
    [self updateBadgeWithType:HomeMenuTypeDrawBBS badge:2];
    [self updateBadgeWithType:HomeMenuTypeDrawTimeline badge:2];
    [self updateBadgeWithType:HomeMenuTypeDrawContest badge:2];
    
}
- (void)didSyncStatisticWithResultCode:(int)resultCode
{
    if (resultCode == 0) {
        [self updateAllBadge];
    }
}


- (void)homeMainMenuPanel:(HomeMainMenuPanel *)mainMenuPanel
             didClickMenu:(HomeMenuView *)menu
                 menuType:(HomeMenuType)type
{
    PPDebug(@"<homeMainMenuPanel>, click type = %d", type);
    
    
    
    switch (type) {
            //draw main menu
        case HomeMenuTypeDrawDraw :{
            PPDebug(@"增肌增重");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [vc setTitle:menu.title.text];
            [self.navigationController pushViewController:vc animated:YES
             ];
            [vc release];
        }
            break;
        case HomeMenuTypeDrawGuess:{
            PPDebug(@"瘦身减肥");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawGame:{
            PPDebug(@"肩部");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawTimeline:{
            PPDebug(@"胸肌");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawRank:{
            PPDebug(@"背部");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawContest:{
            PPDebug(@"腹肌");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawBBS:{
            PPDebug(@"腰部");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawBigShop:
        {
            PPDebug(@"更多");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
            //For woman
        case HomeMenuTypeDrawShop:{
            PPDebug(@"增肌增重");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawApps:{
            PPDebug(@"瘦身减肥");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawPhoto:
        {
            PPDebug(@"腿部锻炼");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawMessage:
        {
            PPDebug(@"上肢锻炼");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawFriend:
        {
            PPDebug(@"腹部锻炼");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawFreeCoins:
        {
            PPDebug(@"臀部锻炼");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawPlayWithFriend:{
            PPDebug(@"生理期锻炼");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
        case HomeMenuTypeDrawMore:{
            PPDebug(@"更多");
            BBSViewController *vc = [[BBSViewController alloc]initWithNibName:@"BBSViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
        default:
            break;
    }
}


#pragma mark --
#pragma mark  tableviewDelegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [BBSHomeCell getCellIdentifier];
	BBSHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [BBSHomeCell createCell:self];
	}

    PostStatus *post = [self postStatusForIndexPath:indexPath];
    [cell updateCellWithBBSPost:post];
    
	return cell;
    
    
}

- (PostStatus *)postStatusForIndexPath:(NSIndexPath *)indexPath
{
    NSArray *dList = self.dataList;
    if (indexPath.row >= [dList count]) {
        return nil;
    }
    PostStatus *action = [self.dataList objectAtIndex:indexPath.row];
    return action;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PostStatus *post = [self.dataList objectAtIndex:indexPath.row];
	return [BBSHomeCell getCellHeightWithBBSPost:post];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBSPostDetailController *vc = [[BBSPostDetailController alloc]initWithNibName:@"BBSPostDetailController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didLoadStatusesSucceeded:(int)errorCode didLoadObjects:(NSArray *)objects
{
    [self dataSourceDidFinishLoadingNewData];
    [self dataSourceDidFinishLoadingMoreData];
    
    [self hideActivity];
    PPDebug(@"***Load objects count: %d", [objects count]);
    
    if ([objects count] == 0) {
        [self popupMessage:@"亲,已经没有更多数据了！" title:nil];
        return;
    }
    
    
    
    PostStatus *postStatus =  [objects objectAtIndex:0];
    PPDebug(@"*****Get Statuses Successfully!!!*****");
    PPDebug(@"******%@******",postStatus._id);
    PPDebug(@"******%@******",postStatus.uid);
    PPDebug(@"******%@******",postStatus.content);
    PPDebug(@"******%@******",postStatus.imageurl);
    PPDebug(@"******%@******",postStatus.create_time);
    NSMutableArray *newDataList =nil;
    
    if (_start == 0) {
        self.dataList = objects;
    } else {
        
        newDataList = [NSMutableArray arrayWithArray:self.dataList];
        [newDataList addObjectsFromArray:objects];
        if (_reloading) {
            [newDataList setArray:objects];
            _start =0;
            
        }
        self.dataList = newDataList;
    }
    
    _start += [objects count];
    PPDebug(@"****objects %d******",[self.dataList count]);
    [self.dataTableView reloadData];
    
}

@end
