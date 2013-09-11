//
//  WorkOutManagerViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/5/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"


@class WorkoutMainViewController;
@class WeightManagerViewController;
@class ChartViewController;
@class RankingViewController;


@interface WorkOutManagerViewController : PPViewController
{

    WorkoutMainViewController *_workoutMainViewController;
    WeightManagerViewController *_weightManagerViewController;
    
    ChartViewController *_chartViewController;
    RankingViewController *_rankingViewController;
    
    
}
@property (nonatomic,retain) WorkoutMainViewController *workoutMainViewController;
@property (nonatomic,retain) WeightManagerViewController *weightManagerViewController;
@property (nonatomic,retain) ChartViewController *chartViewController;
@property (nonatomic,retain) RankingViewController *rankingViewController;




- (IBAction)clickWeightManagerButton:(id)sender;

- (IBAction)clickWorkoutManagerButton:(id)sender;

- (IBAction)clickCheckoutWorkoutDatasButton:(id)sender;


- (IBAction)clickRankingButton:(id)sender;

- (IBAction)clickMoreButton:(id)sender;



@end
