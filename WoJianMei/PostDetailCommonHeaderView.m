//
//  PostDetailCommonHeaderView.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/10/13.
//
//

#import "PostDetailCommonHeaderView.h"

@implementation PostDetailCommonHeaderView
@synthesize delegate = _delegate;




-(void)dealloc{
    
    [_titleLabel release];
    [_contentView release];
    [_imageView release];
    [_nameLable release];
    [_genderLabel release];
    [_fitnessLabel release];
    [_postTimeLabel release];
    [_visitLabel release];
    [_joinLabel release];
    
    [super dealloc];
}


@end
