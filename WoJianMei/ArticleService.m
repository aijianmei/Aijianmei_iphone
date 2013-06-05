//
//  ArticleService.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-4.
//
//

#import "ArticleService.h"
#import "Article.h"

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

- (void)initObjectMap
{
    //获取在AppDelegate中生成的第一个RKObjectManager对象
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    //将json映射到class
    RKObjectMapping *articleMapping =[RKObjectMapping mappingForClass:[Article class]];
    [articleMapping mapKeyPathsToAttributes: @"id", @"_id", @"title", @"_title", @"brief", @"_brief", @"create_time", @"_create_time", @"img", @"_img",
        @"clikc", @"_click", @"channel", @"_channel", @"commentCount", @"_commentCount", @"channeltype", @"_channeltype", @"url", @"url", @"shareurl", @"shareurl", nil];
    [objectManager.mappingProvider setMapping:articleMapping forKeyPath:@""];
}

- (void)findArticleWithAucode:(NSString*)aucode
                        auact:(NSString*)auact
                     listtype:(NSString*)listtype
                     category:(NSString*)category
                         type:(NSString*)type
                         page:(NSString*)page
                        pnums:(NSString*)pnums
                          uid:(NSString*)uid
                     delegate:(id<RKObjectLoaderDelegate>)delegate
{
    [self initObjectMap];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //传入api接口参数,例如：
        //aucode=aijianmei&auact=au_getinformationlist&listtype=2&category=train&type=hot&page=1&punms=5
        NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:aucode, @"aucode",
                                                                                auact, @"auact",
                                                                             listtype, @"listtype",
                                                                             category, @"category",
                                                                                 type, @"type",
                                                                                 page, @"page",
                                                                                pnums, @"pnums",
                                                                                  uid, @"uid", nil];
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/ios.php" queryParameters:queryParams];
        
        NSLog(@"url: %@", [url absoluteString]);
        NSLog(@"resourcePath: %@", [url resourcePath]);
        NSLog(@"query: %@", [url query]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
        });
    });

}

- (void)findArticle:(id<RKObjectLoaderDelegate>)delegate
{
    //映射所需类对象
    [self initObjectMap];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *aucode= @"aijianmei";
        NSString *auact = @"au_getinformationlist";
        NSString *listtype = @"3";
        NSString *category = @"train";
        NSString *type = @"hot";
        NSString *page = @"1";
        NSString *pnums = @"5";
        NSString *uid = @"265";
                
        NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:aucode, @"aucode", auact, @"auact", listtype, @"listtype", category, @"category", type, @"type",
                                    page, @"page", pnums, @"pnums", uid, @"uid", nil];
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/ios.php" queryParameters:queryParams];
        
        NSLog(@"url: %@", [url absoluteString]);
        NSLog(@"resourcePath: %@", [url resourcePath]);
        NSLog(@"query: %@", [url query]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
        });
    });
}

@end
