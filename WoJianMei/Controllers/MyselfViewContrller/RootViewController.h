//
//  RootViewController.h
//  REComposeViewControllerExample
//
//  Created by Roman Efimov on 10/19/12.
//  Copyright (c) 2012 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REComposeViewController.h"

#import "PPViewController.h"

@interface RootViewController : PPViewController <REComposeViewControllerDelegate,UIActionSheetDelegate>

{
    UIButton *_workoutNoteButton;
    UIButton *_workoutImageButton;

    
    UIScrollView *_scrollView;
}

@property (retain,nonatomic) UIButton *workoutNoteButton;
@property (retain,nonatomic) UIButton *workoutImageButton;

@property (retain,nonatomic) UIScrollView *scrollView;



@end
