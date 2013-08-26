//
//  WorkoutMainViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/13/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"

@class NumberDataViewController;
@class SDSegmentedControl;


@interface WorkoutMainViewController : PPViewController

{

    NumberDataViewController *_numberDataViewController;
    SDSegmentedControl *_segmentedController;

}

@property (nonatomic,retain) NumberDataViewController *numberDataViewController;
@property (nonatomic, retain) SDSegmentedControl *segmentedController;





@end
