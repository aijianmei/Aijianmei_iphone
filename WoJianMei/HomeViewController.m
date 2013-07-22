
//
//  HomeViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 6/26/13.
//
//



#import "HomeViewController.h"
#import "ArticleCell.h"
#import "ArticleInfo.h"
#import "ArticleManager.h"
#import "WorkOut.h"
#import "iCarousel.h"
#import "ArticleService.h"
#import "Article.h"
#import "WorkoutDetailViewController.h"
#import "IIViewDeckController.h"
#import "AppDelegate.h"
#import "FilterViewController.h"
#import "MyselfViewController.h"
#import "LoginViewController.h"
#import "Result.h"


#import "ImageManager.h"
#import "UIImageView+WebCache.h"
#import "SDSegmentedControl.h"






///// the setings of the iCarousel
#define NUMBER_OF_ITEMS 13
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
@synthesize loginViewController =_loginViewController;



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
    [_loginViewController release];

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

    UIStoryboard *currentInUseStoryBoard;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIStoryboard * iPhoneStroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        
        currentInUseStoryBoard = iPhoneStroyBoard;
        
    }else{
        
        UIStoryboard * iPadStroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        currentInUseStoryBoard = iPadStroyBoard;
    }
    
    

    User *user = [[UserService defaultService] user];
    
    if (user.uid) {
        MyselfViewController *myselfVC = (MyselfViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"MyselfViewController"];
        myselfVC.title = @"我";
        [self.navigationController pushViewController:myselfVC animated:YES];
    
    }else{
        [self showLoginView];
    }
}


#pragma mark -
#pragma mark  UPDATEUI  Methods
-(void)updateUserInterface{
    [self hideActivity];
    [self.carousel reloadData];
    [self.dataTableView reloadData];
    [_spacePageControl setNumberOfPages:[self.dataList count]];
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

    [self showLoginView];
}


-(void)pushToMyselfViewController:(id)sender{
    
    [self rightButtonClickHandler:sender];

}

-(void)pushToMyselfViewControllerFrom:(UIViewController *)viewController{

    [self rightButtonClickHandler:viewController];


}

#pragma mark-- addButtonScrollView Method

-(void)showLoginView{

    UIStoryboard *currentInUseStoryBoard;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIStoryboard * iPhoneStroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        currentInUseStoryBoard = iPhoneStroyBoard;
        
    }else{
        
        UIStoryboard * iPadStroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        currentInUseStoryBoard = iPadStroyBoard;
    }
    
    if (![[UserService defaultService] user]){
        
        self.loginViewController = (LoginViewController *)[currentInUseStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        UINavigationController *nv = [[[UINavigationController alloc]initWithRootViewController:_loginViewController] autorelease];
        self.loginViewController.delegate = self;
        [self.navigationController presentModalViewController:nv animated:YES];
    }
}


-(void)initTableHeaderView{
    
    UIView *headerView =[[UIView alloc]init];
    [headerView setFrame: CGRectMake(0, 0, 320, 200)];
    self.myHeaderView = headerView;
    [headerView release];
    [self.dataTableView setTableHeaderView:_myHeaderView];
}


#pragma mark-- addButtonScrollView Method
-(void)addButtonScrollView{
    ////Configure The ButtonScrollView
    
    NSArray *buttonTitleArray =[NSArray arrayWithObjects:@"最新",@"锻炼方法",@"基础知识",@"锻炼视频", nil];
    

    self.segmentedController=[[SDSegmentedControl alloc]initWithItems:buttonTitleArray];
    [_segmentedController setFrame:CGRectMake(0, 0, 320, 40)];
    [_segmentedController setSelectedSegmentIndex:0];    
    [_segmentedController addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventValueChanged];
    [_myHeaderView addSubview:_segmentedController];
    
    
    
    
   
    
}

#pragma mark-- addCarouselSliders Method
-(void)addCarouselSliders{
    //configure carousel
    self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 50, 320, 140)];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    _carousel.type = iCarouselTypeLinear;
    [_carousel setScrollEnabled:YES];
    [_carousel setScrollSpeed:1];
    [_myHeaderView addSubview:self.carousel];
}

#pragma mark-- MoreButon Method
-(void)addSpacePageControl{
    ////The page controll
    self.spacePageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(200, 185, 120, 20)];
    [_spacePageControl setBackgroundColor:[UIColor clearColor]];
    _spacePageControl.numberOfPages = [self.dataList count];
    [_spacePageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"currentPageDot.png"]];
    [_spacePageControl setPageIndicatorImage:[UIImage imageNamed:@"pageDot.png"]];
    [_spacePageControl addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
    [_myHeaderView addSubview:_spacePageControl];
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
    NSString *aucode= @"aijianmei";
    NSString *auact = @"au_getinformationlist";
    NSString *listtype = @"2";
    NSString *category = @"train";
    NSString *type = @"hot";
    int offset = EACH_FETCH_SIZE;
    NSString *cateid = @"0";
    NSString *uid = @"265";
    
    if (self.segmentedController.selectedSegmentIndex ==0) {
        
        category = @"train";
        type = @"new";
        cateid = @"0";
        uid = @"265";
        _start=0;
        
    }
    if (self.segmentedController.selectedSegmentIndex ==1) {
        
        category = @"train";
        type = @"new";
        cateid = @"1";
        uid = @"265";
        _start=0;
        
    }
    if (self.segmentedController.selectedSegmentIndex ==2) {
        
        category = @"train";
        type = @"new";
        cateid = @"2";
        uid = @"265";
        _start=0;
    }
    if (self.segmentedController.selectedSegmentIndex ==3) {
        
        category = @"train";
        type = @"new";
        cateid = @"3";
        uid = @"265";
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
                                                 delegate:self];
    
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
- (void) reloadTableViewDataSource
{
    [self buttonClicked:self.segmentedController];
}

#pragma mark - Load More
- (void) loadMoreTableViewDataSource
{
    NSString *aucode= @"aijianmei";
    NSString *auact = @"au_getinformationlist";
    NSString *listtype = @"2";
    NSString *category = @"train";
    NSString *type = @"hot";
    int offset = EACH_FETCH_SIZE;
    NSString *cateid = @"0";
    NSString *uid = @"265";
    
    if (self.segmentedController.selectedSegmentIndex ==0) {
        
        category = @"train";
        type = @"new";
        cateid = @"0";
        uid = @"265";
    }
    if (self.segmentedController.selectedSegmentIndex ==1) {
        
        category = @"train";
        type = @"new";
        cateid = @"1";
        uid = @"265";
    }
    if (self.segmentedController.selectedSegmentIndex ==2) {
        
        category = @"train";
        type = @"new";
        cateid = @"2";
        uid = @"265";
    }
    if (self.segmentedController.selectedSegmentIndex ==3) {
        
        category = @"train";
        type = @"new";
        cateid = @"3";
        uid = @"265";
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
                                                 delegate:self];
    
    
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
    
    [self buttonClicked:sender];
    
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
    ArticleCell *cell = (ArticleCell*)[self.dataTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell  = [[[ArticleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    Article *article  = [dataList objectAtIndex:indexPath.row];
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
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    WorkoutDetailViewController *controller  = [storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailSegue"];
    
    controller.article = [self.dataList objectAtIndex:indexPath.row];
    self.navigationController.navigationBarHidden =YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //    return NUMBER_OF_ITEMS;

    return [self.dataList count];
    
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
        
        
        label = [[[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.origin.y + 130, view.frame.size.width, view.frame.size.height - 130)] autorelease];
        label.textAlignment = UITextAlignmentCenter;
		label.font = [label.font fontWithSize:16];
        [label setTextColor:[UIColor whiteColor]];
        label.backgroundColor = [UIColor colorWithPatternImage:[ImageManager GobalScrollerTitleBG_Image]];
        
        [imageView  addSubview:label];
        
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
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
//    
//    WorkoutDetailViewController *controller  = [storyboard instantiateViewControllerWithIdentifier:@"ArticleDetailSegue"];
//    
//    controller.article = [self.dataList objectAtIndex:index];
//    self.navigationController.navigationBarHidden =YES;
//    [self.navigationController pushViewController:controller animated:YES];
    
    
}

-(void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel{
    
    PPDebug(@"%d",[carousel currentItemIndex]);
    
    [self.spacePageControl setCurrentPage:[carousel currentItemIndex]];
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
	[self dataSourceDidFinishLoadingNewData];
    [self dataSourceDidFinishLoadingMoreData];
    
    if (_start == 0) {
        self.dataList = objects;
    } else {
        NSMutableArray *newDataList = [NSMutableArray arrayWithArray:self.dataList];
        [newDataList addObjectsFromArray:objects];
        self.dataList = newDataList;
    }
    _start += [objects count];
    
    //更新用户界面；
    [self updateUserInterface];
    
}

@end
