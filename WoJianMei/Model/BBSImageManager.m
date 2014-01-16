//
//  BBSImageManager.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/15/14.
//
//

#import "BBSImageManager.h"

@implementation BBSImageManager

static BBSImageManager* _staticBBSImageManager;


+ (id)defaultManager
{
    if (_staticBBSImageManager == nil) {
        _staticBBSImageManager = [[BBSImageManager alloc] init];
    }
    return _staticBBSImageManager;
}

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

- (CGSize)image:(UIImage *)image sizeWithConstHeight:(CGFloat)constHeight
       maxWidth:(CGFloat)maxWidth

{
    if (image) {
        CGSize imageSize = image.size;
        CGFloat h = imageSize.height / constHeight;
        CGFloat width = imageSize.width / h;
        if (width > maxWidth) {
            width = maxWidth;
        }
        return CGSizeMake(width, constHeight);
    }
    return CGSizeZero;
}

@end
