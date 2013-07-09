//
//  ChangeDescriptionViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/9/13.
//
//

#import "ChangeDescriptionViewController.h"

@interface ChangeDescriptionViewController ()

@end

@implementation ChangeDescriptionViewController

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
    // Do any additional setup after loading the view from its nib.
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
