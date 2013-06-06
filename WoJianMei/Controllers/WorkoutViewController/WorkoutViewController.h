//
//  WorkoutViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/29/12.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"


#import "SMPageControl.h"


///实现类似cover flow 效果。
#import "iCarousel.h"

////Download datas 
#import <RestKit/RestKit.h>



#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)



@interface WorkoutViewController : PPTableViewController<iCarouselDataSource, iCarouselDelegate,RKObjectLoaderDelegate>

{
    UIView                      *_myHeaderView;
    iCarousel                   *_carousel;
    SMPageControl               *_spacePageControl;
    
    UIScrollView *_buttonScrollView;



}


@property (nonatomic,retain)UIScrollView *buttonScrollView;

@property (nonatomic, retain)      UIView *myHeaderView;
@property (nonatomic, retain)     iCarousel *carousel;
@property (nonatomic, retain)  SMPageControl *spacePageControl;


@end
