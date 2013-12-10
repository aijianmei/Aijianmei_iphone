//
//  BasicTopicViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/3/13.
//
//

#import "BBSViewController.h"
#import "PostTopicViewController.h"
#import "BBSHomeCell.h"
#import "BBSPostDetailController.h"


///// the setings of the iCarousel
#define NUMBER_OF_ITEMS 4
#define NUMBER_OF_VISIBLE_ITEMS 18
#define ITEM_SPACING 320
#define ITEM_SPACING_IPAD 768.0f


@interface BBSViewController ()

@end

@implementation BBSViewController

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
    
    self.supportRefreshHeader = YES;
    self.supportRefreshFooter = YES;

    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    [self initUI];
}
- (void)initUI
{
    [self initButtons];
    [self initTableHeaderView];
    [self addCarouselSliders];
    
}

-(void)initButtons{
    //rightBtn
    UIButton *rightBtn = [[[UIButton alloc] init] autorelease];
    
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"NavigationButtonBG.png"]
                        forState:UIControlStateNormal];
    
    [rightBtn setImage:[UIImage imageNamed:@"bbs_create_draw_disable.png"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [rightBtn addTarget:self action:@selector(clickPostButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:rightBtn] autorelease];
}

-(void)initTableHeaderView{
    UIView *headerView = [[UIView alloc]init];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
    [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 160.0f)];
    }else{
    [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 360.0f)];
    }
    [self.dataTableView setTableHeaderView:headerView];
    [headerView release];
}

#pragma mark--
#pragma mark-- addCarouselSliders Method
-(void)addCarouselSliders{
    //configure carousel
    
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone){
        self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width,160)];
        
    }
    else{
        self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width,320)];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(scrolliCarouselSliderAutomacially) userInfo:nil repeats:YES];
    
    
    
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    _carousel.type = iCarouselTypeLinear;
    [_carousel setScrollEnabled:YES];
    //可以调整slider 的滑动速度;
    [_carousel setScrollSpeed:0.25f];
    
    [self.dataTableView addSubview:self.carousel];
}


-(void)scrolliCarouselSliderAutomacially {
    int i =1;
    iid = iid + i;
    [self.carousel scrollToItemAtIndex:iid duration:1];
    [self.carousel scrollToItemAtIndex:iid animated:YES];
    if ([self.carousel currentItemIndex]==3) {
        [self.carousel scrollToItemAtIndex:0 animated:YES];
        iid =0;
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
        
        [imageView setImage:[UIImage imageNamed:@"320X480.png"]];
        [view addSubview:imageView];
        [imageView release];
        
	}
	else
	{
		label = [[view subviews] lastObject];
	}
	
    //set label
	label.text = [NSString stringWithFormat:@"%@",@"Testing"];
    
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
}





#pragma mark--
#pragma mark--ClickPostMethod
-(void)clickPostButton:(id)sender{
    
    PostTopicViewController *vc = [[PostTopicViewController alloc]initWithNibName:@"PostTopicViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];

}

#pragma mark --
#pragma mark  tableviewDelegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [BBSHomeCell getCellIdentifier];
	BBSHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [BBSHomeCell createCell:self];
	}
    
	return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PBBBSPost *post = [self.dataList objectAtIndex:indexPath.row];
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

@end
