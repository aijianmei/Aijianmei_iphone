//
//  HealthFoodViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"

@interface Nutri_SupViewController: PPTableViewController<UITableViewDataSource,UITableViewDelegate>


{
    UIScrollView *_buttonScrollView;

}
@property (nonatomic,retain) IBOutlet UIScrollView *buttonScrollView;


@end
