//
//  TopicPickerCommonView.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/21/14.
//
//

#import "TopicPickerCommonView.h"
@implementation TopicPickerCommonView
@synthesize delegate = _delegate;
@synthesize statusImageView =_statusImageView;



-(void)dealloc{
    
    [_statusImageView release];[self setStatusImageView:nil];
    [super dealloc];
}
@end
