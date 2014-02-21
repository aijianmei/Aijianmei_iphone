
//
//  WorkoutPlanViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 6/13/13.
//
//

#import "WorkoutPlanViewController.h"
#import "IIViewDeckController.h"
#import "ImageManager.h"
#import "AppDelegate.h"
#import "PublicMyselfViewController.h"
#import "Myself_SettingsViewController.h"
#import "SMPageControl.h"
#import "SDSegmentedControl.h"
#import "UIImageView+WebCache.h"


///// the setings of the iCarousel
#define NUMBER_OF_ITEMS 4
#define NUMBER_OF_VISIBLE_ITEMS 18
#define ITEM_SPACING 220
#define ITEM_SPACING_IPAD 768.0f



@interface WorkoutPlanViewController ()

@end

@implementation WorkoutPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
    }
    return self;
}


- (void)initUI
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
    
    
    User *user = [[UserService defaultService] user];
    
    if (user.uid) {
        
        
        //    PublicMyselfViewController *publicStatusViewController = [[AppDelegate getAppDelegate] initPublicStatusViewController];
        //    [self.navigationController pushViewController:publicStatusViewController animated:YES];
        
        Myself_SettingsViewController *vc =[[Myself_SettingsViewController alloc]initWithNibName:@"Myself_SettingsViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
        
    }else{
        
        [[AppDelegate  getAppDelegate] showLoginView];
    }
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


-(void)initMoreUI{
    
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

#pragma mark-- addButtonScrollView Method
-(void)initTableHeaderView{
    
    UIView *headerView =[[UIView alloc]init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 200+ 200)];
    }else{
        [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 360.0f)];
    }
    
    
    
    self.myHeaderView = headerView;
    [headerView release];
    [self.dataTableView setTableHeaderView:_myHeaderView];
}


#pragma mark-- addButtonScrollView Method
-(void)addButtonScrollView{
    ////Configure The ButtonScrollView
    
    NSArray *buttonTitleArray =[NSArray arrayWithObjects:
                                @"日常锻炼",
                                @"增肌增重",
                                @"瘦身减肥",
                                @"每日瑜伽",
                                nil];
    
    
    
    self.segmentedController=[[SDSegmentedControl alloc]initWithItems:buttonTitleArray];
    [self.segmentedController setFrame:CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 40)];
    [self.segmentedController setSelectedSegmentIndex:0];
    
    [self.segmentedController addTarget:self
                                 action:@selector(buttonClicked:)
                       forControlEvents:UIControlEventValueChanged];
    [_myHeaderView addSubview:_segmentedController];
}

#pragma mark--
#pragma mark-- addCarouselSliders Method
-(void)scrolliCarouselSliderAutomacially {
//    int i =1;
//    iid = iid + i;
//    [self.carousel scrollToItemAtIndex:iid duration:1];
//    [self.carousel scrollToItemAtIndex:iid animated:YES];
//    if ([self.carousel currentItemIndex]==3) {
//        [self.carousel scrollToItemAtIndex:0 animated:YES];
//        iid =0;
//    }
}

-(void)addCarouselSliders{
    //configure carousel
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone){
        self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0,40,UIScreen.mainScreen.bounds.size.width ,160 + 200)];
        
    }
    else{
        self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0,40,UIScreen.mainScreen.bounds.size.width,320)];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:4
                                     target:self
                                   selector:@selector(scrolliCarouselSliderAutomacially)
                                   userInfo:nil
                                    repeats:YES];
    
    
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
//    [self.carousel setStopAtItemBoundary:YES];
    self.carousel.type = iCarouselTypeLinear;
    [self.carousel setScrollEnabled:YES];
    
    //边界的bounce
    [self.carousel setBounces:NO];
    
    
    
    //可以调整slider 的滑动速度;
    [self.carousel setScrollSpeed:0.75f];
    
    [_myHeaderView addSubview:self.carousel];
}

#pragma mark--
#pragma mark-- MoreButon Method
-(void)addSpacePageControl{
    ////The page controll
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone){
        self.spacePageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(0, 196 + 200, 320, 20)];
        
    }
    else{
        self.spacePageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(230,345, 320, 20)];
    }
    
    
    
    [self.spacePageControl setBackgroundColor:[UIColor clearColor]];
    self.spacePageControl.numberOfPages = 4;
    [self.spacePageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"currentPageDot.png"]];
    [self.spacePageControl setPageIndicatorImage:[UIImage imageNamed:@"pageDot.png"]];
    [self.spacePageControl addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
    [_myHeaderView addSubview:self.spacePageControl];
    
}



#pragma mark-- ButtonClicked Method
-(void)buttonClicked:(SDSegmentedControl *)sender

{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void)
                   {
                       
                   });
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UIView *)carousel:(iCarousel *)carousel
  viewForItemAtIndex:(NSUInteger)index
         reusingView:(UIView *)view
{
	//create new view if no view is available for recycling
    UILabel *label = nil;
    
    NSArray *demoArray  = [NSArray arrayWithObjects:
                           @"http://192.168.1.106/~tomcallon/planImage1.jpg",
                           @"http://192.168.1.106/~tomcallon/planImage2.jpg",
                           @"http://192.168.1.106/~tomcallon/planImage3.jpg",
                           @"http://192.168.1.106/~tomcallon/planImage4.jpg", nil];
    
    
	if (view == nil)
	{
        ///add images
        UIImageView *imageView =[[UIImageView alloc]init];
        //set up content
        if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone){
            view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 220.0f, 160.0f+ 200)] autorelease];
//            [view setBackgroundColor:[UIColor redColor]];
            [imageView setFrame:CGRectMake(0, 0, 190.0f, 160.0f + 200)];
            
        }else{
            view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 768.0f, 320.0f)] autorelease];
            [imageView setFrame:CGRectMake(0, 0, 768.0f, 320.0f)];
            
        }
                
         [imageView setImageWithURL:[NSURL URLWithString:[demoArray objectAtIndex:index]] placeholderImage:[ImageManager sliderPlacHolderImage] success:^(UIImage *image, BOOL cached) {
             //TODO
         } failure:^(NSError *error) {
             //TODO
         }];
        
        
        [view addSubview:imageView];
        [imageView release];
        
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
