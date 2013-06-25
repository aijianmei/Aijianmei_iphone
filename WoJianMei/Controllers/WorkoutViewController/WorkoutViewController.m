//
//  WorkoutViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/29/12.
//
//

#import "WorkoutViewController.h"
#import "ArticleCell.h"
#import "ArticleInfo.h"
#import "ArticleManager.h"
#import "WorkOut.h"
#import "ReflectionView.h"
#import "iCarousel.h"
#import "ArticleService.h"
#import "Article.h"
#import "WorkoutDetailViewController.h"
#import "IIViewDeckController.h"
#import "AppDelegate.h"
#import "FilterViewController.h"

///// the setings of the iCarousel
#define NUMBER_OF_ITEMS 13
#define NUMBER_OF_VISIBLE_ITEMS 18
#define ITEM_SPACING 220

#define SCROLL_VIEW_TAG 20120913
#define More_BUTTON_TAG 20130607


typedef enum CONTENT_TYPE {
    NEW_TYPE= 0,
    WORKOUT_TYPE =1,
    BASIC_TYPE =2,
    VIDEO_TYPE =3
    
}CONTENT_TYPE;



@interface WorkoutViewController ()

@end

@implementation WorkoutViewController
@synthesize myHeaderView =_myHeaderView;
@synthesize  carousel =_carousel;
//@synthesize spacePageControl =_spacePageControl;
@synthesize buttonScrollView =_buttonScrollView;
@synthesize currentButton = _currentButton;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
    [_carousel release];
//    [_spacePageControl release];
    [_buttonScrollView release];
    [_myHeaderView release];
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
//    [self.viewDeckController toggleRightViewAnimated:YES];
    
    
    
 
}


#pragma mark -
#pragma mark  initUI  Methods

//// init the userInterface 
-(void)initUI{
    
    UIView *headerView =[[UIView alloc]init];
    [headerView setFrame: CGRectMake(0, 0, 320, 200)];
    self.myHeaderView = headerView;
    [headerView release];

    
   ////Configure The ButtonScrollView
    NSMutableArray *buttonArrays  =[[NSMutableArray alloc]init];
    NSArray *buttonTitleArray =[NSArray arrayWithObjects:@"最新",@"锻炼方法",@"基础知识",@"锻炼视频", nil];
    
    for (NSString *buttonTitle in buttonTitleArray) {
        
        UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(30, 0, 70, 30)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [button setBackgroundImage:[UIImage imageNamed:@"button_Image.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"button_Image.png"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [buttonArrays addObject:button];
        
        [button release];
        
    }
    
    UIScrollView *scrollView = [PPViewController createButtonScrollViewByButtonArray:buttonArrays buttonsPerLine:[buttonArrays count] buttonSeparatorY:-1];
    self.buttonScrollView =scrollView;
    [self.buttonScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"button_BG.png"]]];
    [scrollView release];
    [buttonArrays release];
    
    float buttonHeight = 30;
    float buttonWidth  = 70;
    
    [[self.view viewWithTag:SCROLL_VIEW_TAG] removeFromSuperview];
    self.buttonScrollView.tag = SCROLL_VIEW_TAG;
    [_buttonScrollView setFrame:CGRectMake(0,0, 260, 30)];
    [_buttonScrollView setShowsHorizontalScrollIndicator:NO];
    
    [_buttonScrollView setContentSize:CGSizeMake(([[_buttonScrollView subviews] count]) * buttonWidth * 2.6, buttonHeight)];

    [self.myHeaderView addSubview:_buttonScrollView];
    
    
    
    UIButton *moreButotn = [[UIButton alloc]initWithFrame:CGRectMake(270, 0, 40, 30)];
    [moreButotn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [moreButotn setBackgroundImage:[UIImage imageNamed:@"button_Image.png"] forState:UIControlStateNormal];
    [moreButotn setBackgroundImage:[UIImage imageNamed:@"button_Image.png"] forState:UIControlStateSelected];
    [moreButotn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
 
    
    [moreButotn setTag:More_BUTTON_TAG];
    
    [_myHeaderView addSubview:moreButotn];
    [moreButotn release];
    

    //configure carousel
    
    self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 30, 320, 140)];
    
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    _carousel.type = iCarouselTranformOptionTilt;
    
    [self.carousel setCenterItemWhenSelected:YES];
    
    [self.myHeaderView addSubview:_carousel];
    
    
    ////The page controll
//    self.spacePageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(10, 137, 300, 20)];
//    [_spacePageControl setBackgroundColor:[UIColor clearColor]];
//    _spacePageControl.numberOfPages = 13;
//    [_spacePageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"currentPageDot.png"]];
//    [_spacePageControl setPageIndicatorImage:[UIImage imageNamed:@"pageDot"]];
//    [_spacePageControl addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
//    [self.myHeaderView addSubview:_spacePageControl];
    
    
    
    
    [self.dataTableView setTableHeaderView:self.myHeaderView];    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
}


-(void)filterTheConentsByButton{

}

#pragma mark-- ButtonClicked Method
-(void)buttonClicked:(UIButton *)sender

{
    
    
    self.currentButton = sender;
    
    if ([sender tag] == More_BUTTON_TAG) {
        
        FilterViewController *vc = [[FilterViewController alloc]initWithNibName:@"FilterViewController" bundle:nil];
        [self.navigationController  presentModalViewController:vc animated:YES];
        [vc release];
        
        return;
    }
    
    //开始下载文章
    NSString *aucode= @"aijianmei";
    NSString *auact = @"au_getinformationlist";
    NSString *listtype = @"2";
    NSString *category = @"train";
    NSString *type = @"hot";
    NSString *page = @"1";
    NSString *pnums = @"10";
    NSString *cateid = @"0";
    NSString *uid = @"265";
    
   
    
    if ([[sender currentTitle] isEqualToString:@"最新"]) {
        
        category = @"train";
        type = @"new";
        page = @"1";
        pnums = @"19";
        cateid = @"0";
        uid = @"265";
    
    }
    if ([[sender currentTitle] isEqualToString:@"锻炼方法"]) {
        
        category = @"train";
        type = @"new";
        page = @"1";
        pnums = @"19";
        cateid = @"1";
        uid = @"265";

          }
    if ([[sender currentTitle] isEqualToString:@"基础知识"]) {
        
        category = @"train";
        type = @"new";
        page = @"1";
        pnums = @"19";
        cateid = @"2";
        uid = @"265";
    }
    if ([[sender currentTitle] isEqualToString:@"锻炼视频"]) {
        
        category = @"train";
        type = @"new";
        page = @"1";
        pnums = @"19";
        cateid = @"3";
        uid = @"265";
    
    }
    
    
    [[ArticleService sharedService] findArticleWithAucode:aucode
                                                    auact:auact
                                                 listtype:listtype
                                                 category:category
                                                     type:type
                                                     page:page
                                                    pnums:pnums
                                                   cateid:cateid
                                                      uid:uid
                                                 delegate:self];
    
    
    
}

//#pragma mark--
//#pragma mark-- PageControl
//
//- (void)pageControl:(id)sender
//{
//	NSLog(@"Current Page (UIPageControl) : %i", _spacePageControl.currentPage);
//}
//
//- (void)spacePageControl:(SMPageControl *)sender
//{
//	NSLog(@"Current Page (SMPageControl): %i", sender.currentPage);
//}
//

#pragma Pull Refresh Delegate
- (void) reloadTableViewDataSource
{
    [self buttonClicked:_currentButton];
}

- (void)viewDidLoad
{    
    [self initMoreUI];
    [self initUI];
    self.supportRefreshHeader = YES;
    self.supportRefreshFooter = YES;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"最新" forState:UIControlStateNormal];
    [self buttonClicked:button];
    
    [super viewDidLoad];
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
    [self.navigationController pushViewController:controller animated:YES];

    
    
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return NUMBER_OF_ITEMS;
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
    
    UILabel *label = nil;
	//create new view if no view is available for recycling
	if (view == nil)
	{
        //set up reflection view
		view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 130.0f)] autorelease];
        
        //set up content
		label = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
		label.backgroundColor = [UIColor lightGrayColor];
		label.layer.borderColor = [UIColor whiteColor].CGColor;
        label.layer.borderWidth = 4.0f;
        label.layer.cornerRadius = 8.0f;
        label.textAlignment = UITextAlignmentCenter;
		label.font = [label.font fontWithSize:50];
        
        
        [view addSubview:label];
        
        ///add images
        NSString *imageName = [NSString stringWithFormat:@"%d",index +1];
        UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        [label addSubview: imageView];
        [imageView release];
        
        
        
	}
	else
	{
		label = [[view subviews] lastObject];
	}
	
    //set label
	label.text = [NSString stringWithFormat:@"%@", @""];
    
    //update reflection
    //this step is expensive, so if you don't need
    //unique reflections for each item, don't do this
    //and you'll get much smoother peformance
    //    [view update];
    
    
	
	return view;

}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    PPDebug(@"I did selected the picture of %d",index);
}

-(void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel{

    PPDebug(@"%d",[carousel currentItemIndex]);
    
//    [self.spacePageControl setCurrentPage:[carousel currentItemIndex]];
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
    
    self.dataList = objects;
    [self hideActivity];
    [self.dataTableView reloadData];
}

@end
