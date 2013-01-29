//
//  ComposeViewCellInfo.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/21/13.
//
//

#import "ComposeViewCellInfo.h"

@implementation ComposeViewCellInfo
@synthesize avatarImageName   =_avatarImageName;
@synthesize name              =_name;
@synthesize connectButtonName =_connectButtonName;


-(void)dealloc{
    
    [_avatarImageName     release];
    [_name                release];
    [_connectButtonName   release];

    [super dealloc];
    
}

@end
