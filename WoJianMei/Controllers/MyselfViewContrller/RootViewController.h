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

@interface RootViewController : PPViewController <REComposeViewControllerDelegate,WorkoutDataComposeViewControllerDelegate,UIActionSheetDelegate>

{
    UIButton *_workoutNoteButton;
    UIButton *_workoutImageButton;
    UIButton *_workoutDatasButton;


    
    UIScrollView *_scrollView;
}

@property (retain,nonatomic) UIButton *workoutNoteButton;
@property (retain,nonatomic) UIButton *workoutImageButton;
@property (retain,nonatomic) UIButton *workoutDatasButton;
@property (retain,nonatomic) UIScrollView *scrollView;



@end
