//
//  SBLNumberPickerView.h
//  A themed number picker.
//
//  Created by Jon Manning on 21/04/12.
//  Copyright (c) 2012 Secret Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLNumberPickerView;

@protocol SLNumberPickerViewDelegate <NSObject>

- (void) numberPickerViewDidChangeValue:(SLNumberPickerView*)picker;

@end

@interface SLNumberPickerView : UIView <UIScrollViewDelegate>

+ (SLNumberPickerView*)numberPickerView;

@property (retain, nonatomic) IBOutlet UIScrollView *number1;
@property (retain, nonatomic) IBOutlet UIScrollView *number2;
@property (retain, nonatomic) IBOutlet UIScrollView *number3;

@property (readonly) NSInteger value;

@property (nonatomic, assign) id <SLNumberPickerViewDelegate> delegate;

@end
