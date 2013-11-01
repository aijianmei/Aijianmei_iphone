//
//  ArticleService.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-4.
//
//

#import "ArticleService.h"
#import "Article.h"
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

- (void)initArticleMap
{
//    //获取在AppDelegate中生成的第一个RKObjectManager对象
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    //将json映射到class
//    RKObjectMapping *articleMapping =[RKObjectMapping mappingForClass:[Article class]];
//    [articleMapping mapKeyPathsToAttributes:
//     @"category_id",@"category_id",
//     @"id", @"_id",
//     @"title", @"_title",
//     @"brief", @"_brief",
//     @"create_time", @"_create_time",
//     @"img", @"_img",
//     @"click", @"_click",
//     @"commentCount",@"_commentCount",
//     @"channeltype",@"_channeltype",
//     @"url", @"url",
//     @"shareurl",@"shareurl",
//     @"channel", @"_channel",nil];
//    
//    [objectManager.mappingProvider setMapping:articleMapping forKeyPath:@""];
}

- (void)initArticleDetailMap
{
//    //获取在AppDelegate中生成的第一个RKObjectManager对象
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    //将json映射到class
//    RKObjectMapping *articleMapping =[RKObjectMapping mappingForClass:[ArticleDetail class]];
//    [articleMapping mapKeyPathsToAttributes:
//     @"id", @"_id",
//     @"title", @"_title",
//     @"author", @"_author",
//     @"content", @"content",
//     @"brief", @"_brief",
//     @"create_time", @"_create_time",
//     @"img", @"_img",
//     @"like", @"like",
//     @"clikc", @"_click",
//     @"commentsCount",@"_commentsCount",nil];
//    [objectManager.mappingProvider setMapping:articleMapping forKeyPath:@""];
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
    
    [viewController showActivityWithText:@"连接中..."];
    
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
                

                array =  (NSMutableArray *)output.jsonDataArray;
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
//                    [article release];
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
            NSMutableArray *array;

            
            if (output.resultCode == ERROR_SUCCESS) {
                
                
                array =  (NSMutableArray *)output.jsonDataArray;

                
                
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
                
                
                [viewController didGetArticleDetail:nil];
                
            }
            
        });
    });
}

@end
