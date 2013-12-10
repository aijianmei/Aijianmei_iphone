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
    
}
-(void)initTableHeaderView{
    PostDetailHeaderView *headerView =[PostDetailHeaderView createView:self];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
//        [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 244)];
    }else{
//        [headerView setFrame: CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width, 360.0f)];
    }
    [self.dataTableView setTableHeaderView:headerView];
    
}




-(void)initUI{
    [self initTableHeaderView];
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
    
    NSString *CellIdentifier = [BBSPostDetailCell getCellIdentifier];
	BBSPostDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [BBSPostDetailCell createCell:self];
	}
    
	return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PBBBSPostComment *post = [self.dataList objectAtIndex:indexPath.row];
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

@end
