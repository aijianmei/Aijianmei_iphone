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
#import "ImageManager.h"
#import "PostService.h"
#import "UserService.h"
#import "Result.h"
#import <AGCommon/UIDevice+Common.h>


enum ErrorCode
{
    ERROR_SUCCESS =0,
    LACK_OF_PARAMATERS =10001,
    REPEATED_POST =10002
};




@interface CommentViewController ()

@end

@implementation CommentViewController
@synthesize video =_video;
@synthesize article =_article;
@synthesize faceToolBar =_faceToolBar;


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
    [_faceToolBar release];
    [super dealloc];

}

#pragma mark -
#pragma mark - View lifecycle
-(void)viewDidUnload
{

    [self setFaceToolBar:nil];
    [super viewDidUnload];
        
}

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

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    
    
    [self.dataTableView setContentSize:CGSizeMake(320, 800)];
    
    
    
    
    
    
    self.faceToolBar =[[FaceToolBar alloc]initWithFrame:CGRectMake(0.0f,self.view.frame.size.height - toolBarHeight,self.view.frame.size.width,toolBarHeight)
                                             superView:self.view];
    
    
    
    
    if ([[UIDevice currentDevice] isPhone5])
    {
        [self.faceToolBar setFrame:CGRectMake(0.0f,self.view.frame.size.height + 100 - toolBarHeight,self.view.frame.size.width,toolBarHeight)];
    }
    
    
    self.faceToolBar.delegate = self;
    [self.view addSubview:_faceToolBar];


    [self loadDatas];
    
    
    
    //轻触手势（单击，双击）
    UITapGestureRecognizer *tapCgr=nil;
    tapCgr=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                  action:@selector(tap)];
    tapCgr.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tapCgr];
    [tapCgr release];

    


}


-(void)tap{
    [self.faceToolBar dismissKeyBoard];
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
    
    
     User *user = [[UserService defaultService] user];
    

    if (self.article) {
        [[PostService sharedService] postCommentWithUid:
         [user uid] targetContentId:self.article._id comment:inputText channelType:@"1" delegate:self];
    }
    
    if (self.video) {
        [[PostService sharedService] postCommentWithUid:
         [user uid] targetContentId:self.video._id comment:inputText channelType:@"2" delegate:self];    }

}




-(void)clickBackButton:(UIButton *)sender;
{
    [self clickBack:sender];
}





- (void)clickBack:(id)sender
{
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 420, self.navigationController.navigationBar.bounds.size.width, self.navigationController.navigationBar.bounds.size.height)];
	[self.navigationController popViewControllerAnimated:YES];
    
    [self dismissModalViewControllerAnimated:YES];
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
    
    if ([objects count]==0) {
        return;
    }
    
    
    NSObject *object = [objects objectAtIndex:0];
    
    if ([object isMemberOfClass:[Result class]]) {
        
        //  10001 参数错误 缺少uid用户id或者缺少文章id
        //  10002 用户已经赞过
        //  0 提交成功
        
        Result *result = [objects objectAtIndex:0];
        NSInteger errorCode =  [[result errorCode] integerValue];
        
        
        if (errorCode ==ERROR_SUCCESS)
        {
            [self popupHappyMessage:@"文章评论成功" title:nil];
            [self loadDatas];
        }
        
        if (errorCode ==LACK_OF_PARAMATERS) {
            [self popupHappyMessage:@"未知错误" title:nil];
        }
        
        if (errorCode ==REPEATED_POST) {
            [self popupUnhappyMessage:@"已经评论文章,不可以重复哦！" title:nil];
        }

    }
    
    
    if ([object isMemberOfClass:[Comment class]]) {
        if ([objects count]==0)
        {
            [self popupHappyMessage:@"亲,没有如何评论！" title:nil];
        }
        self.dataList = objects;
        [self.dataTableView reloadData];
    }
}

@end
