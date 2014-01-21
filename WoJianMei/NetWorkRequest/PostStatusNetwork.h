//
//  PostStatusNetwork.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/21/14.
//
//

#import <Foundation/Foundation.h>
#import "PPNetworkRequest.h"


@class CommonNetworkOutput;

@interface PostStatusNetwork : NSObject





///load Single Image Statuse
/*
 @method 加载单张图片的方法
 
 @parameter :
 
     @baseURL      基本路径
     @Id           用户uid
     @targetId     要获取用户的UID
     @image        图片
     @gymGroup     所属于分组
     @start        开始组数
     @offSet       每组数量


*/
+ (CommonNetworkOutput *)loadStatusesById:(NSString*)baseURL
                                       Id:(NSString*)Id
                                 targetId:(NSString*)targetId
                                 gymGroup:(NSString*)gymGroup
                                    start:(NSString*)start
                                   offSet:(NSString*)offSet;



//Share a single image method
/* 
 
 @method 分享单张图片的方法

 @parameter :
    @baseURL 基本路径
    @uid     用户uid
    @image   图片
    @content 发送文字内容

 */
+(CommonNetworkOutput *)postStatusByUid:(NSString*)baseURL
                                  uId:(NSString *)uid
                                image:(NSData *)image
                              content:(NSString*)content;
@end
