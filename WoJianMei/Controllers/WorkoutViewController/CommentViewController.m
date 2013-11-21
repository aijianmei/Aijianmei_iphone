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
#import "UserManager.h"
#import "Result.h"
#import <AGCommon/UIDevice+Common.h>
#import "YFInputBar.h"



enum ErrorCode
{
    ERROR_SUCCESS =0,
    LACK_OF_PARAMATERS =10001,
    REPEATED_POST =10002
};




@interface CommentViewController ()<YFInputBarDelegate>


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
-(void)viewDidUnload
{

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
    
    
    
    
    
    
    YFInputBar *inputBar = [[YFInputBar alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY([UIScreen mainScreen].bounds)-44, 320, 44)];
    
//    inputBar.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    //设定地步导航栏的颜色
	inputBar.backgroundColor =[UIColor colorWithRed:66.0/255.0 green:155.0/255.0 blue:255.0/255.0 alpha:1 ];
    
    inputBar.delegate = self;
    inputBar.clearInputWhenSend = YES;
    inputBar.resignFirstResponderWhenSend = YES;
    
    [self.view addSubview:inputBar];

    
    
    


    
    
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
//    [self.faceToolBar dismissKeyBoard];
}



-(void)loadDatas{
    
        
    if (self.article) {
        [[ArticleService sharedService] loadCommentById:self.article._id
                                            channelType:@"1"
                                         viewController:self];
    }
    
    

    
    if (self.video) {
        [[ArticleService sharedService] loadCommentById:self.video._id
                                            channelType:@"2"
                                         viewController:self];
    }

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
#pragma mark - YFInputBarDelegateMethod
-(void)inputBar:(YFInputBar *)inputBar sendBtnPress:(UIButton *)sendBtn withInputString:(NSString *)str
{
    NSLog(@"%@",str);
    
    User *user = [[UserManager defaultManager] user];
    
    
    if (self.article) {
        [[ArticleService sharedService] postCommentWithUid:user.uid
                                           targetContentId:self.article._id
                                                   comment:str
                                               channelType:@"1"
                                            viewController:self];
    }
    
    if (self.video) {
        [[ArticleService sharedService] postCommentWithUid:user.uid
                                           targetContentId:self.video._id
                                                   comment:str
                                               channelType:@"2"
                                            viewController:self];
    }

}



-(void)inputBar:(YFInputBar*)inputBar retBtnPress:(UIButton*)sendBtn{

    [self.navigationController popViewControllerAnimated:YES];

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [((UIView*)obj) resignFirstResponder];
    }];
}

#pragma mark -
#pragma mark - NetWorkDelegateMethod

-(void)didPostCommentSucceeded:(int)errorCode
{
        
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
    
-(void)didReceiveCommentListSucceeded:(NSArray *)objects  errorCode:(int)errorCode

{

        if ([objects count]==0)
        {
            [self popupHappyMessage:@"亲,没有如何评论！" title:nil];
        }
    
    
         self.dataList = objects;
        [self.dataTableView reloadData];

}

@end
