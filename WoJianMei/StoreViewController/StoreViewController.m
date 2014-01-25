//
//  StoreViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/6/14.
//
//

#import "StoreViewController.h"
#import "IIViewDeckController.h"
#import "BaiduMobStat.h"
#import "ImageManager.h"
#import "UserManager.h"
#import "AppDelegate.h"
#import "Myself_SettingsViewController.h"
#import "StoreService.h"
#import "CuzyAdSDK.h"
#import "ProductCell.h"
#import "ProductItem.h"
#import "SingleItemView.h"
#import "UIImageView+WebCache.h"
#import "TaoBaoDetailViewController.h"
#import "SDSegmentedControl.h"
#import "DeviceDetection.h"

#import "UINavigationController+CustomBackButton.h"


#define AppKey   @"200449"
#define AppSecret @"10f7b750f9c1aff5d772d248ce2de0f6"


#define LEFT_ITEM_TAG 1003
#define RIGHT_ITEM_TAG 1004

static int currentPageIndex = 0;


@implementation StoreViewController
@synthesize loadingmore=_loadingmore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateInformation" object:nil];
    [super dealloc];
}


#pragma mark -
#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"SotreView"];
}
-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"SotreView"];
}


- (void)viewDidLoad
{
    
    self.supportRefreshHeader = YES;
    self.supportRefreshFooter = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    //Set Delegate
    [[CuzyAdSDK sharedAdSDK] setDelegate:self];
    //release server key & secret:
    [[CuzyAdSDK sharedAdSDK] registerAppWithAppKey:AppKey
                                      andAppSecret:AppSecret];
    
    
    
    
    //默认点击第一个
     currentPageIndex = 0;
//    [self.segmentedController setSelectedSegmentIndex:0];
//    [self  buttonClicked:_segmentedController];
    self.loadingmore = NO;


    
    ///
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"updateInformation" object:nil];
    
    [self.dataTableView setBackgroundColor:[UIColor clearColor]];
}

-(void)receiveNotification:(NSNotification*)note{
    //return from category , reset page information
    currentPageIndex = 0;
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
    
    ProductItem *product = [self.dataList objectAtIndex:index];
    
    UILabel *label = nil;
    
	if (view == nil)
	{
        ///add images
        UIImageView *imageView =[[UIImageView alloc]init];
        
        //set up content
        if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPhone){
            view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 160.0f)] autorelease];
            [imageView setFrame:CGRectMake(0, 0, 320.0f, 160.0f)];
            
        }else{
            view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 768.0f, 320.0f)] autorelease];
            [imageView setFrame:CGRectMake(0, 0, 768.0f, 320.0f)];
            
        }
        
        
        [imageView setImageWithURL:[NSURL URLWithString:product.itemImageURLString] placeholderImage:[UIImage imageNamed:@"place_holder.png"]];
        [view addSubview:imageView];
        [imageView release];
        
	}
	else
	{
		label = [[view subviews] lastObject];
	}
	
    //set label
//	label.text = [NSString stringWithFormat:@"%@", article.title];
    
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




#pragma mark --
#pragma mark  tableviewDelegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count]/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [ProductCell getCellIdentifier];
	ProductCell *cell = (ProductCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [ProductCell createCell:self];
        
        
        NSArray *array1 = [[NSBundle mainBundle] loadNibNamed:@"SingleItemView"owner:self options:nil];
        SingleItemView *leftView = [array1 objectAtIndex:0];
        
        leftView.center = CGPointMake(80, 85);

        if (ISIPAD) {
        leftView.center = CGPointMake(UIScreen.mainScreen.bounds.size.width/4,125);

        }
        leftView.tag = LEFT_ITEM_TAG;
        leftView.viewController = self;

        
        [cell addSubview:leftView];
        
        
        NSArray *array2 = [[NSBundle mainBundle] loadNibNamed:@"SingleItemView"owner:self options:nil];
        SingleItemView *rightView = [array2 objectAtIndex:0];
        rightView.tag = RIGHT_ITEM_TAG;
        rightView.center = CGPointMake(240, 85);
        if (ISIPAD) {
          rightView.center = CGPointMake(UIScreen.mainScreen.bounds.size.width/2 + UIScreen.mainScreen.bounds.size.width/4 ,125);
            
        }
        rightView.viewController =self;
        
        [cell addSubview:rightView];


		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    
    
    SingleItemView*leftView = (SingleItemView*)[cell viewWithTag:LEFT_ITEM_TAG];
    [self setSingleItemView:leftView withTaobaoItem:[self.dataList objectAtIndex:2*indexPath.row]];
    
    SingleItemView*rightView = (SingleItemView*)[cell viewWithTag:RIGHT_ITEM_TAG];
    [self setSingleItemView:rightView withTaobaoItem:[self.dataList objectAtIndex:2*indexPath.row+1]];
    
    
//    [cell setBackgroundColor:[UIColor clearColor]];

    return cell;
}

-(void)setSingleItemView:(SingleItemView*)view withTaobaoItem:(ProductItem*)product
{
    view.nameLabel.text = product.itemName;
    view.totalSaleCountLable.text = [NSString stringWithFormat:@"购买量 %@",product.tradingVolumeInThirtyDays];
    view.priceLabel.text = [NSString stringWithFormat:@"￥%@",product.promotionPrice];
    view.imageViewContent.layer.cornerRadius = 4.0f;
    view.clickUrlString = product.itemClickURLString;
    [view.imageViewContent setImageWithURL:[NSURL URLWithString:product.itemImageURLString] placeholderImage:nil success:^(UIImage *image, BOOL cached) {
    } failure:^(NSError *error) {
    }];
    
}

#pragma mark - table view delegate
- (ProductItem *)productionForIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *dList = self.dataList;
    if (indexPath.row >= [dList count]) {
        return nil;
    }
    ProductItem *product = [self.dataList objectAtIndex:indexPath.row];
    return product;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [ProductCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)showDetailTaobaoWebView:(NSString*)urlString;
{
    TaoBaoDetailViewController* tbkVC = [[[TaoBaoDetailViewController alloc] initWithNibName:@"TaoBaoDetailViewController" bundle:nil] autorelease];
    tbkVC.urlString = [@"http://" stringByAppendingFormat:@"%@", urlString];
    [self.navigationController pushViewController:tbkVC animated:YES];
    
}










#pragma mark--
#pragma mark-- SDSegmentedControl Click Method
-(void)buttonClicked:(SDSegmentedControl *)sender{
    
    currentPageIndex =0;

    NSString *index =[NSString stringWithFormat:@"%d",currentPageIndex];
    
    if (sender.selectedSegmentIndex ==0) {
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"增肌 蛋白粉"
                                pageIndex:@"0"];
        
        NSLog(@"##########%d",sender.selectedSegmentIndex);
        
    }
    if (sender.selectedSegmentIndex ==1) {
        
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"安全套"
                                pageIndex:index];
        NSLog(@"##########%d",sender.selectedSegmentIndex);

        
    }
    if (sender.selectedSegmentIndex==2) {
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"瑜伽垫"
                                pageIndex:index];
        
        
        NSLog(@"##########%d",sender.selectedSegmentIndex);

    }
    if (sender.selectedSegmentIndex==3) {
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"健身 背心 运动"
                                pageIndex:index];
        NSLog(@"##########%d",sender.selectedSegmentIndex);

    }
    
    
}

#pragma mark --
#pragma mark - Pull - Refresh Delegate
-(void)loadProductsDataWithThemeID:(NSString *)themeID
                         searchKey:(NSString *)searchKey
                        pageIndex :(NSString *)pageIndex


{
    [[StoreService sharedService] findPorductsWithThemeID:themeID
                                                searchKey:searchKey
                                                pageIndex:pageIndex
                                           viewController:self];
}


- (void)reloadTableViewDataSource
{
     self.loadingmore =NO;
     currentPageIndex =0;
    
    NSString *index =[NSString stringWithFormat:@"%d",currentPageIndex];

    if (_segmentedController.selectedSegmentIndex ==0) {
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"增肌 蛋白粉"
                                pageIndex:index];
        
        
    }
    if (_segmentedController.selectedSegmentIndex ==1) {
        
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"安全套"
                                pageIndex:index];
        
        
    }
    if (_segmentedController.selectedSegmentIndex==2) {
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"瑜伽垫"
                                pageIndex:index];
        
        
        
    }
    if (_segmentedController.selectedSegmentIndex==3) {
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"健身 背心 运动"
                                pageIndex:index];
    }

}

#pragma mark --
#pragma mark -- Pull Load More Datas
-(void)LoadMoreDatas
{
    self.loadingmore =YES;
    //currentPage ++;
    currentPageIndex ++;
    
    NSString *index =[NSString stringWithFormat:@"%d",currentPageIndex];
    
    if (_segmentedController.selectedSegmentIndex ==0) {
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"增肌 蛋白粉"
                                pageIndex:index];
        
        
    }
    if (_segmentedController.selectedSegmentIndex ==1) {
        
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"安全套"
                                pageIndex:index];
        
        
    }
    if (_segmentedController.selectedSegmentIndex==2) {
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"瑜伽垫"
                                pageIndex:index];
        
        
        
    }
    if (_segmentedController.selectedSegmentIndex==3) {
        
        [self loadProductsDataWithThemeID:nil
                                searchKey:@"健身 背心 运动"
                                pageIndex:index];
    }

}

- (void)loadMoreTableViewDataSource
{
    
    if (self.loadingmore) return;
    
    //currentPage ++;
    [self LoadMoreDatas];
    
}

#pragma mark --
#pragma mark --Did get productions Method
-(void)didGetProductsArray:(NSArray *)products errorCode:(int)errorCode{
    
    [self dataSourceDidFinishLoadingNewData];
    [self dataSourceDidFinishLoadingMoreData];

    if ([products count]==0) {
        self.loadingmore = NO;
        [self popupHappyMessage:@"亲,没有数据了！" title:nil];
        [self.dataTableView reloadData];
        return ;
    }
    
    
    if (self.loadingmore)
    {
        self.loadingmore = NO;
        NSMutableArray *newDataList = [NSMutableArray arrayWithArray:self.dataList];
        [newDataList addObjectsFromArray:products];
        
        self.dataList = newDataList;
        
    }
    else
    {
        self.dataList = products;
    }

    
    
    [self updateUserInterface];
    
}

#pragma mark -
#pragma mark  UPDATEUI  Methods
-(void)updateUserInterface{
    [self hideActivity];
    [self.dataTableView setHidden:NO];
    [self.carousel reloadData];
    [self.dataTableView reloadData];
    [_spacePageControl setNumberOfPages:NUMBER_OF_ITEMS];
}



@end
