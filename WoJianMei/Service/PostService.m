//
//  PostService.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/6/13.
//
//

#import "PostService.h"
#import "PostStatus.h"
#import "PostStatusRespose.h"
#import "Result.h"
#import "PPViewController.h"
#import "FitnessNetworkConstants.h"
#import "PostStatusNetwork.h"
#import "PostStatusNetworkConstant.h"
#import "CommonService.h"
#import "UIImageExt.h"




@protocol PostServiceDelegate <NSObject>
@optional

- (void)queryVersionFinish:(NSString*)version
               dataVersion:(NSString*)dataVersion
                     title:(NSString *)title
                   content:(NSString *)content;
@end

@implementation PostService
@synthesize postStatus =_postStatus;

-(void)dealloc{
    [_postStatus release];
    [super dealloc];
}

+(PostService*)sharedService
{
    static PostService *_sharedService = nil;
    @synchronized(self)
    {
        if (_sharedService == nil) {
            _sharedService = [[PostService alloc] init];
        }
    }
    return _sharedService;
}

- (id)init
{
    self = [super init];
    return self;
}

#pragma mark --
#pragma mark Post Status
-(void)postStatusWithUid:(NSString *)uid
                   image:(UIImage *)image
                 content:(NSString*)content
          viewController:(PPViewController<PostStatusServiceDelegate>* )viewController{
    
    [viewController showProgressHUDActivityWithText:@"加载中..."];

    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = nil;
        output = [PostStatusNetwork postStatusByUid:SERVER_URL
                                                uId:uid
                                              image:[image data]
                                            content:content];
        
        
        
        //Back to the Main Queue
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [viewController hideProgressHUDActivity];
            NSMutableArray *restulArray = [[[NSMutableArray alloc]initWithCapacity:[output.jsonDataArray count]] autorelease];

            if (output.resultCode == ERROR_SUCCESS) {
                int i = 0;
                for (i = 0;i<=[output.jsonDataArray count]-1;i++) {
                    PostStatus *p =[[PostStatus alloc]initWithDictionary:[output.jsonDataArray objectAtIndex:i]];
                    [restulArray addObject:p];
                }
            }
            
            else if (output.resultCode == ERROR_NETWORK) {
                [viewController popupUnhappyMessage:NSLS(@"kSystemFailure") title:nil];
            }
            
            
            
            if ([viewController respondsToSelector:@selector(didPostStatusesSucceeded:)]){
                [viewController didPostStatusesSucceeded:output.resultCode];
            }
            
            
            
            
        });
    });
}

#pragma mark --
#pragma mark load Status
-(void)loadStatusWithUid:(NSString*)uid
               targetUid:(NSString*)targetUid
                gymGroup:(NSString*)gymGroup
                   start:(NSString*)start
                  offSet:(NSString*)offSet
          viewController:(PPViewController<PostStatusServiceDelegate>* )viewController
{
    [viewController showProgressHUDActivityWithText:@"加载中..."];
    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = nil;
        output = [PostStatusNetwork loadStatusesById:SERVER_URL
                                                      Id:uid
                                                targetId:targetUid
                                                gymGroup:gymGroup
                                                   start:start
                                                  offSet:offSet];
        //Back to the Main Queue
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [viewController hideProgressHUDActivity];

            
            NSMutableArray *restulArray = [[[NSMutableArray alloc]initWithCapacity:[output.jsonDataArray count]] autorelease];
            if (output.resultCode == ERROR_SUCCESS) {
                [viewController hideProgressHUDActivity];
                int i = 0;
                for (i = 0;i<=[output.jsonDataArray count]-1;i++) {
                    PostStatus *p =[[PostStatus alloc]initWithDictionary:[output.jsonDataArray objectAtIndex:i]];
                    [restulArray addObject:p];
                }
            }
            
            else if (output.resultCode == ERROR_NETWORK) {
                [viewController popupUnhappyMessage:NSLS(@"kSystemFailure") title:nil];
            }
            
            if ([viewController respondsToSelector:@selector(didLoadStatusesSucceeded:didLoadObjects:)]){
            
                [viewController didLoadStatusesSucceeded:output.resultCode didLoadObjects:restulArray];
            }
        });
   });
}

    
//#pragma mark --
//#pragma mark Post Like
//-(void)postLikeWithUid:(int)uid
//              StatusId:(int)StatusId
//              delegate:(id<RKObjectLoaderDelegate>)delegate{
//
//    // http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=postCircleLike 
//    //Router setup:
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    [objectManager.router routeClass:[PostLikeResponse class] toResourcePath:@"/ios.php" forMethod:RKRequestMethodPOST];
//    
//    NSLog(@"Post an Image baseURL %@%@",[objectManager baseURL],@"/ios.php");
//    
//    //Mapping setup:
//    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[PostLikeResponse class]];
//    [userMapping mapKeyPathsToAttributes:
//     @"errorCode", @"errorCode",
//     @"uid",@"uid",
//     nil];
//    [objectManager.mappingProvider addObjectMapping:userMapping];
//    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@""];
//    
//    PostLikeResponse *postLikeResponse = [[PostLikeResponse alloc]init];
//    
//    //The post
//    RKParams* params = [RKParams params];
//    [params setValue:@"aijianmei" forParam:@"aucode"];
//    [params setValue:@"postCircleLike" forParam:@"auact"];
//    [params setValue:[NSString stringWithFormat:@"%d",uid] forParam:@"uid"];
//    [params setValue:[NSString stringWithFormat:@"%d",StatusId] forParam:@"statusId"];
//    
//    [objectManager postObject:postLikeResponse usingBlock:^(RKObjectLoader *loader)
//     {
//         loader.delegate = delegate;
//         loader.params = params;
//         loader.targetObject = nil;
//         loader.onDidLoadResponse = ^(RKResponse *response) {
//             NSLog(@"Response did arrive");
//             NSLog(@"%@",response.bodyAsString);
//         };
//}];
//
//}
//
////点击评论
//
//-(void)postCommentWithUid:(NSString*)uid
//          targetContentId:(NSString*)targetContentId
//                  comment:(NSString*)comment
//              channelType:(NSString*)channleType
//                 delegate:(id<RKObjectLoaderDelegate>)delegate{
//    
//    
//    /*
//     http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_sendcomment&uid=498&id=111&commentcontent=要好好睡才行&channeltype=1
//     channeltype 1表示文章 2表示视频
//     
//
//     
//     */
//    
//    
//    //Router setup:
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    [objectManager.router routeClass:[Result class] toResourcePath:@"/ios.php" forMethod:RKRequestMethodPOST];
//    
//    NSLog(@"Post an Image baseURL %@%@",[objectManager baseURL],@"/ios.php");
//    
//    //Mapping setup:
//    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[Result class]];
//    [userMapping mapKeyPathsToAttributes:
//     @"errorCode", @"errorCode",
//     @"uid",@"uid",
//     nil];
//    [objectManager.mappingProvider addObjectMapping:userMapping];
//    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@""];
//    
//    Result *result = [[Result alloc]init];
//    
//    //The post
//    RKParams* params = [RKParams params];
//    [params setValue:@"aijianmei" forParam:@"aucode"];
//    [params setValue:@"au_sendcomment" forParam:@"auact"];
//    [params setValue:uid forParam:@"uid"];
//    [params setValue:targetContentId forParam:@"id"];
//    [params setValue:comment forParam:@"commentcontent"];
//    [params setValue:channleType forParam:@"channeltype"];
//
//
//    
//    [objectManager postObject:result usingBlock:^(RKObjectLoader *loader)
//     {
//         loader.delegate = delegate;
//         loader.params = params;
//         loader.targetObject = nil;
//         loader.onDidLoadResponse = ^(RKResponse *response) {
//             NSLog(@"Response did arrive");
//             NSLog(@"%@",response.bodyAsString);
//         };
//     }];
//} 











@end
