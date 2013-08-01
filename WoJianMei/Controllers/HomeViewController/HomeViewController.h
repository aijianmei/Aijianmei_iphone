//
//  HomeViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 6/26/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "SMPageControl.h"
#import "iCarousel.h"
#import <RestKit/RestKit.h>
#import "LoginViewController.h"
#import "SignUpViewController.h"


@class AppDelegate;
@class SDSegmentedControl;


@interface HomeViewController : PPTableViewController<iCarouselDataSource, iCarouselDelegate,RKObjectLoaderDelegate,LoginViewDelegate,SignUpViewControllerDelegate>

{
    UIView                      *_myHeaderView;
    iCarousel                   *_carousel;
    SMPageControl               *_spacePageControl;
    UIScrollView *_buttonScrollView;
    AppDelegate *_appDelegate;
    
    
    SDSegmentedControl *_segmentedController;
    

    
}

@property (nonatomic, retain) UIScrollView *buttonScrollView;
@property (nonatomic, retain) UIView *myHeaderView;
@property (nonatomic, retain) iCarousel *carousel;
@property (nonatomic, retain) UIButton *currentButton;
@property (nonatomic, retain) SMPageControl *spacePageControl;
@property (nonatomic, retain) SDSegmentedControl *segmentedController;
@property (assign, nonatomic) NSInteger start;
@property (assign, nonatomic) NSInteger totalCount;
@property (nonatomic,retain) LoginViewController *loginViewController;




-(void)buttonClicked:(SDSegmentedControl *)sender;
-(void)updateUserInterface;
-(void)pushToMyselfViewController;




@end
