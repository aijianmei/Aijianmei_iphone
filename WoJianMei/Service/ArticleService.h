//
//  ArticleService.h
//  WoJianMei
//
//  Created by Kaibin on 13-6-4.
//
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface ArticleService : NSObject

+(ArticleService*)sharedService;

- (void)findArticleWithAucode:(NSString*)aucode
                        auact:(NSString*)auact
                     listtype:(NSString*)listtype
                     category:(NSString*)category
                         type:(NSString*)type
                         start:(int)start
                        offset:(int)offset
                       cateid:(NSString*)cateid
                          uid:(NSString*)uid
                     delegate:(id<RKObjectLoaderDelegate>)delegate;

- (void)findArticleInfoWithAucode:(NSString*)aucode
                            auact:(NSString*)auact
                        articleId:(NSString*)_id
                          channel:(NSString*)channel
                      channelType:(NSString*)channelType
                              uid:(NSString*)uid
                         delegate:(id<RKObjectLoaderDelegate>)delegate;

@end
