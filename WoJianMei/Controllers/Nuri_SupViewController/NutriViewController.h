//
//  HealthFoodViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "iCarousel.h"
#import <RestKit/RestKit.h>


@class AppDelegate;

@interface NutriViewController: PPTableViewController<UITableViewDataSource,UITableViewDelegate,iCarouselDataSource, iCarouselDelegate, RKObjectLoaderDelegate>
{
    UIScrollView *_buttonScrollView;
    UIView *_myHeaderView;
    iCarousel *_carousel;
     
    AppDelegate *_appDelegate;
    
}


@property (nonatomic,retain) UIScrollView *buttonScrollView;
@property (nonatomic, retain) UIView *myHeaderView;
@property (nonatomic, retain) iCarousel *carousel;
@property (assign, nonatomic) NSInteger start;
@property (assign, nonatomic) NSInteger totalCount;
@property (nonatomic, retain) UIButton *currentButton;



- (void)initMoreUI;
- (void)updateUserInterface;
- (void)leftButtonClickHandler:(id)sender;
- (void)rightButtonClickHandler:(id)sender;

@end
