//
//  AJM_CommonViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 6/13/13.
//
//

#import "PPTableViewController.h"
#import "iCarousel.h"


@class AppDelegate;
@class SMPageControl;
@class SDSegmentedControl;



@interface AJM_CommonViewController : PPTableViewController<iCarouselDelegate,iCarouselDataSource>
{

    UIView                      *_myHeaderView;
    iCarousel                   *_carousel;
    int iCarouselIndex;
    SMPageControl               *_spacePageControl;
    UIScrollView                *_buttonScrollView;
    AppDelegate                 *_appDelegate;
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


- (void)initMoreUI;
- (void)leftButtonClickHandler:(id)sender;
- (void)rightButtonClickHandler:(id)sender;

#pragma mark--
#pragma mark-- SDSegmentedControl Click Method
-(void)buttonClicked:(SDSegmentedControl *)sender;



@end
