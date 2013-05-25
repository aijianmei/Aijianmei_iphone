//
//  LoginViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 5/23/13.
//
//

#import "LoginViewController.h"
#import "ShareToSinaController.h"
#import "ShareToQQViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStyleBordered target:self action:@selector(clickCancleButton:)];
    [bar setTitle:@"取消"];
    [self.navigationItem setRightBarButtonItem:bar];
    [bar release];

    
}

-(void)clickCancleButton:(UIButton *)sender{

    [self dismissModalViewControllerAnimated:YES];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)dealloc {
    
    [super dealloc];
}
- (void)viewDidUnload {
    
    [super viewDidUnload];
}

- (IBAction)clickSinaWeiboButton:(UIButton *)sender {
    
    
    
    ShareToSinaController *vc = [[ShareToSinaController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
}

- (IBAction)clickQQShareButton:(UIButton *)sender {
    
        
    ShareToQQViewController *vc = [[ShareToQQViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
}

@end
