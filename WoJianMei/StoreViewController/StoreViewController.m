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








#define APP_KEY @"200449"
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
#pragma mark - InitMoreUI
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
    
    
    User *user = [[UserManager defaultManager] user];
    
    if (user.uid) {
        Myself_SettingsViewController *vc =[[Myself_SettingsViewController alloc]initWithNibName:@"Myself_SettingsViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        [[AppDelegate  getAppDelegate] showLoginView];
    }
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





-(void)LoadMore
{
    self.loadingmore =YES;
     currentPageIndex ++;
    [[StoreService sharedService] findPorductsWithThemeID:@""
                                                searchKey:@"杜蕾斯"
                                                pageIndex:[NSString stringWithFormat:
                                                           @"%d",currentPageIndex]
                                           viewController:self];

}



-(void)loadProductsData{

    [[StoreService sharedService] findPorductsWithThemeID:@""
                                                searchKey:@"杜蕾斯"
                                                pageIndex:[NSString stringWithFormat:
                                                            @"%d",currentPageIndex]
                                           viewController:self];
}

- (void)viewDidLoad
{
    
    self.supportRefreshHeader = YES;
    self.supportRefreshFooter = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    
    
    //Set Delegate
    [[CuzyAdSDK sharedAdSDK] setDelegate:self];

    //release server key & secret:
    [[CuzyAdSDK sharedAdSDK] registerAppWithAppKey:APP_KEY 	andAppSecret:AppSecret];
    
    self.loadingmore = NO;

    
 
    ///
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"updateInformation" object:nil];
}

-(void)receiveNotification:(NSNotification*)note{
    //return from category , reset page information
    currentPageIndex = 0;
    [self loadProductsData];
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
        leftView.tag = LEFT_ITEM_TAG;
        leftView.viewController = self;

        
        [cell addSubview:leftView];
        
        
        NSArray *array2 = [[NSBundle mainBundle] loadNibNamed:@"SingleItemView"owner:self options:nil];
        SingleItemView *rightView = [array2 objectAtIndex:0];
        rightView.tag = RIGHT_ITEM_TAG;
        rightView.center = CGPointMake(240, 85);
        
        rightView.viewController =self;
        
        [cell addSubview:rightView];


		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    
    
    SingleItemView*leftView = (SingleItemView*)[cell viewWithTag:LEFT_ITEM_TAG];
    [self setSingleItemView:leftView withTaobaoItem:[self.dataList objectAtIndex:2*indexPath.row]];
    
    SingleItemView*rightView = (SingleItemView*)[cell viewWithTag:RIGHT_ITEM_TAG];
    [self setSingleItemView:rightView withTaobaoItem:[self.dataList objectAtIndex:2*indexPath.row+1]];
    
    
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


- (void)MyReloadData {
    
    [self LoadMore];
}


#pragma Pull Refresh Delegate
- (void)reloadTableViewDataSource
{
    self.loadingmore =NO;
    [self loadProductsData];
}

#pragma mark - Load More
- (void)loadMoreTableViewDataSource
{
    
    if (self.loadingmore) return;
    self.loadingmore = YES;
    
    //currentPage ++;
    [self performSelector:@selector(MyReloadData) withObject:self afterDelay:1.0f];
    //make a delay to show loading process for a while
}

-(void)didGetProductsArray:(NSArray *)products errorCode:(int)errorCode{
    
    [self dataSourceDidFinishLoadingNewData];
    [self dataSourceDidFinishLoadingMoreData];

    self.dataList = products;
    
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

    [self.dataTableView reloadData];

}




@end
