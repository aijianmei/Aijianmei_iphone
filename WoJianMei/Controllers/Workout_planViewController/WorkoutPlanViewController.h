//
//  WorkoutPlanViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 6/13/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "iCarousel.h"

@class SMPageControl;
@class SDSegmentedControl;

@interface WorkoutPlanViewController : PPTableViewController<iCarouselDataSource,iCarouselDelegate>

{

           UIView                      *_myHeaderView;
           iCarousel                   *_carousel;
           SMPageControl               *_spacePageControl;
           UIScrollView *_buttonScrollView;
           SDSegmentedControl *_segmentedController;


           int iid;


}


@property (nonatomic, retain) UIScrollView *buttonScrollView;
@property (nonatomic, retain) UIView *myHeaderView;
@property (nonatomic, retain) iCarousel *carousel;
@property (nonatomic, retain) UIButton *currentButton;
@property (nonatomic, retain) SMPageControl *spacePageControl;
@property (nonatomic, retain) SDSegmentedControl *segmentedController;


@end
