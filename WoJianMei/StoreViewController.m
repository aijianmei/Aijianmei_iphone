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


@implementation StoreViewController



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




    


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
    
//    [self setBackgroundImageName:@"gobal_background.png"];
//    [self showBackgroundImage];

}





@end
