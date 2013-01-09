//
//  MakeFriendsViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/29/12.
//
//

#import "MakeFriendsViewController.h"
#import "ComposeRootViewController.h"

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
    
    
    UIViewController *nv =[self.navigationController topViewController];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(sendPost:)];
     UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithTitle:@"写消息" style:UIBarButtonItemStyleBordered target:self action:@selector(sendPost:)];
    
    
    [nv.navigationItem setLeftBarButtonItem:leftBarButton];
    [nv.navigationItem setRightBarButtonItem:rightBarButton];
    
    [nv.navigationController.navigationBar.backItem setBackBarButtonItem:rightBarButton];
    
    [self setBackgroundImageName:@"BackGround.png"];
    [self showBackgroundImage];

    


}


-(void)sendPost:(id)sender{

//    ComposeRootViewController *vc = [[ComposeRootViewController alloc]init];
//    [self presentModalViewController:vc animated:YES];
//    [vc release];
    
    
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
