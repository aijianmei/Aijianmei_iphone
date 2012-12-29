//
//  FirstViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayVideosViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <QuartzCore/QuartzCore.h>

@implementation PlayVideosViewController

@synthesize categoryName;
@synthesize categoryId;
@synthesize theMovie=_theMovie;

enum WORKOUT_TIME_TYPE {
   TOP_10,
   TOP_15,
   TOP_20,
   TOP_25,
   TOP_30
};




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    
    }

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
      [self hideTabBar];
        
//    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(backButtonClick)] autorelease];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
                                      
                                      initWithTitle:@"刷新"
                                      
                                      style:UIBarButtonItemStylePlain
                                      
                                      target:self
                                      
                                      action:nil];
    self.navigationItem.rightBarButtonItem = refreshButton;
    [refreshButton release];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     
                                     initWithTitle:@"返回"
                                     
                                     style:UIBarButtonItemStylePlain
                                     
                                     target:self
                                     
                                     action:@selector(backButtonClick)];
    
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    [cancelButton release];
}

-(void)backButtonClick{
    
    
    [self.theMovie stop];
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark -
#pragma mark Hide and Show TabBar Methods

- (void)hideTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    NSLog(@"tell me about the tabbar %@",[tabBar description]);
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds);
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                     }];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [self.theMovie pause];

}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    [self.theMovie pause];

}



#pragma mark -  PlayMovie Methods

- (void)video_play:(NSString*)filename
{
    NSString *s = [[NSBundle mainBundle] pathForResource:filename ofType:@"m4v"];
    NSURL *url = [NSURL fileURLWithPath:s];
    NSLog(@"Playing URL: %@",url);
    [self playMovieAtURL:url];
}

- (void)playMovieAtURL:(NSURL*)theURL
{
    
    
    MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:theURL];
    
    self.theMovie= moviePlayer;
    [moviePlayer release];
     //theMovie.scalingMode=MPMovieScalingModeAspectFill;
    //    theMovie.userCanShowTransportControls=NO;
    
    // Register for the playback finished notification.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myMovieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_theMovie];
    
    self.theMovie.controlStyle = MPMovieControlStyleEmbedded;
//    self.theMovie.scalingMode = MPMovieScalingModeFill;
    
    self.theMovie.view.frame = CGRectMake(0, 100, 320, 250);
    self.theMovie.view.backgroundColor = [UIColor clearColor];
    self.theMovie.shouldAutoplay =NO;
    self.theMovie.scalingMode = MPMovieScalingModeAspectFit;

    
    [self.view addSubview:_theMovie.view];
    
//    双击屏幕全屏
     [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFullScreen"];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didDetectDoubleTap:)];
    tapGesture.numberOfTapsRequired = 2;
    [self.theMovie.view addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    
    ////Animations 使得MovieView 往左右边缓慢移动进入页面
    CGRect Originframe = CGRectMake(300, 100, 320, 250);
    [self.theMovie.view setFrame:Originframe];
    [self.theMovie.view.layer  setOpacity:0.0 ];
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:1.0];
    Originframe.origin.x -= 300 ;
    [self.theMovie.view setFrame:Originframe];
    [self.theMovie.view.layer  setOpacity:1.0 ];
    [UIView commitAnimations];

    
    // Movie playback is asynchronous, so this method returns immediately.
    //set it play automatically
      [self.theMovie play];
    
}


- (void)didDetectDoubleTap:(UITapGestureRecognizer *)tap{
     [self.theMovie setFullscreen:YES];
}


// When the movie is done,release the controller.
- (void)myMovieFinishedCallback:(NSNotification*)aNotification
{
    
    MPMoviePlayerController* theMovie=[aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:theMovie];
    self.theMovie.fullscreen = NO;
    // Release the movie instance created in playMovieAtURL
//    [theMovie release];

}






- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||interfaceOrientation ==UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
}

@end
