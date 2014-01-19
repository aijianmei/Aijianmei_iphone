//
//  AJM_CommonViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 6/13/13.
//
//

#import "AJM_CommonViewController.h"
#import "IIViewDeckController.h"
#import "AppDelegate.h"
#import "iCarousel.h"
#import "SDSegmentedControl.h"
#import "SMPageControl.h"
#import "ImageManager.h"
#import "UserManager.h"
#import "Myself_SettingsViewController.h"








@interface AJM_CommonViewController ()

@end

@implementation AJM_CommonViewController
@synthesize myHeaderView        =_myHeaderView;
@synthesize carousel            =_carousel;
@synthesize spacePageControl    =_spacePageControl;
@synthesize segmentedController =_segmentedController;
@synthesize buttonScrollView    =_buttonScrollView;
@synthesize currentButton       =_currentButton;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    [self initUI];
    [self initMoreUI];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initUI
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
    [rightBtn setImage:[ImageManager GobalNavigationAvatarImage] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0.0, 0.0, 49.0, 29.0);
    [rightBtn addTarget:self action:@selector(rightButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];
    
    
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPad || [[[UIDevice currentDevice]systemVersion ] floatValue] >= 7.0)
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





-(void)initMoreUI{
    [self initTableHeaderView];
    [self addCarouselSliders];
    [self addSpacePageControl];
    [self addButtonScrollView];
    
    [[AppDelegate getAppDelegate] showLoginView];

}




#pragma mark-- addButtonScrollView Method
-(void)initTableHeaderView{
    
    UIView *headerView =[[UIView alloc]init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 200)];
    }else{
        [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 360.0f)];
    }
    
    
    
    self.myHeaderView = headerView;
    [headerView release];
    [self.dataTableView setTableHeaderView:_myHeaderView];
}

#pragma mark-- addCarouselSliders Method
-(void)scrolliCarouselSliderAutomacially {
    int i =1;
    iCarouselIndex = iCarouselIndex + i;
    [self.carousel scrollToItemAtIndex:iCarouselIndex duration:1];
    [self.carousel scrollToItemAtIndex:iCarouselIndex animated:YES];
    if ([self.carousel currentItemIndex]==3) {
        [self.carousel scrollToItemAtIndex:0 animated:YES];
        iCarouselIndex =0;
    }
}
-(void)addCarouselSliders{
    //configure carousel
    
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone){
        self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0,40,UIScreen.mainScreen.bounds.size.width,160)];
        
    }
    else{
        self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0,40,UIScreen.mainScreen.bounds.size.width,320)];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scrolliCarouselSliderAutomacially) userInfo:nil repeats:YES];
    
    
    
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    _carousel.type = iCarouselTypeLinear;
    [_carousel setScrollEnabled:YES];
    //可以调整slider 的滑动速度;
    [_carousel setScrollSpeed:0.25f];
    
    [_myHeaderView addSubview:self.carousel];
}

#pragma mark-- addButtonScrollView Method
-(void)addButtonScrollView{
    ////Configure The ButtonScrollView
    
    NSArray *buttonTitleArray =[NSArray arrayWithObjects:@"最新文章",@"最热文章",@"最新视频",@"最热视频", nil];
    
    
    self.segmentedController=[[SDSegmentedControl alloc]initWithItems:buttonTitleArray];
    [_segmentedController setFrame:CGRectMake(0, 0,UIScreen.mainScreen.bounds.size.width, 40)];
    [_segmentedController setSelectedSegmentIndex:0];
    [_segmentedController addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventValueChanged];
    [_myHeaderView addSubview:self.segmentedController];
}

#pragma mark--
#pragma mark-- MoreButon Method
-(void)addSpacePageControl{
    ////The page controll
    
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone){
        self.spacePageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(0, 196, 320, 20)];
        
    }
    else{
        self.spacePageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(230,345, 320, 20)];
    }
    
    
    
    [_spacePageControl setBackgroundColor:[UIColor clearColor]];
    self.spacePageControl.numberOfPages = 4;
    [_spacePageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"currentPageDot.png"]];
    [_spacePageControl setPageIndicatorImage:[UIImage imageNamed:@"pageDot.png"]];
    [_spacePageControl addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
    [_myHeaderView addSubview:self.spacePageControl];
}

#pragma mark--
#pragma mark-- PageControl ClickMethod
- (void)pageControl:(id)sender
{
	NSLog(@"Current Page (UIPageControl) : %i", _spacePageControl.currentPage);
}

- (void)spacePageControl:(SMPageControl *)sender
{
	NSLog(@"Current Page (SMPageControl): %i", sender.currentPage);
}



#pragma mark--
#pragma mark-- SDSegmentedControl Click Method
-(void)buttonClicked:(SDSegmentedControl *)sender{


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
    
    
    UILabel *label = nil;
    
	if (view == nil)
	{
        ///add images
        UIImageView *imageView =[[UIImageView alloc]init];
        
        
        //set up content
        if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone){
            view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 160.0f)] autorelease];
            [imageView setFrame:CGRectMake(0, 0, 320, 160.0f)];
            
        }else{
            view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 768.0f, 320.0f)] autorelease];
            [imageView setFrame:CGRectMake(0, 0, 768.0f, 320.0f)];
            
        }

        [view addSubview:imageView];
        
	}
	else
	{
		label = [[view subviews] lastObject];
	}
	
    //set label
	label.text = [NSString stringWithFormat:@"%d",index];
    
	return view;
    
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone){
        return ITEM_SPACING;
    }else  {
        return ITEM_SPACING_IPAD;
    }
    return ITEM_SPACING_IPAD;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    PPDebug(@"I did selected the picture of %d",index);
}

-(void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel{
    
    PPDebug(@"%d",[carousel currentItemIndex]);
    
    [self.spacePageControl setCurrentPage:[carousel currentItemIndex]];
}


@end
