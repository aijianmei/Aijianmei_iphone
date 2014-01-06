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





#import "TMQuiltView.h"
#import "TMPhotoQuiltViewCell.h"

@interface StoreViewController ()<TMQuiltViewDataSource,TMQuiltViewDelegate>
{

	TMQuiltView *qtmquitView;

}
@property (nonatomic, retain) NSMutableArray *images;


@end

@implementation StoreViewController

@synthesize images = _images;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];

    
    
    qtmquitView = [[TMQuiltView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
	qtmquitView.delegate = self;
	qtmquitView.dataSource = self;
	
	[self.view addSubview:qtmquitView];
	
	[qtmquitView reloadData];
    [self createHeaderView];
	[self performSelector:@selector(testFinishedLoadData)
               withObject:nil
               afterDelay:0.0f];

}

//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
//初始化刷新视图
//＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#pragma mark
#pragma methods for creating and removing the header view

-(void)createHeaderView{
    if (_refreshHeaderView && [_refreshHeaderView superview]) {
        [_refreshHeaderView removeFromSuperview];
    }
	_refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:
                          CGRectMake(0.0f, 0.0f - self.view.bounds.size.height,
                                     self.view.frame.size.width, self.view.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    
	[qtmquitView addSubview:_refreshHeaderView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
}

-(void)testFinishedLoadData{
	
    [self finishReloadingData];
    [self setFooterView];
}

#pragma mark -
#pragma mark method that should be called when the refreshing is finished
- (void)finishReloadingData{
	
	//  model should call this when its done loading
	_reloading = NO;
    
	if (_refreshHeaderView) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:qtmquitView];
    }
    
    if (_refreshFooterView) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:qtmquitView];
        [self setFooterView];
    }
    
    // overide, the actula reloading tableView operation and reseting position operation is done in the subclass
}

-(void)setFooterView{
	//    UIEdgeInsets test = self.aoView.contentInset;
    // if the footerView is nil, then create it, reset the position of the footer
    CGFloat height = MAX(qtmquitView.contentSize.height, qtmquitView.frame.size.height);
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        // reset position
        _refreshFooterView.frame = CGRectMake(0.0f,
                                              height,
                                              qtmquitView.frame.size.width,
                                              self.view.bounds.size.height);
    }else
	{
        // create the footerView
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:
                              CGRectMake(0.0f, height,
                                         qtmquitView.frame.size.width, self.view.bounds.size.height)];
        _refreshFooterView.delegate = self;
        [qtmquitView addSubview:_refreshFooterView];
    }
    
    if (_refreshFooterView)
	{
        [_refreshFooterView refreshLastUpdatedDate];
    }
}


-(void)removeFooterView
{
    if (_refreshFooterView && [_refreshFooterView superview])
	{
        [_refreshFooterView removeFromSuperview];
    }
    _refreshFooterView = nil;
}

//===============
//刷新delegate
#pragma mark -
#pragma mark data reloading methods that must be overide by the subclass

-(void)beginToReloadData:(EGORefreshPos)aRefreshPos{
	
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    
    if (aRefreshPos == EGORefreshHeader)
	{
        // pull down to refresh data
        [self performSelector:@selector(refreshView) withObject:nil afterDelay:2.0];
    }else if(aRefreshPos == EGORefreshFooter)
	{
        // pull up to load more data
        [self performSelector:@selector(getNextPageView) withObject:nil afterDelay:2.0];
    }
	
	// overide, the actual loading data operation is done in the subclass
}

//刷新调用的方法
-(void)refreshView
{
	NSLog(@"刷新完成");
    [self testFinishedLoadData];
	
}
//加载调用的方法
-(void)getNextPageView
{
	for(int i = 0; i < 10; i++) {
		[_images addObject:[NSString stringWithFormat:@"%d.jpeg", i % 10 + 1]];
	}
	[qtmquitView reloadData];
    [self removeFooterView];
    [self testFinishedLoadData];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	if (_refreshHeaderView)
	{
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
	
	if (_refreshFooterView)
	{
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (_refreshHeaderView)
	{
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
	
	if (_refreshFooterView)
	{
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


#pragma mark -
#pragma mark EGORefreshTableDelegate Methods
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
	
	[self beginToReloadData:aRefreshPos];
	
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}


// if we don't realize this method, it won't display the refresh timestamp
- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view
{
	
	return [NSDate date]; // should return date data source was last changed
	
}

- (NSMutableArray *)images
{
    if (!_images)
	{
        NSMutableArray *imageNames = [NSMutableArray array];
        for(int i = 0; i < 10; i++) {
            [imageNames addObject:[NSString stringWithFormat:@"%d.jpeg", i % 10 + 1]];
        }
        _images = [imageNames retain];
    }
    return _images;
}


- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {
    return [UIImage imageNamed:[self.images objectAtIndex:indexPath.row]];
}

- (NSInteger)quiltViewNumberOfCells:(TMQuiltView *)TMQuiltView {
    return [self.images count];
}

- (TMQuiltViewCell *)quiltView:(TMQuiltView *)quiltView cellAtIndexPath:(NSIndexPath *)indexPath {
    TMPhotoQuiltViewCell *cell = (TMPhotoQuiltViewCell *)[quiltView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"];
    if (!cell) {
        cell = [[[TMPhotoQuiltViewCell alloc] initWithReuseIdentifier:@"PhotoCell"] autorelease];
    }
    
    cell.photoView.image = [self imageAtIndexPath:indexPath];
    cell.titleLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}

#pragma mark - TMQuiltViewDelegate
- (NSInteger)quiltViewNumberOfColumns:(TMQuiltView *)quiltView {
	
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft
        || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
	{
        return 3;
    } else {
        return 2;
    }
}

- (CGFloat)quiltView:(TMQuiltView *)quiltView heightForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return [self imageAtIndexPath:indexPath].size.height / [self quiltViewNumberOfColumns:quiltView];
}

- (void)quiltView:(TMQuiltView *)quiltView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"index:%d",indexPath.row);
    [self popupMessage:@"亲！商品暂时不可以购买哦!" title:nil];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
