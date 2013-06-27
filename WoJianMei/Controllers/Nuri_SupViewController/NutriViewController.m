//
//  HealthFoodViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NutriViewController.h"
#import "NutritionDetailCell.h"
#import "NutritionInfo.h"
#import "Article.h"
#import "ArticleCell.h"
#import "iCarousel.h"
#import "ArticleService.h"
#import "IIViewDeckController.h"
#import "WorkoutDetailViewController.h"

#define NUMBER_OF_ITEMS 13
#define NUMBER_OF_VISIBLE_ITEMS 18
#define ITEM_SPACING 220
#define SCROLL_VIEW_TAG 20120913

@interface NutriViewController ()

@end

@implementation NutriViewController
@synthesize buttonScrollView =_buttonScrollView;

-(void)dealloc
{
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
    [_carousel release];
    [_myHeaderView release];
    [_buttonScrollView release];
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

- (void)viewDidLoad
{
    [self initUI];
    [self initMoreUI];
    self.supportRefreshHeader = YES;
    
    //获取网络数据
    ////开始下载文章
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"最新" forState:UIControlStateNormal];
    [self buttonClicked:button];
    
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
  
    [super viewWillAppear:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.buttonScrollView = nil;
    
}


#pragma mark -
#pragma mark UITableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NutritionCell";
    NutritionDetailCell *cell = (NutritionDetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
 
    Article *nutrition = [dataList objectAtIndex:indexPath.row];
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"table_header_bg@2x.png"]]];
    
    if (nutrition) {
        [cell setCellInfo:nutrition];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  [NutritionDetailCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   //TODO
    
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
	label.text = [NSString stringWithFormat:@"%@", @"adfsafasfasdfasdf"];
    
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
    
}


#pragma mark -
#pragma mark  ButtonClicked  Methods

-(void)buttonClicked:(id)sender{
    
    ////开始下载文章
    NSString *aucode= @"aijianmei";
    NSString *auact = @"au_getinformationlist";
    NSString *listtype = @"2";
    NSString *category = @"nutri";
    NSString *type = @"new";
    NSString *page = @"1";
    NSString *pnums = @"10";
    NSString *cateid = @"0";
    NSString *uid = @"265";

    if ([[sender currentTitle] isEqualToString:@"最新"]) {
        
        category = @"nutri";
        type = @"new";
        page = @"1";
        pnums = @"10";
        cateid = @"0";
        uid = @"265";
        
    }
    if ([[sender currentTitle] isEqualToString:@"增肌"])
    {
        category = @"nutri";
        type = @"new";
        page = @"1";
        pnums = @"10";
        cateid = @"1";
        uid = @"265";
        
    }
    if ([[sender currentTitle] isEqualToString:@"减肥"])
    {
        
        category = @"nutri";
        type = @"new";
        page = @"1";
        pnums = @"10";
        cateid = @"2";
        uid = @"265";
    }
    if ([[sender currentTitle] isEqualToString:@"一般营养知识"])
    {
        
        category = @"nutri";
        type = @"new";
        page = @"1";
        pnums = @"10";
        cateid = @"3";
        uid = @"265";
        
    }

//    [[ArticleService sharedService] findArticleWithAucode:aucode
//                                                    auact:auact
//                                                 listtype:listtype
//                                                 category:category
//                                                     type:type
//                                                     page:page
//                                                    pnums:pnums
//                                                   cateid:cateid
//                                                      uid:uid
//                                                 delegate:self];
//    
    
    
}

#pragma mark -
#pragma mark  initUI  Methods

-(void)initUI{
    
    NSMutableArray *buttonArrays  =[[NSMutableArray alloc]init];
    NSArray *buttonTitleArray =[NSArray arrayWithObjects:@"最新",@"增肌",@"减肥",@"一般饮食知识",nil];
    
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
    
    float buttonHeight = 30;
    float buttonWidth  = 70;
    
    [[self.view viewWithTag:SCROLL_VIEW_TAG] removeFromSuperview];
    self.buttonScrollView.tag = SCROLL_VIEW_TAG;
    [self.buttonScrollView setFrame:CGRectMake(0,150, 1220, 30)];
    [self.buttonScrollView setShowsHorizontalScrollIndicator:NO];
    
    [self.buttonScrollView setContentSize:CGSizeMake([buttonArrays count] * buttonWidth * 2.6, buttonHeight)];
    [buttonArrays release];
    
    
    //configure carousel
    UIView *headerView =[[UIView alloc]init];
    [headerView setFrame: CGRectMake(0, 0, 320, 200)];
    self.myHeaderView = headerView;
    [headerView release];
    
    [self.myHeaderView addSubview:self.buttonScrollView];

    
    
    self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, 320, 140)];
    
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    _carousel.type = iCarouselTypeCylinder;
    
    [self.myHeaderView addSubview:_carousel];
    [self.dataTableView setTableHeaderView:self.myHeaderView];
    
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    [self showActivity];
    
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"Load objects count: %d", [objects count]);
    [self hideActivity];
    self.dataList = objects;
    //在这里就可以在controller刷新数据
    [self.dataTableView reloadData];
}

@end
