//
// REComposeSheetView.m
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

#import "REComposeSheetView.h"
#import <QuartzCore/QuartzCore.h>

@implementation REComposeSheetView



////Tom Callons methods
-(void)addButtons{
    
    int positionX = 50;
    int positionY = 10;
    
    int x;
    
    for (x=1; x <=7; x++)
    
    {
        
    UIButton *numberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    numberButton.backgroundColor = [UIColor redColor];
    numberButton.frame = CGRectMake(positionX * x -40, positionY -10, 30, 30);
        
        
    NSString *number = [NSString stringWithFormat:@"%i",x] ;
    [numberButton setTitle:number forState:UIControlStateNormal];

    
    UITextField *textField1 = [[UITextField alloc]initWithFrame:CGRectMake(positionX * x -40, positionY  + 20, 40, 30)];
    [textField1 setBackground:[UIImage imageNamed:@"data_button"]];
    
    UITextField *textField2 = [[UITextField alloc]initWithFrame:CGRectMake(positionX * x -40, positionY + 50, 40, 30)];
    [textField2 setBackground:[UIImage imageNamed:@"data_button"]];
    
    UITextField *textField3 = [[UITextField alloc]initWithFrame:CGRectMake(positionX * x -40 , positionY + 80, 40, 30)];
    [textField3 setBackground:[UIImage imageNamed:@"data_button"]];
   
        [_scrollView addSubview:numberButton];
        [_scrollView addSubview:textField1];
        [_scrollView addSubview:textField2];
        [_scrollView addSubview:textField3];
           
   }
    
        
    

    

}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 44)];
        _navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth
        | UIViewAutoresizingFlexibleBottomMargin
        | UIViewAutoresizingFlexibleRightMargin;
        
        _navigationItem = [[UINavigationItem alloc] initWithTitle:@""];
        _navigationBar.items = @[_navigationItem];
        
        UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"Cancel") style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonPressed)];
        _navigationItem.leftBarButtonItem = cancelButtonItem;
        
        UIBarButtonItem *postButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Post", @"Post") style:UIBarButtonItemStyleBordered target:self action:@selector(postButtonPressed)];
        _navigationItem.rightBarButtonItem = postButtonItem;
        
        
        _textViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 44, frame.size.width, frame.size.height - 44)];
        
        /////Overwrite the textView
        _textViewContainer.backgroundColor = [UIColor greenColor];
        _textViewContainer.clipsToBounds = YES;
        _textViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        
        
        ///addebutton
        
        
        
        UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(120, 2, 50, 30);
        [addButton setTitle:@"添加" forState:UIControlStateNormal];
        [addButton setImage:[UIImage imageNamed:@"add_button.png"] forState:UIControlStateNormal];
        
        [addButton addTarget:self action:@selector(addButtons) forControlEvents:UIControlEventTouchUpInside];
        
        

        UIButton * setsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        setsButton.frame = CGRectMake(5, 10, 50, 30);
        [setsButton setTitle:@"组数" forState:UIControlStateNormal];
        
        
    
        UIButton *weightButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        weightButton.frame = CGRectMake(5, 50, 50, 30);
        [weightButton setTitle:@"强度" forState:UIControlStateNormal];
        
        UIButton *numbersButton =  [UIButton buttonWithType:UIButtonTypeCustom];
         [numbersButton setFrame: CGRectMake(5, 90, 50, 30)];
        [numbersButton setTitle:@"数量" forState:UIControlStateNormal];

        UIButton *timeButton =  [UIButton buttonWithType:UIButtonTypeCustom];
         [timeButton setFrame: CGRectMake(5,130,50,30)];
         [timeButton setTitle:@"时间" forState:UIControlStateNormal];
        
        
        
        
        
        
        [_textViewContainer addSubview:addButton];
        [_textViewContainer addSubview:setsButton];
        [_textViewContainer addSubview:weightButton];
        [_textViewContainer addSubview:numbersButton];
        [_textViewContainer addSubview:timeButton];
        
        
        
         
        
        
        
        
        
        
        
        
        /////Overwirte the textView's location
//        _textView = [[DEComposeTextView alloc] initWithFrame:CGRectMake(40, 40, frame.size.width, frame.size.height - 47)];
//        _textView.backgroundColor = [UIColor whiteColor];
//        _textView.font = [UIFont systemFontOfSize:21];
//        _textView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
//        _textView.bounces = YES;
        
    
        ////Overwrite the UIScollView 
        _scrollView = [[DEComposeBackgroundScrollView alloc] initWithFrame:CGRectMake(40, 20, frame.size.width, frame.size.height - 47)];
        _scrollView.backgroundColor = [UIColor whiteColor];
//        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
//        _scrollView.bounces = YES;
        
        
        [_scrollView setShowsHorizontalScrollIndicator:YES];
        [_scrollView setContentSize:CGSizeMake(1000, 100)];
        
        [_textViewContainer addSubview:_scrollView];
        
        
        
        
        [self addSubview:_textViewContainer];
        
        
        
        
        
        _attachmentView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - 84, 54, 84, 79)];
        [self addSubview:_attachmentView];
        
        _attachmentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6, 2, 72, 72)];
        _attachmentImageView.layer.cornerRadius = 3.0f;
        _attachmentImageView.layer.masksToBounds = YES;
        [_attachmentView addSubview:_attachmentImageView];
        
        _attachmentContainerView = [[UIImageView alloc] initWithFrame:_attachmentView.bounds];
        _attachmentContainerView.image = [UIImage imageNamed:@"REComposeViewController.bundle/AttachmentFrame"];
        [_attachmentView addSubview:_attachmentContainerView];
        _attachmentView.hidden = YES;
    
        [self addSubview:_navigationBar];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_delegate) {
        _navigationItem.title = _delegate.title;
    }
}

- (void)cancelButtonPressed
{
    if ([_delegate respondsToSelector:@selector(cancelButtonPressed)])
        [_delegate cancelButtonPressed];
}

- (void)postButtonPressed
{
    if ([_delegate respondsToSelector:@selector(postButtonPressed)])
        [_delegate postButtonPressed];
}

@end
