//
//  HealthFoodViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
///实现类似cover flow 效果。
#import "iCarousel.h"



@interface Nutri_SupViewController: PPTableViewController<UITableViewDataSource,UITableViewDelegate,iCarouselDataSource, iCarouselDelegate>


{
    UIScrollView *_buttonScrollView;
    
    UIView                      *_myHeaderView;
    iCarousel                   *_carousel;


}
@property (nonatomic,retain) IBOutlet UIScrollView *buttonScrollView;
@property (nonatomic, retain)  UIView *myHeaderView;
@property (nonatomic, retain)  iCarousel *carousel;




@end
