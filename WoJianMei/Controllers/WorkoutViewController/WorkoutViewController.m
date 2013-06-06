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
///// the setings of the iCarousel
#define NUMBER_OF_ITEMS 13
#define NUMBER_OF_VISIBLE_ITEMS 8
#define ITEM_SPACING 220


#define SCROLL_VIEW_TAG 20120913




@interface WorkoutViewController ()

@end

@implementation WorkoutViewController
@synthesize myHeaderView =_myHeaderView;
@synthesize  carousel =_carousel;
@synthesize spacePageControl =_spacePageControl;
@synthesize buttonScrollView =_buttonScrollView;




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)dealloc{
    
    
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
    [_carousel release];
    
    [_spacePageControl release];
    [_buttonScrollView release];
    [_myHeaderView release];
    [super dealloc];
    
}



-(void)iamTomsGirlfriend{
    
    NSLog(@"I am Tom's girlfriend");
    
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
    NSArray *buttonTitleArray =[NSArray arrayWithObjects:@"最近更新",@"最热门",@"健身",@"瑜伽",@"增肌",@"减肥",@"瘦身",@"健美操",@"其它", nil];
    
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
    [_buttonScrollView setFrame:CGRectMake(0,170, 1220, 30)];
    [_buttonScrollView setShowsHorizontalScrollIndicator:NO];
    
    [_buttonScrollView setContentSize:CGSizeMake([buttonArrays count] * buttonWidth * 2.6, buttonHeight)];


    [self.myHeaderView addSubview:_buttonScrollView];


    //configure carousel
    
    self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, 320, 140)];
    
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    _carousel.type = iCarouselTypeCylinder;
    
    [self.carousel setCenterItemWhenSelected:YES];
    
    [self.myHeaderView addSubview:_carousel];
       
    

    ////The page controll
    self.spacePageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(10, 137, 300, 20)];
    [_spacePageControl setBackgroundColor:[UIColor clearColor]];
    _spacePageControl.numberOfPages = 13;
    [_spacePageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"currentPageDot.png"]];
    [_spacePageControl setPageIndicatorImage:[UIImage imageNamed:@"pageDot"]];
    [_spacePageControl addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
    [self.myHeaderView addSubview:_spacePageControl];
    
    
    
    
    [self.dataTableView setTableHeaderView:self.myHeaderView];

    
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    


}

#pragma mark-- ButtonClicked Method


-(void)buttonClicked:(UIButton *)sender {

    
    PPDebug(@"I click button :%d",sender.tag);

}


#pragma mark-- PageControl

- (void)pageControl:(id)sender
{
	NSLog(@"Current Page (UIPageControl) : %i", _spacePageControl.currentPage);
}

- (void)spacePageControl:(SMPageControl *)sender
{
	NSLog(@"Current Page (SMPageControl): %i", sender.currentPage);
}



-(void)initWorkOutDatas{
    
    ArticleInfo *article1 = [[ArticleInfo alloc]initWithId:@"0"
                                                     title:@"whatsup"
                                           description:@"youyoyoyasdfasdfasdfasdfsadfasdfasdfasdfasdf"
                                                     image:[UIImage imageNamed:@""]
                                              releasedTime:@"三小时前"
                                                clickTimes:@"12"
                                                   comment:@"1234"
                                                    isRead:NO];
    ArticleInfo *article2 = [[ArticleInfo alloc]initWithId:@"0"
                                                     title:@"whatsup"
                                               description:@"youyoyoyasdfasdfasdfasdfsadfasdfasdfasdfasdf"
                                                     image:[UIImage imageNamed:@""]
                                              releasedTime:@"三小时前"
                                                clickTimes:@"12"
                                                   comment:@"1234"
                                                    isRead:NO];
    ArticleInfo *article3 = [[ArticleInfo alloc]initWithId:@"0"
                                                     title:@"whatsup"
                                               description:@"youyoyoyasdfasdfasdfasdfsadfasdfasdfasdfasdf"
                                                     image:[UIImage imageNamed:@""]
                                              releasedTime:@"三小时前"
                                                clickTimes:@"12"
                                                   comment:@"1234"
                                                    isRead:NO];
    
    
    [[ArticleManager defaultManager] addArticle:article1];
    [[ArticleManager defaultManager] addArticle:article2];
    [[ArticleManager defaultManager] addArticle:article3];
    
    
    [article1 release];
    [article2 release];
    [article3 release];

    
    
    
    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    

    [self initUI];
    
    [self initWorkOutDatas];
    
     self.dataList = [[ArticleManager defaultManager] articleList];
    
    
//    [self performSegueWithIdentifier:@"LoginSegue" sender:self];

    
    
    
    
}


-(void)viewDidUnload{

    [super viewDidUnload];
    self.carousel = nil;

}

#pragma mark ----------------------------------------————————————————
#pragma mark  tableviewDelegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    
    return [dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    NSString *CellIdentifier = [ArticleCell getCellIdentifier];
    ArticleCell *cell = (ArticleCell*)[self.dataTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil) {
        cell  = [[[ArticleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    //    cell.indexPath = indexPath;
    ArticleInfo *article  = [dataList objectAtIndex:indexPath.row];
    if (article) {
        [cell setCellInfo:article];
    }
    
//
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isPad) {
        return 210.f;
    }
    return  [ArticleCell getCellHeight];
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
	UILabel *backgroudLabel = nil;
	
	//create new view if no view is available for recycling
	if (view == nil)
	{
        //set up reflection view
		view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 130.0f)] autorelease];
        
        //set up content
		backgroudLabel = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
		backgroudLabel.backgroundColor = [UIColor lightGrayColor];
		backgroudLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        backgroudLabel.layer.borderWidth = 4.0f;
        backgroudLabel.layer.cornerRadius = 8.0f;
        backgroudLabel.textAlignment = UITextAlignmentCenter;
		backgroudLabel.font = [backgroudLabel.font fontWithSize:50];
        

        [view addSubview:backgroudLabel];

    ///add images
    NSString *imageName = [NSString stringWithFormat:@"%d",index +1];
    UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        
        
    [backgroudLabel addSubview: imageView];
    [imageView release];
     
        
    ///add subtitles to each image
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,100, 200, 30)];
    NSString *string  =[NSString stringWithFormat:@"%d",index];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    label.backgroundColor = [UIColor blueColor];
    [imageView addSubview:label];
    [label release];
        
	}
	else
	{
		backgroudLabel = [[view subviews] lastObject];
	}
	
    //set label
	backgroudLabel.text = [NSString stringWithFormat:@"%@", @"adfsafasfasdfasdf"];
    
    //update reflection
    //this step is expensive, so if you don't need
    //unique reflections for each item, don't do this
    //and you'll get much smoother peformance
    
    /// When it is the reflecttion view we need to implement this method.
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
    
    [self.spacePageControl setCurrentPage:[carousel currentItemIndex]];
    
}





@end
