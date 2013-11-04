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
-(void)didPostLikeSucceeded:(int)errorCode;
-(void)didPostCommentSucceeded:(int)errorCode;
-(void)didReceiveCommentListSucceeded:(NSMutableArray *)array  errorCode:(int)errorCode;


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


-(void)sendLikeWithContentId:(NSString *)contentId
                     userId :(NSString *)uid
                 channeltype:(NSString *)channeltype
              viewController:(PPViewController<ArticleServiceDelegate>*)viewController;


//点击评论
/*
 http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_sendcomment&uid=498&id=111&commentcontent=要好好睡才行&channeltype=1
 channeltype 1表示文章 2表示视频
 */
-(void)postCommentWithUid:(NSString*)uid
          targetContentId:(NSString*)targetContentId
                  comment:(NSString*)comment
              channelType:(NSString*)channleType
           viewController:(PPViewController<ArticleServiceDelegate>*)viewController;
;


//  http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getcommentbyid&id=117&channeltype=1
//下载文章的评论
-(void)loadCommentById:(NSString *)Id
           channelType:(NSString *)channleType
        viewController:(PPViewController<ArticleServiceDelegate>*)viewController;




@end
