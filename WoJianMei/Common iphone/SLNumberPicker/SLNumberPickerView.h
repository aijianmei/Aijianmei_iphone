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

{
    UIScrollView *_number3;
    
    int numberRange;
    
    
    BOOL isWeightSceen;
    BOOL isHeightSceen;
    BOOL isAgeSceen;


    
}

+ (SLNumberPickerView*)numberPickerView;

@property (strong, nonatomic) IBOutlet UIScrollView *number3;

@property (readonly) NSInteger value;

@property (nonatomic, weak) IBOutlet id <SLNumberPickerViewDelegate> delegate;
@property (nonatomic,assign) BOOL isWeightSceen;
@property (nonatomic,assign) BOOL isHeightSceen;
@property (nonatomic,assign) BOOL isAgeSceen;




-(void)scrollRectToVisible:(CGRect)frame animated :(BOOL)animated;

- (void)awakeFromNib;



@end
