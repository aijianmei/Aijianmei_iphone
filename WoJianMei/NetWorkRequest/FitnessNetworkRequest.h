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
#import "User.h"

typedef void (^FitnessNetworkResponseBlock)(NSDictionary* jsonDictionary, NSData* data, int resultCode);

@interface FitnessNetworkRequest : NSObject



//所有返回数据的格式都是如此的格式，在Benson 那里学习到的数据解析；
/*{"dat":{"fec":0,
          "mc":0,
          "fac":0,
          "rc":0,
          "comc":0,
          "dtc":0,
          "bac":0,
          "tlgc":0,
          "tloc":0},
   "ret":0} */

+ (CommonNetworkOutput *)queryVersion;



///////用户接口
+ (CommonNetworkOutput *)fetchUserSinaWeiboId:(NSString*)baseURL
                                        snsId:(NSString*)snsId;


+ (CommonNetworkOutput *)loginUserByEmail:(NSString*)baseURL
                                    email:(NSString*)email
                                 password:(NSString*)password
                                 usertype:(NSString*)usertype;


+ (CommonNetworkOutput*)registerUserByName:(NSString *)baseURL
                                      name:(NSString*)name
                                     email:(NSString*)email
                                  password:(NSString*)password
                                  usertype:(NSString*)usertype;



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

+ (CommonNetworkOutput *)fetchUserInfoByUid:(NSString *)baseURL
                                        uid:(NSString *)uid;

+ (CommonNetworkOutput*)uploadUserImage:(NSString*)baseURL
                                 userId:(NSString*)userId
                              imageData:(NSData*)imageData
                              imageType:(NSString*)imageType;

+ (CommonNetworkOutput*)updateUser:(NSString*)baseURL
                              user:(User*)user;


+ (CommonNetworkOutput *)postFeedbackWithUid:(NSString*)baseURL
                                         uid:(NSString*)uid
                                     content:(NSString*)content;

+ (CommonNetworkOutput *)queryVersion:(NSString*)baseURL;




///Statuses
+ (CommonNetworkOutput *)loadStatusesById:(NSString*)baseURL
                                      Id:(NSString*)Id
                                targetId:(NSString*)targetId
                                 gymGroup:(NSString*)gymGroup
                                    start:(NSString*)start
                                   offSet:(NSString*)offSet;



@end
