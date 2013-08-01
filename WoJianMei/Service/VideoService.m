//
//  VideoService.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/1/13.
//
//

#import "VideoService.h"
#import "Comment.h"
#import "CommentInfo.h"

////数据
#define Aucode       @"aucode"
#define Auact        @"auact"
#define Id           @"id"
#define Channeltype  @"channeltype"

@implementation VideoService


+(VideoService*)sharedService
{
    static VideoService *_sharedService = nil;
    @synchronized(self)
    {
        if (_sharedService == nil) {
            _sharedService = [[VideoService alloc] init];
        }
    }
    return _sharedService;
}

- (id)init
{
    self = [super init];
    return self;
}

- (void)initCommentMap
{
  
    //获取在AppDelegate中生成的第一个RKObjectManager对象
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    //将json映射到class
    RKObjectMapping *commentMapping =[RKObjectMapping mappingForClass:[Comment class]];
    [commentMapping mapKeyPathsToAttributes:
     @"id",@"_id",
     @"uid",@"uid",
     @"content",@"content",
     @"create_time",@"create_time",
     @"userimg",@"userimg",
     @"username",@"username",
     nil];
    
    [objectManager.mappingProvider setMapping:commentMapping forKeyPath:@""];
    
}

//下载文章的评论
-(void)loadVideCommentByVideId:(NSString *)VideoId channelType:(NSString *)channleType  delegate:(id<RKObjectLoaderDelegate>)delegate
{

    [self initCommentMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //传入api接口参数,例如：
      //  http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getcommentbyid&id=117&channeltype=1

        NSString *aucode= @"aijianmei";
        NSString *auact = @"getcommentbyid";
        
        NSDictionary *queryParams = [NSDictionary dictionaryWithObjectsAndKeys:aucode,Aucode,
                                     auact,Auact,
                                     VideoId,Id,
                                     channleType,Channeltype,
                                      nil];
        
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
