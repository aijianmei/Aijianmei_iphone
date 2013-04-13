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
    
    
    
    
    
//    [self setNavigationLeftButton:nil imageName:@"postButton.png" action:@selector(clickPostButton:)];
//
//   [self setNavigationRightButton:nil imageName:@"refreshButton.png" action:@selector(clickPostButton:)];
    
    [self setBackgroundImageName:@"BackGround.png"];
    [self showBackgroundImage];

    

    

}


-(void)clickPostButton:(id)sender{
    
    PPDebug(@"PostButton was clicked !");
    
    [self performSegueWithIdentifier:@"PostSegue" sender:self];
    

}
-(void)clickRefreshButton:(id)sender{
    
    PPDebug(@"RefreshButton was clicked !");
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
