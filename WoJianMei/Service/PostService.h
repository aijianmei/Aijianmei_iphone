//
//  PostService.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/6/13.
//
//

#import <Foundation/Foundation.h>
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
//                delegate:(id<RKObjectLoaderDelegate>)delegate
;
//获取分享
-(void)loadStatusWithUid:(int)uid
               targetUid:(int)targetUid
                gymGroup:(int)gymGroup
                   start:(int)start
                  offSet:(int)offSet
//                delegate:(id<RKObjectLoaderDelegate>)delegate
;



//点击喜欢
-(void)postLikeWithUid:(int)uid
              StatusId:(int)StatusId
//              delegate:(id<RKObjectLoaderDelegate>)delegate
;

//点击评论
/*
http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_sendcomment&uid=498&id=111&commentcontent=要好好睡才行&channeltype=1
channeltype 1表示文章 2表示视频
*/
-(void)postCommentWithUid:(NSString*)uid
          targetContentId:(NSString*)targetContentId
                  comment:(NSString*)comment
              channelType:(NSString*)channleType
//                 delegate:(id<RKObjectLoaderDelegate>)delegate
;



















@end
