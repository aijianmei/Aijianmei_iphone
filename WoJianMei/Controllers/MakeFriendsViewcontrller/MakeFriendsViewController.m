//
//  MakeFriendsViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/29/12.
//
//

#import "MakeFriendsViewController.h"

@interface MakeFriendsViewController ()

@end

@implementation MakeFriendsViewController

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
    
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 26)];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"refreshButton@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    
    
    
     UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    
    [leftButton setBackgroundImage:[UIImage imageNamed:@"refreshButton@2x.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    [self.navigationItem setRightBarButtonItem:leftBarButton];

    
    [self setBackgroundImageName:@"BackGround.png"];
    [self showBackgroundImage];

    


}


-(void)sendPost:(id)sender{



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
