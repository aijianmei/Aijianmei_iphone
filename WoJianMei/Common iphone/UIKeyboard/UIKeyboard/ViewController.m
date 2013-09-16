//
//  ViewController.m
//
//
//  Created by  YFengchen on 13-1-4.
//  Copyright 2013 __zhongyan__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
}

-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	MCRelease(keyBoardController);
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - UIKeyboardViewController delegate methods

- (void)alttextFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%@", textField.text);
}

- (void)alttextViewDidEndEditing:(UITextView *)textView {
    NSLog(@"%@", textView.text);
}

@end
