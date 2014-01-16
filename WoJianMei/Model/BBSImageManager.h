//
//  BBSImageManager.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/15/14.
//
//

#import <Foundation/Foundation.h>

@interface BBSImageManager : NSObject

+ (id)defaultManager;
-(CGSize)image:(UIImage *)image sizeWithConstHeight:(CGFloat)height maxWidth:(CGFloat)maxWidth;

@end
