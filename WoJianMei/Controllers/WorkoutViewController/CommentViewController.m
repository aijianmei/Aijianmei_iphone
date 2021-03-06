//
//  CommentViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/23/13.
//
//

#import "CommentViewController.h"
#import "CommentCell.h"
#import "comment.h"
#import "VideoService.h"
#import "Video.h"
#import "Article.h"
#import "BaiduMobStat.h"
@interface CommentViewController ()

@end

@implementation CommentViewController
@synthesize video =_video;
@synthesize article =_article;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    
    }
    return self;
}

-(void)dealloc {
    [_video release];
    [_article release];
    [super dealloc];

}

#pragma mark -
#pragma mark - View lifecycle
-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:YES];
    //开始加载数据
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"CommentView"];
    [self loadDatas];

}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"CommentView"];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    [self.view  setBounds:CGRectMake(0, 40, 320, 520)];

    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];

    [self.navigationController.navigationBar setHidden:NO];
//    [self setTitle:@"评论页面"];
    
//    FaceToolBar* bar=[[FaceToolBar alloc]initWithFrame:CGRectMake(0.0f,self.view.frame.size.height - toolBarHeight,self.view.frame.size.width,toolBarHeight) superView:self.view];
//    bar.delegate=self;
//    [self.view addSubview:bar];
//    [bar release];
    

    [self.dataTableView setContentSize:CGSizeMake(320, 800)];
    
//    [self loadDatas];

}

-(void)loadDatas{
    
        
    if (self.article) {
        [[VideoService sharedService] loadVideCommentByVideId:self.article._id channelType:@"1" delegate:self];
    }
    
    
//        [[VideoService sharedService] loadVideCommentByVideId:@"117" channelType:@"1" delegate:self];

    
    if (self.video) {
        [[VideoService sharedService] loadVideCommentByVideId:self.video._id channelType:@"2" delegate:self];
    }

}

#pragma mark-
#pragma mark- DelegateMethod


-(void)sendTextAction:(NSString *)inputText{
    NSLog(@"sendTextAction%@",inputText);
}

-(void)clickBackButton{
    [self  clickBack:nil];
}

- (void)clickBack:(id)sender
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 420, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height)];
	[self.navigationController popViewControllerAnimated:YES];
    
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
    NSString *CellIdentifier = [CommentCell getCellIdentifier];
    CommentCell *cell = (CommentCell*)[self.dataTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell  = [[[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    Comment *comment  = [dataList objectAtIndex:indexPath.row];

    
    if (comment) {
        [cell setCellInfo:comment];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  [CommentCell getCellHeight];
}


- (void)setRightBarCommentTextField
{
    float buttonHigh = 27.5;
    float buttonLen = 200;
    float leftOffset  =0;
        
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(70, 0, buttonLen, buttonHigh)];

    [rightView setBackgroundColor:[UIColor redColor]];
    
    UITextField * commentTextField = [[UITextField alloc] initWithFrame:CGRectMake(leftOffset, 3, 200, 30)];
    [commentTextField setBackground:[UIImage imageNamed:@"dlk_1.png"]];
    [commentTextField setDelegate:self];
    [commentTextField resignFirstResponder];
    [rightView addSubview:commentTextField];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]
                                       initWithCustomView:rightView];
    
    [rightView release];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [rightBarButton release];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self showActivityWithText:@"数据加载中..."];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects count: %d", [objects count]);
    [self hideActivity];
    
    if ( [objects count]==0)
    {
        
        [self popupHappyMessage:@"亲,没有如何评论！" title:nil];

    }
     self.dataList = objects;
    [self.dataTableView reloadData];
}

@end
