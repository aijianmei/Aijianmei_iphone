//
// REComposeSheetView.h
// REComposeViewController
//
// Copyright (c) 2012 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "DEComposeTextView.h"

#import "DEComposeBackgroundScrollView.h"


@protocol WorkoutDataComposeSheetViewDelegate;

@interface WorkoutDataComposeSheetView : UIView<UITextFieldDelegate> {
    UIImageView *_attachmentContainerView;
    
    NSMutableArray *_dataArray;
    
    UIButton *_addButton;
    UITextField *_moreTextField;
    
    
    
    
    int count;
}


///表格数据
@property (retain,nonatomic) NSMutableArray *dataArray;
@property (retain,nonatomic) UIButton *addButton;
@property (retain,nonatomic) UITextField *moreTextField;


@property (readonly, nonatomic) UIView *attachmentView;
@property (readonly, nonatomic) UIImageView *attachmentImageView;
@property (weak, readwrite, nonatomic) UIViewController <WorkoutDataComposeSheetViewDelegate> *delegate;
@property (readonly, nonatomic) UINavigationItem *navigationItem;
@property (readonly, nonatomic) UINavigationBar *navigationBar;
@property (readonly, nonatomic) UIView *textViewContainer;
@property (readonly, nonatomic) DEComposeTextView *textView;

////TomCallon's method
@property (readonly,nonatomic) DEComposeBackgroundScrollView * scrollView;

@end

@protocol WorkoutDataComposeSheetViewDelegate <NSObject>

- (void)cancelButtonPressed;
- (void)postButtonPressed;

@end