//
//  ColorManager.m
//  WoJianMei
//
//  Created by Tom Callon  on 6/25/13.
//
//

#import "ColorManager.h"
#import "DeviceDetection.h"


static ColorManager *_defaultManager = nil;

@implementation ColorManager



+ (id)defaultManager
{
    if (_defaultManager == nil){
        _defaultManager = [[ColorManager alloc] init];
    }
    
    return _defaultManager;
}

+ (UIColor *)leftSideNaviFontColor{
    
    //#555555
    UIColor *color= [UIColor colorWithRed:255.0/255.0
                                    green:255.0/255.0
                                     blue:255.0/255.0
                                    alpha:1];
    return color;
    
}
+ (UIColor *)dddddddadfasdfasdf{
    
    //#555555
    UIColor *color= [UIColor colorWithRed:55/255.0
                                    green:55/255.0
                                     blue:55/255.0
                                    alpha:1];
    return color;
    
}




@end
