//
//  RootViewController.m
//  REComposeViewControllerExample
//
//  Created by Roman Efimov on 10/19/12.
//  Copyright (c) 2012 Roman Efimov. All rights reserved.
//

#import "ComposeRootViewController.h"
#import "REComposeViewController.h"

@interface ComposeRootViewController ()

@end

@implementation ComposeRootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    
    
    
    
    
    ///// add dismiss view controller button
//    
//    UIButton *canlcleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    canlcleButton.frame = CGRectMake(240, 10, 70, 40);
//    [canlcleButton addTarget:self action:@selector(cancleButton:) forControlEvents:UIControlEventTouchUpInside];
//    [canlcleButton setTitle:@"返回" forState:UIControlStateNormal];
//    [self.view addSubview:canlcleButton];
    
    
    
    [MFSlidingView slideView:view1 intoView:self.view
            onScreenPosition:MiddleOfScreen offScreenPosition:LeftOfScreen];
    
    
    
//    UIButton *socialExampleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    socialExampleButton.frame = CGRectMake(60, 10 + 80, 200, 40);
//    [socialExampleButton addTarget:self action:@selector(socialExampleButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [socialExampleButton setTitle:@"发微博" forState:UIControlStateNormal];
//    [self.view addSubview:socialExampleButton];
//    
//    UIButton *tumblrExampleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    tumblrExampleButton.frame = CGRectMake(60, 60 + 80, 200, 40);
//    [tumblrExampleButton addTarget:self action:@selector(tumblrExampleButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [tumblrExampleButton setTitle:@"提问" forState:UIControlStateNormal];
//    [self.view addSubview:tumblrExampleButton];
//    
//    UIButton *foursquareExampleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    foursquareExampleButton.frame = CGRectMake(60, 110 + 80, 200, 40);
//    [foursquareExampleButton addTarget:self action:@selector(foursquareExampleButtonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [foursquareExampleButton setTitle:@"预约" forState:UIControlStateNormal];
//    [self.view addSubview:foursquareExampleButton];
    
}

#pragma mark -
#pragma mark Button actions


-(void)cancleButton:(id)sender{

  
    [self dismissModalViewControllerAnimated:YES];
    
}



- (void)socialExampleButtonPressed
{
    REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
    composeViewController.title = @"微博";
    composeViewController.hasAttachment = YES;
    composeViewController.delegate = self;
    composeViewController.text = @"我热爱健身!";
    [self presentViewController:composeViewController animated:YES completion:nil];
}

- (void)tumblrExampleButtonPressed
{
    REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
    composeViewController.title = @"提问";
    composeViewController.hasAttachment = YES;
    composeViewController.attachmentImage = [UIImage imageNamed:@"Flower.jpg"];
    composeViewController.delegate = self;
    [self presentViewController:composeViewController animated:YES completion:nil];
}

- (void)foursquareExampleButtonPressed
{
    REComposeViewController *composeViewController = [[REComposeViewController alloc] init];
    composeViewController.hasAttachment = YES;
    composeViewController.attachmentImage = [UIImage imageNamed:@"Flower.jpg"];

    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"foursquare-logo"]];
    titleImageView.frame = CGRectMake(0, 0, 110, 30);
    composeViewController.navigationItem.titleView = titleImageView;
    
    // UIApperance setup
    
    [composeViewController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg"] forBarMetrics:UIBarMetricsDefault];
    composeViewController.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:60/255.0 green:165/255.0 blue:194/255.0 alpha:1];
    composeViewController.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:29/255.0 green:118/255.0 blue:143/255.0 alpha:1];
    
    // Alternative use with REComposeViewControllerCompletionHandler
    composeViewController.completionHandler = ^(REComposeResult result) {
        if (result == REComposeResultCancelled) {
            NSLog(@"Cancelled");
        }
        
        if (result == REComposeResultPosted) {
            NSLog(@"Text = %@", composeViewController.text);
        }
    };
    
    [self presentViewController:composeViewController animated:YES completion:nil];
}

#pragma mark -
#pragma mark Orientation

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}

#pragma mark -
#pragma mark REComposeViewControllerDelegate

- (void)composeViewController:(REComposeViewController *)composeViewController didFinishWithResult:(REComposeResult)result
{
    if (result == REComposeResultCancelled) {
        NSLog(@"Cancelled");
    }
    
    if (result == REComposeResultPosted) {
        NSLog(@"Text = %@", composeViewController.text);
    }
}

@end
