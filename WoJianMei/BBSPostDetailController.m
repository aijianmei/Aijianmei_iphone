//
//  BBSPostDetailController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "BBSPostDetailController.h"
#import "BBSPostDetailCell.h"
#import "PostDetailHeaderView.h"
#import "PostStatus.h"
#import "UserManager.h"




@interface BBSPostDetailController ()

@end

@implementation BBSPostDetailController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [super dealloc];
    
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
    
    [self loadPublicPostDatas];

}


-(void)loadPublicPostDatas
{
    _reloading = YES;
    shouldLoad =YES;
    
    User *user =[[UserManager defaultManager]user];
    
    
    [[PostService sharedService] loadStatusWithUid:user.uid
                                         targetUid:nil
                                          gymGroup:@"0"
                                             start:@"0"
                                            offSet:@"5"
                                    viewController:self];
}


-(void)initTableHeaderView{

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
//        [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 244)];
    }else{
//        [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 360.0f)];
    }
    
    PostDetailHeaderView *headerView =[PostDetailHeaderView createView:self];
    [self.dataTableView setTableHeaderView:headerView];
}


-(void)updateHeaderView:(PostStatus *)post{
    
    PostDetailHeaderView *headerView =[PostDetailHeaderView createView:self];
    [headerView updateView:post];
    [self.dataTableView setTableHeaderView:headerView];
    
}

-(void)initUI{
    [self initTableHeaderView];
}




#pragma mark  Reload and LoadMore Method
//加载新的数据
- (void)reloadTableViewDataSource{
    
    _reloading = YES;
    User *user =[[UserManager defaultManager]user];
    [[PostService sharedService] loadStatusWithUid:user.uid
                                         targetUid:nil
                                          gymGroup:@"0"
                                             start:@"0"
                                            offSet:@"5"
                                    viewController:self];
    
}
//加载更多数据
- (void)loadMoreTableViewDataSource {
    _reloading = NO;
    User *user =[[UserManager defaultManager]user];
    [[PostService sharedService] loadStatusWithUid:user.uid
                                         targetUid:nil
                                          gymGroup:@"0"
                                             start:@"0"
                                            offSet:[NSString stringWithFormat:@"%d", _start]
                                    viewController:self];
    
}
#pragma mark --
#pragma mark  tableviewDelegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [BBSPostDetailCell getCellIdentifier];
	BBSPostDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [BBSPostDetailCell createCell:self];
	}
    
    PostStatus *post = [self postStatusForIndexPath:indexPath];
    [cell updateCellWithBBSPost:post];
    
	return cell;
}

- (PostStatus *)postStatusForIndexPath:(NSIndexPath *)indexPath
{
    NSArray *dList = self.dataList;
    if (indexPath.row >= [dList count]) {
        return nil;
    }
    PostStatus *action = [self.dataList objectAtIndex:indexPath.row];
    return action;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PostStatus *post = [self.dataList objectAtIndex:indexPath.row];
	return [BBSPostDetailCell getCellHeightWithBBSPost:post];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - RKObjectLoaderDelegate
-(void)didLoadStatusesSucceeded:(int)errorCode didLoadObjects:(NSArray *)objects
{
    [self dataSourceDidFinishLoadingNewData];
    [self dataSourceDidFinishLoadingMoreData];
    
    [self hideActivity];
    PPDebug(@"***Load objects count: %d", [objects count]);
    
    if ([objects count] == 0) {
        [self popupMessage:@"亲,已经没有更多数据了！" title:nil];
        return;
    }

    NSMutableArray *newDataList =nil;
    
    if (_start == 0) {
        self.dataList = objects;
    } else {
        
        newDataList = [NSMutableArray arrayWithArray:self.dataList];
        [newDataList addObjectsFromArray:objects];
        if (_reloading) {
            [newDataList setArray:objects];
            _start =0;
            
        }
        self.dataList = newDataList;
    }
    
    _start += [objects count];
    PPDebug(@"****objects %d******",[self.dataList count]);
    
    PostStatus *postStatus =  [objects objectAtIndex:0];
    [self updateHeaderView:postStatus];
    [self.dataTableView reloadData];
    
}


@end
