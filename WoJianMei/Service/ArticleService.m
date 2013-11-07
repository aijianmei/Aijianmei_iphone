//
//  ArticleService.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-4.
//
//

#import "ArticleService.h"
#import "Article.h"
#import "Comment.h"
#import "ArticleDetail.h"
#import "PPViewController.h"
#import "CommonService.h"
#import "FitnessNetworkRequest.h"
#import "FitnessNetworkConstants.h"







////文章Article 类


#define id



@implementation ArticleService


+(ArticleService*)sharedService
{
    static ArticleService *_sharedService = nil;
    @synchronized(self)
    {
        if (_sharedService == nil) {
            _sharedService = [[ArticleService alloc] init];
        }
    }
    return _sharedService;
}

- (id)init
{
    self = [super init];
    return self;
}


- (void)findArticleWithAucode:(NSString*)aucode
                        auact:(NSString*)auact
                     listtype:(NSString*)listtype
                     category:(NSString*)category
                         type:(NSString*)type
                        start:(int)start
                       offset:(int)offset
                       cateid:(NSString*)cateid
                          uid:(NSString*)uid
               viewController:(PPViewController<ArticleServiceDelegate>* )viewController
{
    
    [viewController showActivityWithText:@"加载中..."];
    
    dispatch_async(workingQueue, ^{
    
        CommonNetworkOutput* output = nil;
        output = [FitnessNetworkRequest findArticleWithAucode:SERVER_URL
                                                       aucode:aucode
                                                        auact:auact
                                                     listtype:listtype
                                                     category:category
                                                         type:type
                                                        start:start
                                                       offset:offset
                                                       cateid:cateid
                                                          uid:uid];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [viewController hideActivity];
            NSMutableArray    *array;
            NSDictionary *dictionary;
            NSMutableArray *newArray;
            
            
            if (output.resultCode == ERROR_SUCCESS) {
                

                array =  (NSMutableArray *)output.jsonDataDict;
                newArray  =[NSMutableArray arrayWithObject:array];
                [newArray removeAllObjects];

                int i = 0;
                for (i = 0;  i <= [array count] -1; i++) {
                dictionary = [array objectAtIndex:i];
                Article *article = [[Article alloc] initWithid:[dictionary objectForKey:@"id"]
                                                   category_id:[dictionary objectForKey:@"channel"]
                                                         title:[dictionary objectForKey:@"title"]
                                                         brief:[dictionary objectForKey:@"brief"]
                                                   create_time:[dictionary objectForKey:@"create_time"]
                                                           img:[dictionary objectForKey:@"img"]
                                                         click:[dictionary objectForKey:@"click"]
                                                  commentCount:[dictionary objectForKey:@"commentCount"]
                                                   channeltype:[dictionary objectForKey:@"channeltype"]
                                                           url:[dictionary objectForKey:@"url"]
                                                      shareurl:[dictionary objectForKey:@"shareurl"]
                                                       channel:nil];
                    
                    [newArray addObject:article];
                    [article release];
                }
                
            }
            
            else if (output.resultCode == ERROR_NETWORK) {
                [viewController popupUnhappyMessage:NSLS(@"kSystemFailure") title:nil];
                
                
            }
            else if (output.resultCode == ERROR_EMAIL_VERIFIED) {
                // @"对不起，用户注册无法完成，请联系我们的技术支持以便解决问题"
                [viewController popupUnhappyMessage:NSLS(@"用户名或密码错误") title:nil];
                
            }
            
            else {
                // @"对不起，注册失败，请稍候再试"
                //                [viewController popupUnhappyMessage:NSLS(@"kGeneralFailure") title:nil];
                
            }
            
        
            if ([viewController respondsToSelector:@selector(didGetArticleArray:)]){
                
                [viewController didGetArticleArray:newArray];

            }
        });
    });
    
}

- (void)findArticleInfoWithAucode:(NSString*)aucode
                            auact:(NSString*)auact
                        articleId:(NSString*)_id
                        channel:(NSString*)channel
                     channelType:(NSString*)channelType
                          uid:(NSString*)uid
                   viewController:(PPViewController<ArticleServiceDelegate>* )viewController


{
    
    [viewController showActivityWithText:@"连接中..."];
    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = nil;
        output = [FitnessNetworkRequest findArticleInfoWithAucode:SERVER_URL
                                                           aucode:aucode
                                                            auact:auact
                                                        articleId:_id
                                                          channel:channel
                                                      channelType:channelType
                                                              uid:uid];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [viewController hideActivity];
            
            NSDictionary *dictionary;
            ArticleDetail *artileDetail;

            
            if (output.resultCode == ERROR_SUCCESS) {
                dictionary =output.jsonDataDict;
                artileDetail = [[ArticleDetail alloc] initWithid:[dictionary objectForKey:@"id"]
                                                          wapimg:[dictionary objectForKey:@"wapimg"]
                                                      wapcontent:[dictionary objectForKey:@"wapcontent"]
                                                           title:[dictionary objectForKey:@"title"]
                                                   CommentsCount:[dictionary objectForKey:@"CommentsCount"]
                                                           click:[dictionary objectForKey:@"click"]
                                                             img:[dictionary objectForKey:@"img"]
                                                      creat_time:[dictionary objectForKey:@"create_time"]
                                                          author:[dictionary objectForKey:@"author"]
                                                         content:[dictionary objectForKey:@"content"]
                                                            like:[dictionary objectForKey:@"like"]
                                                    CommentsList:[dictionary objectForKey:@"CommentsList"]
                                                           brief:[dictionary objectForKey:@"brief"]];
                
                
            }
            
            else if (output.resultCode == ERROR_NETWORK) {
                [viewController popupUnhappyMessage:NSLS(@"kSystemFailure") title:nil];
                
                
            }
            else if (output.resultCode == ERROR_EMAIL_VERIFIED) {
                // @"对不起，用户注册无法完成，请联系我们的技术支持以便解决问题"
                [viewController popupUnhappyMessage:NSLS(@"用户名或密码错误") title:nil];
                
            }
            
            else {
                // @"对不起，注册失败，请稍候再试"
                //                [viewController popupUnhappyMessage:NSLS(@"kGeneralFailure") title:nil];
                
            }
            
            
            if ([viewController respondsToSelector:@selector(didGetArticleDetail:)]){

                [viewController didGetArticleDetail:artileDetail];
                
            }
            
        });
    });
}
-(void)sendLikeWithContentId:(NSString *)contentId
                     userId :(NSString *)uid
                 channeltype:(NSString *)channeltype
              viewController:(PPViewController<ArticleServiceDelegate>*)viewController

{
    //42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_sendlike&id=111&uid=333&channeltype=1
    
    //A new working Queue
    dispatch_async(workingQueue, ^{
        
        CommonNetworkOutput* output = nil;
        output = [FitnessNetworkRequest postLikeByContentId:SERVER_URL
                                                  contentId:contentId
                                                     userId:uid
                                                channeltype:channeltype];
        
        
        //Back to the Main Queue
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [viewController hideActivity];
            
            NSArray *array  ;
            NSDictionary *dictionary ;
            
            if (output.resultCode == ERROR_SUCCESS) {

                
                
            }
            
            else if (output.resultCode == ERROR_NETWORK) {
                [viewController popupUnhappyMessage:NSLS(@"kSystemFailure") title:nil];
                
                
            }
            else if (output.resultCode == ERROR_EMAIL_VERIFIED) {
                // @"对不起，用户注册无法完成，请联系我们的技术支持以便解决问题"
                [viewController popupUnhappyMessage:NSLS(@"用户名或密码错误") title:nil];
                
            }
            
            else {
                // @"对不起，注册失败，请稍候再试"
                //                [viewController popupUnhappyMessage:NSLS(@"kGeneralFailure") title:nil];
                
            }
            
            if ([viewController respondsToSelector:@selector(didPostLikeSucceeded:)]){
                array  = (NSArray *)output.jsonDataArray;
                dictionary = [array objectAtIndex:0];
                
                
                [viewController didPostLikeSucceeded:output.resultCode];
                
            }
        });
    });

}

//点击评论
/*
 http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_sendcomment&uid=498&id=111&commentcontent=要好好睡才行&channeltype=1
 channeltype 1表示文章 2表示视频
 */
-(void)postCommentWithUid:(NSString*)uid
          targetContentId:(NSString*)targetContentId
                  comment:(NSString*)comment
              channelType:(NSString*)channleType
           viewController:(PPViewController<ArticleServiceDelegate>*)viewController{

    //A new working Queue
    dispatch_async(workingQueue, ^{
        
        CommonNetworkOutput* output = nil;
        output = [FitnessNetworkRequest postCommentWithUid:SERVER_URL
                                                   uid:uid
                                       targetContentId:targetContentId
                                               comment:comment
                                           channelType:channleType];
        
        //Back to the Main Queue
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [viewController hideActivity];
            
            
            if (output.resultCode == ERROR_SUCCESS) {
                
                
                
            }
            
            else if (output.resultCode == ERROR_NETWORK) {
                [viewController popupUnhappyMessage:NSLS(@"kSystemFailure") title:nil];
                
                
            }
            else if (output.resultCode == ERROR_EMAIL_VERIFIED) {
                // @"对不起，用户注册无法完成，请联系我们的技术支持以便解决问题"
                [viewController popupUnhappyMessage:NSLS(@"用户名或密码错误") title:nil];
                
            }
            
            else {
                // @"对不起，注册失败，请稍候再试"
                //                [viewController popupUnhappyMessage:NSLS(@"kGeneralFailure") title:nil];
                
            }
            
            if ([viewController respondsToSelector:@selector(didPostCommentSucceeded:)]){
                NSArray *array  = (NSArray *)output.jsonDataArray;
                NSDictionary *dictionary = [array objectAtIndex:0];
                [viewController didPostCommentSucceeded:output.resultCode];
                
            }
        });
    });
    
}

// http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getcommentbyid&id=117&channeltype=1
//下载文章的评论
-(void)loadCommentById:(NSString *)Id
           channelType:(NSString *)channleType
        viewController:(PPViewController<ArticleServiceDelegate>*)viewController
{

    //A new working Queue
    dispatch_async(workingQueue, ^{
        
        CommonNetworkOutput* output = nil;
        output = [FitnessNetworkRequest loadCommentById:SERVER_URL
                                                     Id:Id
                                            channelType:channleType];
        
        //Back to the Main Queue
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [viewController hideActivity];
            
            NSMutableArray      *array;
            NSMutableArray      *newArray;

            NSDictionary *dictionary;
            
            if (output.resultCode == ERROR_SUCCESS) {
                
                
                array  = (NSMutableArray *)output.jsonDataArray;
                newArray = [NSMutableArray arrayWithArray:array];
                [newArray removeAllObjects];
                dictionary = [array objectAtIndex:0];
                
                int i = 0;
                for (i = 0;  i <= [array count] - 1; i++) {
                    dictionary = [array objectAtIndex:i];
                    Comment *comment = [[Comment alloc] initWithid:[dictionary objectForKey:@"uid"]
                                                               uid:[dictionary objectForKey:@"id"]
                                                           content:[dictionary objectForKey:@"content"]
                                                       create_time:[dictionary objectForKey:@"create_time"]
                                                           userimg:[dictionary objectForKey:@"userimg"]
                                                          username:[dictionary objectForKey:@"username"]];
                    
                    [newArray addObject:comment];
                    [comment release];

                }
                
            }
            
            else if (output.resultCode == ERROR_NETWORK) {
                [viewController popupUnhappyMessage:NSLS(@"kSystemFailure") title:nil];
                
                
            }
            else if (output.resultCode == ERROR_EMAIL_VERIFIED) {
                // @"对不起，用户注册无法完成，请联系我们的技术支持以便解决问题"
                [viewController popupUnhappyMessage:NSLS(@"用户名或密码错误") title:nil];
                
            }
            
            else {
                // @"对不起，注册失败，请稍候再试"
                //                [viewController popupUnhappyMessage:NSLS(@"kGeneralFailure") title:nil];
                
            }
            
            if ([viewController respondsToSelector:@selector(didReceiveCommentListSucceeded:errorCode:)]){
                [viewController didReceiveCommentListSucceeded: newArray  errorCode:output.resultCode];
            }
        });});
        
    
    
}
                   
                   
@end
