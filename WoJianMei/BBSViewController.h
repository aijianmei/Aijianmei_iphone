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
#import "PostService.h"

@class PBBBSPost;
@interface BBSViewController : PPTableViewController<iCarouselDelegate,iCarouselDataSource,PostStatusServiceDelegate>
{
    iCarousel    *_carousel;
    
    int iid;
    
    BOOL _reloading;
    BOOL  shouldLoad;
    
    NSInteger _start;


}

@property (nonatomic, retain) iCarousel *carousel;


@end
