//
//  YFInputBar.m
//  test
//
//  Created by 杨峰 on 13-11-10.
//  Copyright (c) 2013年 杨峰. All rights reserved.
//

#import "YFInputBar.h"
#import "AppDelegate.h"
@implementation YFInputBar


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        
        
        
        self.frame = CGRectMake(0, CGRectGetMinY(frame), UIScreen.mainScreen.bounds.size.width, CGRectGetHeight(frame));
        
        self.textField.tag = 10000;
        self.sendBtn.tag = 10001;
        self.retButton.tag = 10002;

        
        //注册键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _originalFrame = frame;
}
//_originalFrame的set方法  因为会调用setFrame  所以就不在此做赋值；
-(void)setOriginalFrame:(CGRect)originalFrame
{
    self.frame = CGRectMake(0, CGRectGetMinY(originalFrame), UIScreen.mainScreen.bounds.size.width, CGRectGetHeight(originalFrame));
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [super dealloc];
}

#pragma mark get方法实例化输入框／btn
-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(60,10,200,24)];
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(60,10,UIScreen.mainScreen.bounds.size.width - 120,24)];

        _textField.backgroundColor = [UIColor whiteColor];
        [self addSubview:_textField];
    }
    return _textField;
}
-(UIButton *)sendBtn
{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
//        [_sendBtn setBackgroundColor:[UIColor whiteColor]];
        
        
        [_sendBtn setFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width - 50, 10, 40, 24)];
        [_sendBtn addTarget:self action:@selector(sendBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendBtn];
    }
    return _sendBtn;
}



#pragma mark selfDelegate method

-(void)sendBtnPress:(UIButton*)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(inputBar:sendBtnPress:withInputString:)]) {
        [self.delegate inputBar:self sendBtnPress:sender withInputString:self.textField.text];
    }
    if (self.clearInputWhenSend) {
        self.textField.text = @"";
    }
    if (self.resignFirstResponderWhenSend) {
        [self resignFirstResponder];
    }
}


-(UIButton *)retButton
{
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnBtn setTitle:@"返回" forState:UIControlStateNormal];
//        [_returnBtn setBackgroundColor:[UIColor whiteColor]];
        [_returnBtn setFrame:CGRectMake(10, 10, 40, 24)];
        [_returnBtn addTarget:self action:@selector(retBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_returnBtn];
    }
    return _returnBtn;
}
#pragma mark selfDelegate method
-(void)retBtnPress:(UIButton*)sender
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(inputBar:retBtnPress:)]) {
        [self.delegate inputBar:self retBtnPress:sender];
    }
    if (self.clearInputWhenSend) {
        self.textField.text = @"";
    }
    if (self.resignFirstResponderWhenSend) {
        [self resignFirstResponder];
    }
}


#pragma mark keyboardNotification

- (void)keyboardWillShow:(NSNotification*)notification{
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"%f-%f-%f-%f",_keyboardRect.origin.y,_keyboardRect.size.height,[self getHeighOfWindow]-CGRectGetMaxY(self.frame),CGRectGetMinY(self.frame));
    
    //如果self在键盘之下 才做偏移
    if ([self convertYToWindow:CGRectGetMaxY(self.originalFrame)]>=_keyboardRect.origin.y)
    {
        //没有偏移 就说明键盘没出来，使用动画
        if (self.frame.origin.y== self.originalFrame.origin.y) {
            
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame));
                             } completion:nil];
        }
        else
        {
            self.transform = CGAffineTransformMakeTranslation(0, -_keyboardRect.size.height+[self getHeighOfWindow]-CGRectGetMaxY(self.originalFrame));
        }
        
    }
    else
    {
        
    }
    
}

- (void)keyboardWillHide:(NSNotification*)notification{
    

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.transform = CGAffineTransformMakeTranslation(0, 0);
                     } completion:nil];
}
#pragma  mark ConvertPoint
//将坐标点y 在window和superview转化  方便和键盘的坐标比对
-(float)convertYFromWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [appDelegate.window convertPoint:CGPointMake(0, Y) toView:self.superview];
    return o.y;
    
}
-(float)convertYToWindow:(float)Y
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    CGPoint o = [self.superview convertPoint:CGPointMake(0, Y) toView:appDelegate.window];
    return o.y;
    
}
-(float)getHeighOfWindow
{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    return appDelegate.window.frame.size.height;
}



-(BOOL)resignFirstResponder
{
    [self.textField resignFirstResponder];
    return [super resignFirstResponder];
}
@end