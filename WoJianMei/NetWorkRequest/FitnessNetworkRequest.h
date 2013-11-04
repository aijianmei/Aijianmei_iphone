//
//  FitnessNetworkRequest.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/22/12.
//
//

#import <Foundation/Foundation.h>

#import "PPNetworkRequest.h"
#import "FitnessNetworkConstants.h"

typedef void (^FitnessNetworkResponseBlock)(NSDictionary* jsonDictionary, NSData* data, int resultCode);

@interface FitnessNetworkRequest : NSObject



+ (CommonNetworkOutput *)queryVersion;



///////用户接口
+ (CommonNetworkOutput *)fetchUserSinaWeiboId:(NSString*)baseURL
                                        snsId:(NSString*)snsId;


+ (CommonNetworkOutput *)loginUserByEmail:(NSString*)baseURL
                                    email:(NSString*)email
                                 password:(NSString*)password
                                 usertype:(NSString*)usertype;

+ (CommonNetworkOutput*)registerUserByEmail:(NSString*)baseURL
                                      email:(NSString*)email
                                   password:(NSString*)password
                                deviceToken:(NSString*)deviceToken
                                   deviceId:(NSString*)deviceId;


//////文章接口
+ (CommonNetworkOutput *)findArticleWithAucode:(NSString*)baseURL
                                        aucode:(NSString*)aucode
                                          auact:(NSString*)auact
                                       listtype:(NSString*)listtype
                                       category:(NSString*)category
                                           type:(NSString*)type
                                          start:(int)start
                                         offset:(int)offset
                                         cateid:(NSString*)cateid
                                           uid:(NSString*)uid;

+ (CommonNetworkOutput *)findArticleInfoWithAucode:(NSString*)baseURL
                                            aucode:(NSString*)aucode
                                             auact:(NSString*)auact
                                         articleId:(NSString*)_id
                                           channel:(NSString*)channel
                                       channelType:(NSString*)channelType
                                               uid:(NSString*)uid;

+ (CommonNetworkOutput *)postLikeByContentId:(NSString *)baseURL
                                   contentId:(NSString *)contentId
                                      userId:(NSString *)uid
                                 channeltype:(NSString *)channeltype;

+ (CommonNetworkOutput *)postCommentWithUid:(NSString*)baseURL
                                        uid:(NSString*)uid
                            targetContentId:(NSString*)targetContentId
                                    comment:(NSString *)comment
                                channelType:(NSString *)channelType;

+ (CommonNetworkOutput *)loadCommentById:(NSString*)baseURL
                                      Id:(NSString*)Id
                             channelType:(NSString*)channleType;




@end
