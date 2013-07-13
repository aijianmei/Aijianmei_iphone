//
//  SupplementViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 6/13/13.
//
//

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


@class AppDelegate;

@interface SupplementViewController : PPTableViewController<iCarouselDataSource, iCarouselDelegate,RKObjectLoaderDelegate>

{
    UIView                      *_myHeaderView;
    iCarousel                   *_carousel;
    SMPageControl               *_spacePageControl;
    UIScrollView *_buttonScrollView;
    AppDelegate *_appDelegate;
}

@property (nonatomic, retain) UIScrollView *buttonScrollView;
@property (nonatomic, retain) UIView *myHeaderView;
@property (nonatomic, retain) iCarousel *carousel;
@property (nonatomic, retain) UIButton *currentButton;
@property (nonatomic, retain) SMPageControl *spacePageControl;
@property (assign, nonatomic) NSInteger start;
@property (assign, nonatomic) NSInteger totalCount;

-(void)buttonClicked:(UIButton *)sender;
-(void)updateUserInterface;



@end
