//
//  CheckWorkoutDatasViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/13/13.
//
//

#import "ChartViewController.h"
#import "DeviceDetection.h"
#import "WorkoutFirstTypeViewController.h"


@interface ChartViewController ()

@end

@implementation ChartViewController
@synthesize sevenWebView =_sevenWebView;
@synthesize thirtyWebView =_thirtyWebView;
@synthesize yearWebView =_yearWebView;

@synthesize actionButton =_actionButton;

@synthesize sevenDayButton =_sevenDayButton;
@synthesize thirtyDayButton =_thirtyDayButton;
@synthesize yearButton =_yearButton;

@synthesize delegate =_delegate;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    
    [_sevenDayButton release];
    [_thirtyDayButton release];
    [_yearButton release];
    
    [_actionButton release];
    
    [_sevenWebView release];
    [_thirtyWebView release];
    [_yearWebView release];

    
    
    [super dealloc];
}

//- (BOOL)shouldAutorotate{
//    return NO;
//}

-(void)viewDidUnload{

    [self setYearButton:nil];
    [self setSevenDayButton:nil];
    [self setThirtyDayButton:nil];
    
    [self setActionButton:nil];
    
    [self setSevenWebView:nil];
    [self setThirtyWebView:nil];
    [self setYearWebView:nil];
    
    [super viewDidUnload];
}


-(void)initButtons{

    [_sevenDayButton  addTarget:self action:@selector(clickSevenDayButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_sevenDayButton setHidden:YES];
    
    [_thirtyDayButton  addTarget:self action:@selector(clickThirtyDayButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_thirtyDayButton setHidden:YES];

    [_yearButton  addTarget:self action:@selector(clickyearDayButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [_yearButton setHidden:YES];

    
    
    [_actionButton addTarget:self action:@selector(clickActionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
 
    
}

#pragma --mark
#pragma -- Action Methods

-(void)clickActionButton:(UIButton *)sender{
    WorkoutFirstTypeViewController *vc = [[WorkoutFirstTypeViewController alloc]initWithNibName:@"WorkoutFirstTypeViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}




#pragma --mark
#pragma -- Button Methods 

-(void)clickSevenDayButton :(UIButton *)sender{

    NSString *path = @"http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=showChartPage&uid=498&actionId=1&groupId=1&date=20130902&selectTagType=7";
    
    [_sevenWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    
    self.sevenWebView.delegate = self;
    
    if([DeviceDetection isIPhone5])
    {
        [_sevenWebView setFrame:CGRectMake(5,0,310,280)];
    }
    else
    {
        [_sevenWebView setFrame:CGRectMake(5,00,310,280)];
    }
    
    
    [_sevenWebView   removeFromSuperview];
    [_thirtyWebView  removeFromSuperview];
    [_yearWebView    removeFromSuperview];

    

    [self.view addSubview:_sevenWebView];
    [_sevenWebView setScalesPageToFit:YES];

    
    
    


}


-(void)clickThirtyDayButton :(UIButton *)sender{
    
     NSString *path = @"http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=showChartPage&uid=498&actionId=1&groupId=1&date=20130902&selectTagType=30";
    
    [_thirtyWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    self.thirtyWebView.delegate = self;

    if([DeviceDetection isIPhone5])
    {
        [_thirtyWebView setFrame:CGRectMake(20,40,300,250)];
        
    }
    else
    {
        [_thirtyWebView setFrame:CGRectMake(5,0,310,280)];
    }
    
    

    [_sevenWebView   removeFromSuperview];
    [_thirtyWebView  removeFromSuperview];
    [_yearWebView    removeFromSuperview];
    

    
    [self.view addSubview:_thirtyWebView];
    [_thirtyWebView setScalesPageToFit:YES];

}

-(void)clickyearDayButton :(UIButton *)sender{
    
     NSString *path = @"http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=showChartPage&uid=498&actionId=1&groupId=1&date=20130902&selectTagType=365";
    
    
    [_yearWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    self.yearWebView.delegate = self;

    
    if([DeviceDetection isIPhone5])
    {
        [_yearWebView setFrame:CGRectMake(20,40,300,270)];
    }
    else
    {
        [_yearWebView setFrame:CGRectMake(5,0,310,280)];
    }
    
    

    
    [_sevenWebView   removeFromSuperview];
    [_thirtyWebView  removeFromSuperview];
    [_yearWebView    removeFromSuperview];
    
    [self.view addSubview:_yearWebView];
    [_yearWebView setScalesPageToFit:YES];

    
}









- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    
    [self setNavigationRightButton:@"动作" imageName:@"top_bar_commonButton.png" action:@selector(clickActionButton:)];
    
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];

    
    
    //数据来源于本地 最终希望 
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"ichartjs" ofType:@"html"];
//    [self.chartWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];

    
    [self initButtons];
  
    //默认显示7 天得数据
//    [self clickSevenDayButton:nil];
    
    [self.sevenWebView setHidden:YES];
    [self.thirtyWebView setHidden:YES];
    [self.yearWebView setHidden:YES];

    
    
}



- (BOOL)webView:(UIWebView *)webView2
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
	NSString *requestString = [[request URL] absoluteString];
    
    
    if ([requestString hasPrefix:@"js-frame:"]) {
        
        return NO;
    }
    
    return YES;
}


-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:YES];
    
        
     NSString *path = @"http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=showChartPage&uid=498&actionId=1&groupId=1&date=20130902";
    
    [_sevenWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    
    
    
    
    


}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:YES];

    
}

//返回前一页
- (IBAction)clickBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
