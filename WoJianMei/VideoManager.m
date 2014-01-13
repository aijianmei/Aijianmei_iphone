//
//  VideoManager.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/11/14.
//
//

#import "VideoManager.h"

@implementation VideoManager
@synthesize videoPath =_videoPath;

static VideoManager* _defaultManager;

+ (VideoManager*)defaultManager{
    if (_defaultManager == nil){
        _defaultManager = [[VideoManager alloc] init];
    }
    return _defaultManager;
}

-(void)dealloc{
    [_videoPath release];
    [super dealloc];
}




@end
