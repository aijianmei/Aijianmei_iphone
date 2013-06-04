//
//  RootViewController.h
//  REComposeViewControllerExample
//
//  Created by Roman Efimov on 10/19/12.
//  Copyright (c) 2012 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REComposeViewController.h"
#import "WorkoutDataComposeViewController.h"
#import "PPViewController.h"
//#import "WorkOutProcessViewController.h"



@class WorkOutInfo;

@interface WorkOutDataViewController : PPViewController <REComposeViewControllerDelegate,WorkoutDataComposeViewControllerDelegate,UIActionSheetDelegate>

{
    UIButton *_workoutNoteButton;
    UIButton *_workoutImageButton;
    UIButton *_workoutDatasButton;
    
    UIScrollView *_scrollView;
    
    
    WorkOutInfo *_workOutInfo;
    
   
    
    
}

//@property (retain,nonatomic) WorkOutProcessViewController *superViewController;
@property (retain,nonatomic) UIButton *workoutNoteButton;
@property (retain,nonatomic) UIButton *workoutImageButton;
@property (retain,nonatomic) UIButton *workoutDatasButton;
@property (retain,nonatomic) UIScrollView *scrollView;



@property (retain,nonatomic) WorkOutInfo *workOutInfo;



@end
