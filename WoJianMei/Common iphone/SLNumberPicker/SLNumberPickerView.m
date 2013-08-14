//
//  SBLNumberPickerView.m
//  A themed number picker.
//
//  Created by Jon Manning on 21/04/12.
//  Copyright (c) 2012 Secret Lab. All rights reserved.
//

#import "SLNumberPickerView.h"


@interface SLNumberPickerView () {
    
    NSInteger _number3Value;
    SLNumberPickerView* _internalPickerView;
    
    BOOL _isStandIn;
    

}

@end

@implementation SLNumberPickerView

// *** v CHANGE THESE METHODS FOR CUSTOM APPEARANCE! v ***

// What font should we use?
+ (UIFont*)numberFont {
    return [UIFont fontWithName:@"Palatino" size:20];
}

// What color should the text be?
+ (UIColor*)numberColor {
    return [UIColor blackColor];
}

// Which tiled image should we use for each column?
+ (UIImage*)backgroundImage {
    return [UIImage imageNamed:@"SLNumberPickerTicks.png"];
}

// *** ^ CHANGE THESE METHODS FOR CUSTOM APPEARANCE! ^ ***


@synthesize number3 =_number3;
@synthesize delegate = _delegate;

// Adapted from a technique from Yang Meyer:
// https://blog.compeople.eu/apps/?p=142
- (id) awakeAfterUsingCoder:(NSCoder*)aDecoder {
    
    // We are a stand-in view if we have zero sub-views.
    BOOL wasPlaceholder = ([[self subviews] count] == 0);
    
    if (wasPlaceholder) {
        
        // Load the real view, and add it as a subview of ourself. Also mark ourself
        // as a stand-in view, so that we know to forward hit tests and requests for properties.
        _internalPickerView = [SLNumberPickerView numberPickerView];
        _internalPickerView.frame = self.bounds;
        _isStandIn = YES;
        [self addSubview:_internalPickerView];
        
        // Set the background to clear, so that at design-time we can use an opaque color to help identify this custom view.
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

// Load the nib and return the newly-created picker view.
+ (SLNumberPickerView*)numberPickerView {
    UINib* nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    NSArray* objects = [nib instantiateWithOwner:self options:nil];
    return [objects objectAtIndex:0];
}


// Given a scroll view, fill it with labels from 0 to 9 - one label per "page".
// Also add the tick marks as a background.
- (void)prepareScrollView:(UIScrollView*)scrollView {
    
    
//#define WeightNumberFrom 25
//#define WeightNumberEnd 205
//    
//#define HeightNumberFrom 60
//#define HeightNumberEnd 230
//    
//#define AgeNumberFrom   1930
//#define AgeNumberEnd    2013
//    
//    
//       numberRange =AgeNumberEnd - AgeNumberFrom;
//
//    if (_isAgeSceen) {
//        numberRange =AgeNumberEnd - AgeNumberFrom;
//
//    } else if(_isHeightSceen){
//        numberRange =HeightNumberEnd - HeightNumberFrom ;
//    }
//    else if(_isWeightSceen){
//        
//        numberRange =WeightNumberEnd - WeightNumberFrom;
//    }
    
    
    numberRange = 230;

    // Add 10 labels - 0 to 9.
    for (int i = 0; i < numberRange; i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:scrollView.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [SLNumberPickerView numberColor];
        label.font = [SLNumberPickerView numberFont];
        
        label.textAlignment = UITextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"%i", i];
        
        CGRect frame = label.frame;
        frame.origin.y = frame.size.height * i;
        frame.size.width -= 11; // allow for side ticks
        label.frame = frame;
        [scrollView addSubview:label];
        scrollView.delegate = self;
    }
    
    // This scroll view is 10 pages tall, is paged, and does not clip to bounds.
    // This is important, since we want to be able to see the numbers above and below the
    // currently selected one.
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width, scrollView.bounds.size.height * numberRange);
    scrollView.pagingEnabled = YES;
    scrollView.clipsToBounds = NO;
    
    scrollView.showsVerticalScrollIndicator = NO;
    
    // Add a view behind all of the numbers that is extremely tall and uses a tiled background image. 
    UIView* backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
//    CGRect frame = (CGRect){CGPointMake(0, -scrollView.bounds.size.height*10), CGSizeMake(scrollView.bounds.size.width, scrollView.bounds.size.height* 200)};
    CGRect frame = (CGRect){CGPointMake(0, 0), CGSizeMake(scrollView.bounds.size.width, scrollView.bounds.size.height* numberRange)};
    backgroundView.frame = frame;
    [scrollView insertSubview:backgroundView atIndex:0];
    
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:[SLNumberPickerView backgroundImage]];
}

// When scroll views finish moving, we can check their value.
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.y / scrollView.bounds.size.height;
    
    if (scrollView == self.number3)
        _number3Value = page;
    
    [self.delegate numberPickerViewDidChangeValue:self];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.y / scrollView.bounds.size.height;
    if (scrollView == self.number3)
        _number3Value = page;
    
    [self.delegate numberPickerViewDidChangeValue:self];
    
    NSLog(@"%@",[scrollView description]);

}


// On awakening, set up the columns if we're not a stand-in.
- (void)awakeFromNib {
    
    if (_isStandIn)
        return;
       [self prepareScrollView:_number3];
}

// Figure out the value based on the current number values.
// If we're a stand-in, forward the request to the "real" number picker.
- (NSInteger)value {
    
    if (_isStandIn) {
        return [_internalPickerView value];
    }
    
    return _number3Value;
}

// We want to be able to tap and drag any part of a column to move it, but only the 
// center number will handle touches by default. We fix this by overriding
// hitTest:withEvent: to treat any touch in the general area of a column as belonging to
// that column's scroll view.

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (_isStandIn) {
        return [_internalPickerView hitTest:point withEvent:event];
    }
        
    
    // because all of the views are layed out in column fashion, the x coord of the touch corresponds to the view
    CGFloat x = point.x;
    
    if (x >= CGRectGetMinX(self.number3.frame) && x <= CGRectGetMaxX(self.number3.frame))
        return self.number3;
    
    if (CGRectContainsPoint(self.frame, point))
        return self;
    
    
    return nil;
}

- (void)setDelegate:(id<SLNumberPickerViewDelegate>)delegate {
    if (_isStandIn)
        [_internalPickerView setDelegate:delegate];
    else
        _delegate = delegate;
}

- (id<SLNumberPickerViewDelegate>)delegate {
    if (_isStandIn)
        return [_internalPickerView delegate];
    else
        return _delegate;
}


-(void)scrollRectToVisible:(CGRect)frame animated :(BOOL)animated
{
//    
//    [self awakeFromNib];
//    [self prepareScrollView:_internalPickerView.number3];
    [_internalPickerView.number3 scrollRectToVisible:frame
                                        animated:animated];
    
    
}



@end
