//
//  ViewController.h
//  NumberPicker
//
//  Created by Jon Manning on 6/06/12.
//  Copyright (c) 2012 Secret Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLNumberPickerView.h"

@interface NumberPickViewController : UIViewController <SLNumberPickerViewDelegate>

@property (retain, nonatomic)  UILabel *valueLabel;

@end
