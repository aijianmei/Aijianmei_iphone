//
//  WorkoutMainViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/13/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "WorkoutDetailViewController.h"
#import <restkit/restkit.h>
#import "UserCatalog.h"


@class NumberDataViewController;
@class SDSegmentedControl;


@interface WorkoutMainViewController : PPViewController<WorkoutDetailDelegate,RKObjectLoaderDelegate>

{

    NumberDataViewController *_numberDataViewController;
    SDSegmentedControl *_segmentedController;
    NSMutableArray *  _buttonTitleArray;
    
    NSArray *_userCatalogMenue;

    Catalog *selectedCatalog;
    
    
    UIButton *_dataButton;
    UIButton *_imageButton;
    UIButton *_noteButton;

    
}



@property (nonatomic,retain)  NumberDataViewController *numberDataViewController;
@property (nonatomic, retain) SDSegmentedControl *segmentedController;
@property (nonatomic,retain)  NSMutableArray *buttonTitleArray;
@property (nonatomic,retain)  NSArray *userCatalogMenue;
;

@property (nonatomic,retain) IBOutlet UIButton *dataButton;
@property (nonatomic,retain) IBOutlet UIButton *imageButton;
@property (nonatomic,retain) IBOutlet UIButton *noteButton;




-(IBAction)clickWorkoutType:(id)sender;




@end
