//
//  WorkoutMainViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/13/13.
//
//

#import "WorkoutMainViewController.h"
#import "NumberDataViewController.h"
#import "SDSegmentedControl.h"
#import "WorkoutFirstTypeViewController.h"
#import "WorkoutDataService.h"
#import "UserService.h"
#import "Result.h"
#import "UserCatalog.h"
#import "WorkoutCatalog.h"
#import "NumberData.h"
#import "NumberDataManager.h"


#define DATA_VIEW_TAG 201308291
#define IMAGE_VIEW_TAG 201308292
#define NOTE_VIEW_TAG 201308293



@interface WorkoutMainViewController ()

@end

@implementation WorkoutMainViewController
@synthesize numberDataViewController =_numberDataViewController;
@synthesize segmentedController =_segmentedController;
@synthesize buttonTitleArray =_buttonTitleArray;
@synthesize userCatalogMenue =_userCatalogMenue;

@synthesize dataButton =_dataButton;
@synthesize imageButton =_imageButton;
@synthesize noteButton =_noteButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    
    [_numberDataViewController release];
    [_segmentedController release];
    [_buttonTitleArray release];
    [_userCatalogMenue release];
    
    
    [_dataButton release];
    [_imageButton release];
    [_noteButton release];
    
    [super dealloc];

}

-(void)viewDidUnload{

    [self setDataButton:nil];
    [self setImageButton: nil];
    [self setNoteButton:nil];
    
    [super viewDidUnload];
}


#pragma mark -
#pragma mark Orientation

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
    
}
//默认为No
- (BOOL)shouldAutorotate{
    return YES;
}



#pragma mark-- addButtonSegcontrol  Method
-(void)addButtonControl{
    ////Configure The Buttons
    if (_segmentedController ==nil) {
        self.buttonTitleArray =[NSMutableArray arrayWithObjects:@"",nil];
        self.segmentedController=[[SDSegmentedControl alloc]initWithItems:_buttonTitleArray];
        [_segmentedController setFrame:CGRectMake(0, 0, 640, 40)];
        [_segmentedController setSelectedSegmentIndex:0];
        [_segmentedController addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    [self.view addSubview:_segmentedController];
}


-(void)clickWorkoutType:(id)sender{

    WorkoutFirstTypeViewController *vc = [[WorkoutFirstTypeViewController alloc]initWithNibName:@"WorkoutFirstTypeViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];


}

#pragma mark-- ButtonClicked Method
-(void)buttonClicked:(SDSegmentedControl *)sender{

    
    //获取用户当前点击按钮
    NSInteger selectedIndex =  [sender selectedSegmentIndex];
    selectedCatalog = [self.userCatalogMenue objectAtIndex:selectedIndex];
    
    User *user = [[UserService defaultService] user];
    [[WorkoutDataService sharedService]  loadUserWorkoutDataWithUserId:user.uid workoutId:selectedCatalog._id delegate:self];
        
}

//点击页面的时候要隐藏键盘
-(void)tap{
    
    TPKeyboardAvoidingTableView *tableView =  (TPKeyboardAvoidingTableView *)self.numberDataViewController.dataTableView;
    [tableView  hideKeyboard];

}

#pragma --mark
#pragma Buttons Methods

-(void)didClickDataButton:(UIButton *)sender{
    
    if (self.numberDataViewController ==nil) {
        NumberDataViewController *numberDataView =[[NumberDataViewController alloc]initWithNibName:@"NumberDataViewController" bundle:nil];
        self.numberDataViewController =numberDataView;
        [_numberDataViewController.view setFrame:CGRectMake(5, 40, 310, 480)];
        [_numberDataViewController.view setBackgroundColor:[UIColor clearColor]];
        
        [_numberDataViewController.view setTag:DATA_VIEW_TAG ];
    }
    [self.view addSubview:_numberDataViewController.view];
    
    
}
-(void)didClickImageButton:(UIButton *)sender{

    [[self.view viewWithTag:DATA_VIEW_TAG] removeFromSuperview];
    
}


-(void)didClickNoteButton:(UIButton *)sender{
    [[self.view viewWithTag:DATA_VIEW_TAG] removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    
    [self setNavigationRightButton:@"动作" imageName:@"top_bar_commonButton.png" action:@selector(clickWorkoutType:)];

    
    
    
    [_dataButton addTarget:self action:@selector(didClickDataButton:) forControlEvents:UIControlEventTouchUpInside];
    [_imageButton addTarget:self action:@selector(didClickImageButton:) forControlEvents:UIControlEventTouchUpInside];
    [_noteButton addTarget:self action:@selector(didClickNoteButton:) forControlEvents:UIControlEventTouchUpInside];
        
    //轻触手势（单击）
    UITapGestureRecognizer *tapCgr=nil;
    tapCgr=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                  action:@selector(tap)];
    tapCgr.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tapCgr];
    [_numberDataViewController.view addGestureRecognizer:tapCgr];
    [tapCgr release];

    
    
    //下载用户个性化目录
    [self loadWorkoutCatalogMenueWithWorkout:nil];
    
}



//返回前一页
- (IBAction)clickBack:(id)sender {
    
    
    TPKeyboardAvoidingTableView *tableView =  (TPKeyboardAvoidingTableView *)self.numberDataViewController.dataTableView;
    
    if (tableView._keyboardVisible) {
        //隐藏键盘
        [self tap];
        
        //停顿一会儿之后显示键盘
        float duration =0.7;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                      target:self
                                                    selector:@selector(popToRootView)
                                                    userInfo:nil
                                                     repeats:NO];
    }else{
    
        [self popToRootView];
    
    }

}

-(void)popToRootView{

    [self.timer invalidate];
    //状态栏旋转
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
    [self.navigationController popToRootViewControllerAnimated:YES];

}

//用户个性化个性化目录
-(void)loadWorkoutCatalogMenueWithWorkout :(Workout *)workout
{
    User *user =  [[UserService defaultService] user];
    [[WorkoutDataService sharedService] loadUserSpecificWorkoutDataWithUserId:user.uid delegate:self];
}

-(void)upgradeUI{
    
    [self.segmentedController removeFromSuperview];
    self.segmentedController=[[SDSegmentedControl alloc]initWithItems:self.buttonTitleArray];
    [_segmentedController setFrame:CGRectMake(0, 0, 680, 40)];
    [_segmentedController setSelectedSegmentIndex:0];
    [_segmentedController addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventValueChanged];
    [_segmentedController setSegmentedControlStyle:UISegmentedControlStyleBezeled];

    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 400, 40)];
    [scrollView setContentSize:CGSizeMake(760,40)];
    [scrollView addSubview:_segmentedController];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [scrollView setScrollEnabled:YES];

    [self.view addSubview:scrollView];

    [scrollView release];
    
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
    [self hideActivity];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
    [self hideActivity];
}

- (void)requestDidStartLoad:(RKRequest *)request
{
    NSLog(@"Start load request...");
    [self showActivityWithText:@"加载中..."];
    
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects count: %d", [objects count]);
    [self hideActivity];
    
    if ([objects count] ==0) {
        return;
    }

    NSObject *object =  [objects objectAtIndex:0];
    
    //更新用户目录
    if ([object isMemberOfClass:[UserCatalog class]]) {
        UserCatalog *userCatalog= (UserCatalog *)object;
        
        //添加按钮
        [self addButtonControl];
        [self.buttonTitleArray removeAllObjects];
        
        for (int i=0;i<=3;i++) {
            Catalog *catalog = [userCatalog.catalogList objectAtIndex:i];
            self.userCatalogMenue = userCatalog.catalogList;
            [self.buttonTitleArray addObject:catalog.name];
            if (i==0) {
                PPDebug(@"动作的名称 :%@",catalog.name);
            }
        }
        
        //更新顶部导航数据
        [self upgradeUI];
        
        [self buttonClicked:nil];
        
    }
    
    if ([object isMemberOfClass:[NumberDataInfo class]]) {
        
        [self hideActivity];
        NumberDataInfo *numberDataInfo = (NumberDataInfo *)object;
        
        if ([numberDataInfo.numberDataArray count] ==0) {
            
        [self popupMessage:[NSString stringWithFormat: @"亲，你今天没有记录 %@ 数据哦!",selectedCatalog.name] title:selectedCatalog.name];
        }
        
        
        //默认点击了数据按钮
        [self didClickDataButton:nil];
        
        
        
        //显示数据的tableview,
        self.numberDataViewController.dataList =numberDataInfo.numberDataArray;
        
        
        
        //把获取到的服务器上面的数据，赋值给 NumberDataManager 统一管理
        NSMutableArray *mutableArray =
        [[NumberDataManager  defaultManager] dataList];
        [mutableArray removeAllObjects];
        [mutableArray addObjectsFromArray:numberDataInfo.numberDataArray];
        
        
        
        
        //赋值给numberDataView 确定当前点击了那个锻炼动作，获取id
        // 同时根据动作 id 修改动作的数据，并且递交到服务器数据
        //selected 是为了修改数据递交数据用的;
        self.numberDataViewController.selectedCatalog = selectedCatalog;
        
        //设置导航，名称
        [self setTitle:selectedCatalog.name];
        
        
        
        //更新table 的内容
        [_numberDataViewController.dataTableView reloadData];
        [_numberDataViewController updateFooterAndHeader];
      }
}


@end
