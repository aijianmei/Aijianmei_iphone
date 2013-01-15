//
//  ViewController.m
//  NumberPicker
//
//  Created by Jon Manning on 6/06/12.
//  Copyright (c) 2012 Secret Lab. All rights reserved.
//

#import "NumberPickViewController.h"
#import "SLNumberPickerView.h"

@interface NumberPickViewController ()

@end

@implementation NumberPickViewController
@synthesize valueLabel;



-(void)dealloc{
    

    [valueLabel release];
    [super dealloc];
 

}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    
    SLNumberPickerView *numberView =  [SLNumberPickerView numberPickerView];
    [numberView setFrame:CGRectMake(90, 50, numberView.bounds.size.width, numberView.bounds.size.height)];
    [numberView setDelegate:self];
    [self.view addSubview:numberView];
    
    
    
    valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 230, 150, 47)];
    [valueLabel setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:valueLabel];


}

- (void)numberPickerViewDidChangeValue:(SLNumberPickerView *)picker {
    NSString* valueString = [NSString stringWithFormat:@"身高: %i cm", picker.value];
    valueLabel.text = valueString;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
