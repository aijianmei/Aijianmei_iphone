//
//  VideoManager.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/11/14.
//
//

#import <Foundation/Foundation.h>

@interface VideoManager : NSObject
{
    NSString *_videoPath;

}
@property (nonatomic,retain) NSString *videoPath;


+ (VideoManager*)defaultManager;

@end
