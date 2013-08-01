//
//  AJM_CommonViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 6/13/13.
//
//

#import "AJM_CommonViewController.h"
#import "IIViewDeckController.h"
#import "AppDelegate.h"

@interface AJM_CommonViewController ()

@end

@implementation AJM_CommonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    [self initMoreUI];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initMoreUI
{
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    ////leftBtn
    UIButton *leftBtn = [[[UIButton alloc] init] autorelease];
    
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"NavigationButtonBG.png"]
                       forState:UIControlStateNormal];
    
    [leftBtn setImage:[UIImage imageNamed:@"LeftSideViewIcon.png"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
    [leftBtn addTarget:self action:@selector(leftButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:leftBtn] autorelease];
    
    
    ////rightBtn
    UIButton *rightBtn = [[[UIButton alloc] init] autorelease];
    
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"NavigationButtonBG.png"]
                        forState:UIControlStateNormal];
    
    [rightBtn setImage:[UIImage imageNamed:@"LeftSideViewIcon.png"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0.0, 0.0, 53.0, 30.0);
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
}



@end
