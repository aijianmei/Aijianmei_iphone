//
//  FitnessInfoViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "PPViewController.h"
@class HomeViewController;
@class WorkoutPlanViewController;
@class WorkoutViewController;
@class SupplementViewController;
@class NutriViewController;
@class LifeStytleViewController;

@interface FitnessInfoViewController : PPViewController
{
    
    HomeViewController            *_homeViewController;
    WorkoutPlanViewController     *_workoutPlanViewController;
    WorkoutViewController         *_workoutViewController;
    SupplementViewController      *_supplementViewController;
    NutriViewController           *_nutriViewController;
    LifeStytleViewController      *_lifeStytleViewController;


}
@property(nonatomic, retain) HomeViewController               *homeViewController;
@property(nonatomic, retain) WorkoutPlanViewController        *workoutPlanViewController;
@property(nonatomic, retain) WorkoutViewController            *workoutViewController;
@property(nonatomic, retain) SupplementViewController         *supplementViewController;
@property(nonatomic, retain) NutriViewController              *nutriViewController;
@property(nonatomic, retain) LifeStytleViewController         *lifeStytleViewController;

- (IBAction)clickFitnessMenueButton:(UIButton *)sender;




@end
