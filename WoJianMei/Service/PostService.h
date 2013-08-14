//
//  PostService.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/6/13.
//
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "PostStatus.h"


@interface PostService : NSObject
{
    PostStatus *_postStatus;
    
}
@property (nonatomic,retain) PostStatus *postStatus;

+(PostService*)sharedService;

//分享图片内容
-(void)postStatusWithUid:(NSString *)uid
                   image:(UIImage *)image
                 content:(NSString*)content
                delegate:(id<RKObjectLoaderDelegate>)delegate;
//获取分享
-(void)loadStatusWithUid:(int)uid
               targetUid:(int)targetUid
                gymGroup:(int)gymGroup
                   start:(int)start
                  offSet:(int)offSet
                delegate:(id<RKObjectLoaderDelegate>)delegate;


//点击喜欢
-(void)postLikeWithUid:(int)uid
              StatusId:(int)StatusId
              delegate:(id<RKObjectLoaderDelegate>)delegate;



















@end
