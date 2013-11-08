
//
//  HomeViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 6/26/13.
//
//
#import "HomeViewController.h"
#import "PlayVideoViewController.h"
#import "VideoCell.h"
#import "ArticleCell.h"
#import "ArticleInfo.h"
#import "ArticleManager.h"
#import "WorkOut.h"
#import "iCarousel.h"
#import "ArticleService.h"
#import "Article.h"
#import "CommonArticleViewController.h"
#import "IIViewDeckController.h"
#import "AppDelegate.h"
#import "PublicMyselfViewController.h"
#import "LoginViewController.h"
#import "Result.h"
#import "Video.h"
#import "Myself_SettingsViewController.h"
#import "UserManager.h"


#import "ImageManager.h"
#import "UIImageView+WebCache.h"
#import "SDSegmentedControl.h"
#import "BaiduMobStat.h"
#import "DeviceDetection.h"

#import "PPNetworkRequest.h"






///// the setings of the iCarousel
#define NUMBER_OF_ITEMS 4
#define NUMBER_OF_VISIBLE_ITEMS 18
#define ITEM_SPACING 320
#define EACH_FETCH_SIZE 5

#define SCROLL_VIEW_TAG 20120913
#define More_BUTTON_TAG 20130607


typedef enum CONTENT_TYPE {
    NEW_TYPE= 0,
    WORKOUT_TYPE =1,
    BASIC_TYPE =2,
    VIDEO_TYPE =3
    
}CONTENT_TYPE;



@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize myHeaderView =_myHeaderView;
@synthesize  carousel =_carousel;
@synthesize spacePageControl =_spacePageControl;
@synthesize segmentedController =_segmentedController;
@synthesize buttonScrollView =_buttonScrollView;
@synthesize currentButton = _currentButton;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
    [_myHeaderView release];
    [_carousel release];
    [_spacePageControl release];
    [_segmentedController release];
    [_buttonScrollView release];
    [_currentButton release];
    [super dealloc];
}


#pragma mark -
#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"HomeView"];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"HomeView"];
}


- (void)viewDidLoad
{
    self.supportRefreshHeader = YES;
    self.supportRefreshFooter = YES;
    [super viewDidLoad];
    
    [self initUI];
    [self initMoreUI];
    
    ///// 设置开始
    SDSegmentedControl *sender =[[SDSegmentedControl alloc]init];
    [_segmentedController setSelectedSegmentIndex:0];
    
    if ([[UserManager defaultManager]user]) {
        [self buttonClicked:sender];

    }
    
}

- (void)initMoreUI
{    
    ////leftBtn
    UIButton *leftBtn = [[[UIButton alloc] init] autorelease];
    [leftBtn setImage:[ImageManager GobalNavigationLeftSideButtonImage] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];

    ////rightBtn
    UIButton *rightBtn = [[[UIButton alloc] init] autorelease];
    [rightBtn setImage:[ImageManager GobalNavigationAvatarImage] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0.0, 0.0, 49.0, 29.0);
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
    User *user = [[UserManager defaultManager] user];
    
    if (user.uid) {
        Myself_SettingsViewController *vc =[[Myself_SettingsViewController alloc]initWithNibName:@"Myself_SettingsViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];

    }else{
        
        [[AppDelegate  getAppDelegate] showLoginView];
    }
}


#pragma mark -
#pragma mark  UPDATEUI  Methods
-(void)updateUserInterface{
    [self hideActivity];
    [self.carousel reloadData];
    [self.dataTableView reloadData];
    [_spacePageControl setNumberOfPages:NUMBER_OF_ITEMS];
}


//// init the userInterface
-(void)initUI{
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    //初始化TableView Header
    [self initTableHeaderView];
    ///添加滑动图片
    [self addCarouselSliders];
    //添加顶部导航按钮
    [self addButtonScrollView];
    //添加当前划片的提示
    [self addSpacePageControl];

    [[AppDelegate getAppDelegate] showLoginView];
}


-(void)pushToMyselfViewController:(id)sender{
        
    ///// 设置开始
    [self buttonClicked:_segmentedController];

}

-(void)pushToMyselfViewControllerFrom:(UIViewController *)viewController{

    [self rightButtonClickHandler:viewController];
}

#pragma mark-- addButtonScrollView Method

-(void)initTableHeaderView{
    
    
    UIView *headerView =[[UIView alloc]init];
    [headerView setFrame: CGRectMake(0, 0, 320, 200)];
    
    if ([DeviceDetection isOS7]) {

    [headerView setFrame: CGRectMake(0, 0, 320, 265)];

    }
    
    self.myHeaderView = headerView;
    [headerView release];
    [self.dataTableView setTableHeaderView:_myHeaderView];
}


#pragma mark-- addButtonScrollView Method
-(void)addButtonScrollView{
    ////Configure The ButtonScrollView
    
    NSArray *buttonTitleArray =[NSArray arrayWithObjects:@"最新文章",@"最热文章",@"最新视频",@"最热视频", nil];
    

    self.segmentedController=[[SDSegmentedControl alloc]initWithItems:buttonTitleArray];
    [_segmentedController setFrame:CGRectMake(0, 0, 320, 40)];
    
    if ([DeviceDetection isOS7]) {
        
        [_segmentedController setFrame:CGRectMake(0, 65, 320, 40)];
        
    }
    [_segmentedController setSelectedSegmentIndex:0];    
    [_segmentedController addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventValueChanged];
    [_myHeaderView addSubview:self.segmentedController];
}

#pragma mark-- 
#pragma mark-- addCarouselSliders Method

-(void)addCarouselSliders{
    //configure carousel
    self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 115 - 65, 320, 140)];
    
    
    if ([DeviceDetection isOS7]) {
        
        [_carousel setFrame: CGRectMake(0, 115, 320, 140)];
        
    }

    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    _carousel.type = iCarouselTypeLinear;
    [_carousel setScrollEnabled:YES];
    //可以调整slider 的滑动速度;
    [_carousel setScrollSpeed:0.25f];
    
    [_myHeaderView addSubview:self.carousel];
}

#pragma mark-- 
#pragma mark-- MoreButon Method
-(void)addSpacePageControl{
    ////The page controll
    
    
   // 10, 190, 320, 20
    //215, 185, 120, 20
    self.spacePageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(0, 196 +65, 320, 20)];
    [_spacePageControl setBackgroundColor:[UIColor clearColor]];
    _spacePageControl.numberOfPages = [self.dataList count];
    [_spacePageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"currentPageDot.png"]];
    [_spacePageControl setPageIndicatorImage:[UIImage imageNamed:@"pageDot.png"]];
    [_spacePageControl addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
    [_myHeaderView addSubview:self.spacePageControl];
}

#pragma mark-- MoreButon Method
-(void)addMoreButton
{

    UIButton *moreButotn = [[UIButton alloc]initWithFrame:CGRectMake(270, 0, 40, 30)];
    [moreButotn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [moreButotn setBackgroundImage:[UIImage imageNamed:@"Catalog_More_Button.png"] forState:UIControlStateNormal];
    [moreButotn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [moreButotn setTag:More_BUTTON_TAG];
    
    [_myHeaderView addSubview:moreButotn];
    [moreButotn release];

}

#pragma mark-- ButtonClicked Method
-(void)buttonClicked:(SDSegmentedControl *)sender

{
    self.segmentedController = (SDSegmentedControl *)sender;
    
    //开始下载文章
    
    //listtype  1 视频和文章的混合
    //          2 单独是文章
    //          3 单独是视频
    NSString *aucode= @"aijianmei";
    NSString *auact = @"au_getinformationlist";
    NSString *listtype = @"2";
    NSString *category = @"train";
    NSString *type = @"hot";
    int offset = EACH_FETCH_SIZE;
    NSString *cateid = @"0";
    NSString *uid = @"265";
    
    User *user = [[UserService defaultService] user];
    NSString *userUid = user.uid;
    
    if (userUid) {
        uid = userUid;
    }

    if (self.segmentedController.selectedSegmentIndex ==0 ||self.segmentedController.selectedSegmentIndex ==-1) {
        
        category = @"home";
        listtype = @"2";
        type = @"new";
        cateid = @"1";
        _start=0;
        
    }
    if (self.segmentedController.selectedSegmentIndex ==1) {
        
        category = @"home";
        listtype = @"2";
        type = @"hot";
        cateid = @"1";
        _start=0;
        
    }
    if (self.segmentedController.selectedSegmentIndex ==2) {
        
        category = @"home";
        listtype = @"3";
        type = @"new";
        cateid = @"0";
        _start=0;
    }
    if (self.segmentedController.selectedSegmentIndex ==3) {
        
        category = @"home";
        listtype = @"3";
        type = @"hot";
        cateid = @"0";
        _start=0;
        
    }
    
    [[ArticleService sharedService] findArticleWithAucode:aucode
                                                    auact:auact
                                                 listtype:listtype
                                                 category:category
                                                     type:type
                                                    start:_start
                                                   offset:offset
                                                   cateid:cateid
                                                      uid:uid
                                           viewController:self];
    
}

#pragma mark--
#pragma mark-- PageControl

- (void)pageControl:(id)sender
{
	NSLog(@"Current Page (UIPageControl) : %i", _spacePageControl.currentPage);
}

- (void)spacePageControl:(SMPageControl *)sender
{
	NSLog(@"Current Page (SMPageControl): %i", sender.currentPage);
}


#pragma Pull Refresh Delegate
- (void)reloadTableViewDataSource
{
    
    [self buttonClicked:self.segmentedController];
}

#pragma mark - Load More
- (void) loadMoreTableViewDataSource
{
    NSString *aucode= @"aijianmei";
    NSString *auact = @"au_getinformationlist";
    NSString *listtype = @"2";
    NSString *category = @"";
    NSString *type = @"hot";
    int offset = EACH_FETCH_SIZE;
    NSString *cateid = @"0";
    NSString *uid = @"265";

    User *user = [[UserService defaultService] user];
    NSString *userUid = user.uid;
    
    if (userUid) {
        uid = userUid;
    }
    
    if (self.segmentedController.selectedSegmentIndex ==0) {
        
        category = @"home";
        listtype = @"2";
        type = @"new";
        cateid = @"";

        
    }
    if (self.segmentedController.selectedSegmentIndex ==1) {
        
        category = @"home";
        listtype = @"2";
        type = @"hot";
        cateid = @"0";

    }
    if (self.segmentedController.selectedSegmentIndex ==2) {
        
        category = @"home";
        listtype = @"3";
        type = @"new";
        cateid = @"";

    }
    if (self.segmentedController.selectedSegmentIndex ==3) {
        
        category = @"home";
        listtype = @"3";
        type = @"hot";
        cateid = @"";

    }
    
    [[ArticleService sharedService] findArticleWithAucode:aucode
                                                    auact:auact
                                                 listtype:listtype
                                                 category:category
                                                     type:type
                                                    start:_start
                                                   offset:offset
                                                   cateid:cateid
                                                      uid:uid
                                           viewController:self];
    
    
}

#pragma mark --
#pragma mark  tableviewDelegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [ArticleCell getCellIdentifier];
	ArticleCell *cell = (ArticleCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [ArticleCell createCell:self];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    Article *article  = [self.dataList objectAtIndex:indexPath.row];
    if (article) {
        [cell setCellInfo:article];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  [ArticleCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.segmentedController.selectedSegmentIndex ==0 ||self.segmentedController.selectedSegmentIndex ==1 || self.segmentedController.selectedSegmentIndex ==-1)
    {
        CommonArticleViewController *workOutVc = [[CommonArticleViewController alloc]initWithNibName:@"CommonArticleViewController" bundle:nil];
        workOutVc.article = [self.dataList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:workOutVc animated:YES];
        [workOutVc release];
        
    }else if (self.segmentedController.selectedSegmentIndex ==2 || self.segmentedController.selectedSegmentIndex ==3)
    {
    
        PlayVideoViewController *playVc =[[PlayVideoViewController alloc]initWithNibName:@"PlayVideoViewController" bundle:nil];
        playVc.video  = [self.dataList objectAtIndex:indexPath.row];
       [self.navigationController pushViewController:playVc animated:YES];
        [playVc release];
    
    }
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
        return NUMBER_OF_ITEMS;
//    return [self.dataList count];
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //if you have less than around 30 items in the carousel
    //you'll get better performance if NUMBER_OF_VISIBLE_ITEMS >= NUMBER_OF_ITEMS
    //because then the item view reflections won't have to be re-generated as
    //the carousel is scrolling
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
	//create new view if no view is available for recycling
    
    Article *article  = [self.dataList objectAtIndex:index];

    UILabel *label = nil;
    
	if (view == nil)
	{
        //set up content
		view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 160.0f)] autorelease];
        
        ///add images
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 160.0f)];
        [imageView setImageWithURL:[NSURL URLWithString:article.img] placeholderImage:[UIImage imageNamed:@""]];
        [view addSubview:imageView];
        [imageView release];
    
	}
	else
	{
		label = [[view subviews] lastObject];
	}
	
    //set label
	label.text = [NSString stringWithFormat:@"%@", article.title];
        
	return view;
    
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    PPDebug(@"I did selected the picture of %d",index);
    
    if (self.segmentedController.selectedSegmentIndex ==0 ||self.segmentedController.selectedSegmentIndex ==1 || self.segmentedController.selectedSegmentIndex ==-1)
    {
        CommonArticleViewController *workOutVc = [[CommonArticleViewController alloc]initWithNibName:@"CommonArticleViewController" bundle:nil];
        workOutVc.article = [self.dataList objectAtIndex:index];
        [self.navigationController pushViewController:workOutVc animated:YES];
        [workOutVc release];
        
    }else if (self.segmentedController.selectedSegmentIndex ==2 || self.segmentedController.selectedSegmentIndex ==3)
    {
        
        PlayVideoViewController *playVc =[[PlayVideoViewController alloc]initWithNibName:@"PlayVideoViewController" bundle:nil];
        playVc.video  = [self.dataList objectAtIndex:index ];
        [self.navigationController pushViewController:playVc animated:YES];
        [playVc release];
        
    }
}

-(void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel{
    
    PPDebug(@"%d",[carousel currentItemIndex]);
    
    [self.spacePageControl setCurrentPage:[carousel currentItemIndex]];
}


#pragma mark -
#pragma mark - ScrollViewDidScrollDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    PPDebug(@"*****%@******",[scrollView description]);
    
    
}









#pragma mark -
#pragma mark - DidGetArticleArrayMethods
-(void)didGetArticleArray:(NSArray *)objects errorCode:(int)errorCode
{
    
    if (errorCode ==ERROR_NETWORK) {
        
        return ;
    }
    

    NSLog(@"***Load objects count: %d", [objects count]);
	[self dataSourceDidFinishLoadingNewData];
    [self dataSourceDidFinishLoadingMoreData];
    
    [self hideProgressHUDActivity];
    
    
    if ([objects count] <=0) {
        
        [self popupUnhappyMessage:@"亲！没有更多数据了！" title:nil];
        return;
    }
    

    
    if ([[objects objectAtIndex:0] isMemberOfClass:[Article class]])
    {
        
        if (_start == 0) {
            
            
           self.dataList = objects;
            
//          [self writeArticleListToDisk:objects];

            
        } else {
            NSMutableArray *newDataList = [NSMutableArray arrayWithArray:self.dataList];
            [newDataList addObjectsFromArray:objects];
            self.dataList = newDataList;
            
//           [self writeArticleListToDisk:newDataList];
            
        }
        _start += [objects count];
        
    
        
        //更新用户界面；
        [self updateUserInterface];
    }
    
}


-(void)writeArticleListToDisk:(NSArray *)articleList{
    
    //Write写入方式：永久保存在磁盘中。具体方法为：
    // 第一步：获得文件即将保存的路径：
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *ourDocumentPath =[documentPaths objectAtIndex:0];
    
    //  第二步：生成在该路径下的文件：
    NSString *FileName=[ourDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"CurrentIndex%d",self.segmentedController.selectedSegmentIndex]];
    //fileName就是保存文件的文件名
    
    //第三步：往文件中写入数据：
    //将NSData类型对象data写入文件，文件名为FileName
    //     BOOL writeDataSuccess =  [self.dataList writeToFile:FileName atomically:YES];
    
    
    
//    if ([articleList isEqualToArray:self.dataList]) {
//        return ;
//    }
    
    

    //将NSObject类型对象data写入文件，文件名为FileName
    BOOL writeDataSuccess  = [NSKeyedArchiver archiveRootObject:articleList toFile:FileName];
    
    if (writeDataSuccess) {
        PPDebug(@"********保存数据服务器下载数据成功********");
        PPDebug(@"******%@*****",FileName);
    }
    
    // 第四步最后：从文件中读出数据：
    //从FileName中读取出数据
    // NSData *data=[NSData dataWithContentsOfFile:FileName options:0 error:NULL];
    
    
    //从FileName中读取出数据
    // NSArray *arr=[NSData dataWithContentsOfFile:FileName options:0 error:NULL];
    
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:FileName];
    
    self.dataList =arr;
    
    Article *article = [arr objectAtIndex:0];
    PPDebug(@"what :%@",article.title);
    
}

-(NSArray *)readArticleListFromDiskWithFileName:(NSString *)fileName
{
   /* /var/mobile/Applications/A2CE33CB-8713-44DC-A196-9017CAE9CC72/Documents/CurrentIndex-1
   */
    
    NSString *path = [NSString stringWithFormat:@"/var/mobile/Applications/A2CE33CB-8713-44DC-A196-9017CAE9CC72/Documents/%@",fileName];
    
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

    return arr;

}





@end
