//
//  WorkoutDetailViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/27/13.
//
//

#import "PPTableViewController.h"
#import <RestKit/RestKit.h>


@class Workout;

@protocol WorkoutDetailDelegate <NSObject>


-(void)loadWorkoutCatalogMenueWithWorkout :(Workout *)workout;

@end


@class Workout;


@interface WorkoutDetailViewController : PPTableViewController<RKObjectLoaderDelegate>
{
    NSArray *_workoutArray;
    id <WorkoutDetailDelegate> _delegate;
    
    Workout  *_choosenWorkout;

}
@property (nonatomic,retain) NSArray *workoutArray;
@property (nonatomic,assign) id <WorkoutDetailDelegate> delegate;


@end
