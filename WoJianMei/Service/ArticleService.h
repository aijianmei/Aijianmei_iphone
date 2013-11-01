//
//  ArticleService.h
//  WoJianMei
//
//  Created by Kaibin on 13-6-4.
//
//

#import <Foundation/Foundation.h>
#import "CommonService.h"

@class ArticleDetail;



@protocol ArticleServiceDelegate <NSObject>

@optional
-(void)didGetArticleArray:(NSArray *)objects;
-(void)didGetArticleDetail:(ArticleDetail *)articleDetail;




@end

@class PPViewController;

@interface ArticleService : CommonService

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
               viewController:(PPViewController<ArticleServiceDelegate>* )viewController;

- (void)findArticleInfoWithAucode:(NSString*)aucode
                            auact:(NSString*)auact
                        articleId:(NSString*)_id
                          channel:(NSString*)channel
                      channelType:(NSString*)channelType
                              uid:(NSString*)uid
                   viewController:(PPViewController<ArticleServiceDelegate>* )viewController;


@end
