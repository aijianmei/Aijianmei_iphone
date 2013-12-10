//
//  BasicTopicViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/3/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "iCarousel.h"

@class PBBBSPost;
@interface BBSViewController : PPTableViewController<iCarouselDelegate,iCarouselDataSource>
{
    iCarousel    *_carousel;
    
    int iid;
}

@property (nonatomic, retain) iCarousel *carousel;


@end
