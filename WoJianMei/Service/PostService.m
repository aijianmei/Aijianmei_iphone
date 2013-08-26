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
#import "PostLikeResponse.h"
#import "Result.h"

@protocol PostServiceDelegate <NSObject,RKObjectLoaderDelegate>
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
                delegate:(id<RKObjectLoaderDelegate>)delegate{
  //  http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getcircleList
        //Router setup:
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        [objectManager.router routeClass:[PostStatusRespose class] toResourcePath:@"/ios.php" forMethod:RKRequestMethodPOST];
        
        NSLog(@"Post an Image baseURL %@%@",[objectManager baseURL],@"/ios.php");

        //Mapping setup:
        RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[PostStatusRespose class]];
        [userMapping mapKeyPathsToAttributes:
         @"errorCode", @"errorCode",
         @"uid",@"uid",
         nil];
        [objectManager.mappingProvider addObjectMapping:userMapping];
        [objectManager.mappingProvider setMapping:userMapping forKeyPath:@""];
    
      PostStatusRespose *postStatusRespose = [[PostStatusRespose alloc]init];
    
        //The post
        RKParams* params = [RKParams params];
        [params setValue:@"aijianmei" forParam:@"aucode"];
        [params setValue:@"postCircleList" forParam:@"auact"];
        [params setValue:uid forParam:@"uid"];
        [params setValue:content forParam:@"content"];
    
        NSData *imageData = UIImagePNGRepresentation(image);
        if (imageData)
        {
           [params setData:imageData MIMEType:@"image/png" forParam:@"imageurl"];
        }
    
        [objectManager postObject:postStatusRespose usingBlock:^(RKObjectLoader *loader)
         {
             loader.delegate = delegate;
             loader.params = params;
             loader.targetObject = nil;
             loader.onDidLoadResponse = ^(RKResponse *response) {
                 NSLog(@"Response did arrive");
                 NSLog(@"%@",response.bodyAsString);
             };
         }];
}

#pragma mark --
#pragma mark load Status
-(void)loadStatusWithUid:(int)uid
               targetUid:(int)targetUid
                gymGroup:(int)gymGroup
                   start:(int)start
                  offSet:(int)offSet
                delegate:(id<RKObjectLoaderDelegate>)delegate{
    
    //Router setup:
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager.router routeClass:[PostStatus class] toResourcePath:@"/ios.php" forMethod:RKRequestMethodPOST];
    
    NSLog(@"Load Datas baseURL %@%@",[objectManager baseURL],@"/ios.php");
    
    //Mapping setup:
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[PostStatus class]];
    [userMapping mapKeyPathsToAttributes:
     @"id", @"_id",
     @"uid",@"uid",
     @"userName",@"userName",
     @"like",@"like",
     @"group",@"group",
     @"content",@"content",
     @"imageurl",@"imageurl",
     @"bigImageUrl",@"bigImageUrl",
     @"create_time",@"create_time",
     @"avatarProfileUrl",@"avatarProfileUrl",
     nil];
    [objectManager.mappingProvider addObjectMapping:userMapping];
    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@""];
    
    
    
    
    //The post
     RKParams* params = [RKParams params];
    [params setValue:@"aijianmei" forParam:@"aucode"];
    [params setValue:@"getCircleList" forParam:@"auact"];
    
    if (uid){
        NSString *uidInt = [NSString stringWithFormat:@"%i",uid];
        [params setValue:uidInt forParam:@"uid"];
    }
    
    if (targetUid)
    {
        NSString *targetUidInt = [NSString stringWithFormat:@"%i",targetUid];
        [params setValue:targetUidInt forParam:@"targetUid"];
    }

    
    if (gymGroup)
    {
        NSString *gymGroupInt = [NSString stringWithFormat:@"%i",gymGroup];
        [params setValue:gymGroupInt forParam:@"group"];
    }
    
    if (start)
    {
        NSString *startInt = [NSString stringWithFormat:@"%i",start];
        [params setValue:startInt forParam:@"start"];
    }
    
    if (offSet)
    {
        NSString *offSetInt = [NSString stringWithFormat:@"%i",offSet];
        [params setValue:offSetInt forParam:@"offSet"];
    }
    
    
    //一定要加上这个方法
    PostStatus *postStatus = [[PostStatus alloc]init];
    
    [objectManager postObject:postStatus usingBlock:^(RKObjectLoader *loader)
     {
         loader.delegate = delegate;
         loader.params = params;
         loader.targetObject = nil;
         loader.onDidLoadResponse = ^(RKResponse *response) {
             NSLog(@"Response did arrive");
             NSLog(@"%@",response.bodyAsString);
         };
     }];
}

#pragma mark --
#pragma mark Post Like
-(void)postLikeWithUid:(int)uid
              StatusId:(int)StatusId
              delegate:(id<RKObjectLoaderDelegate>)delegate{

    // http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=postCircleLike 
    //Router setup:
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager.router routeClass:[PostLikeResponse class] toResourcePath:@"/ios.php" forMethod:RKRequestMethodPOST];
    
    NSLog(@"Post an Image baseURL %@%@",[objectManager baseURL],@"/ios.php");
    
    //Mapping setup:
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[PostLikeResponse class]];
    [userMapping mapKeyPathsToAttributes:
     @"errorCode", @"errorCode",
     @"uid",@"uid",
     nil];
    [objectManager.mappingProvider addObjectMapping:userMapping];
    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@""];
    
    PostLikeResponse *postLikeResponse = [[PostLikeResponse alloc]init];
    
    //The post
    RKParams* params = [RKParams params];
    [params setValue:@"aijianmei" forParam:@"aucode"];
    [params setValue:@"postCircleLike" forParam:@"auact"];
    [params setValue:[NSString stringWithFormat:@"%d",uid] forParam:@"uid"];
    [params setValue:[NSString stringWithFormat:@"%d",StatusId] forParam:@"statusId"];
    
    [objectManager postObject:postLikeResponse usingBlock:^(RKObjectLoader *loader)
     {
         loader.delegate = delegate;
         loader.params = params;
         loader.targetObject = nil;
         loader.onDidLoadResponse = ^(RKResponse *response) {
             NSLog(@"Response did arrive");
             NSLog(@"%@",response.bodyAsString);
         };
}];

}

//点击评论

-(void)postCommentWithUid:(NSString*)uid
          targetContentId:(NSString*)targetContentId
                  comment:(NSString*)comment
              channelType:(NSString*)channleType
                 delegate:(id<RKObjectLoaderDelegate>)delegate{
    
    
    /*
     http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_sendcomment&uid=498&id=111&commentcontent=要好好睡才行&channeltype=1
     channeltype 1表示文章 2表示视频
     */
    
   //http://42.96.132.109/wapapi/emoji/test.php
    
    //Router setup:
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager.router routeClass:[Result class] toResourcePath:@"/emoji/test.php" forMethod:RKRequestMethodPOST];
    
    NSLog(@"Post an Image baseURL %@%@",[objectManager baseURL],@"/ios.php");
    
    //Mapping setup:
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[Result class]];
    [userMapping mapKeyPathsToAttributes:
     @"errorCode", @"errorCode",
     @"uid",@"uid",
     nil];
    [objectManager.mappingProvider addObjectMapping:userMapping];
    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@""];
    
    Result *result = [[Result alloc]init];
    
    //The post
    RKParams* params = [RKParams params];
    [params setValue:@"aijianmei" forParam:@"aucode"];
    [params setValue:@"au_sendcomment" forParam:@"auact"];
    [params setValue:uid forParam:@"uid"];
    [params setValue:targetContentId forParam:@"id"];
    [params setValue:comment forParam:@"message"];
    [params setValue:channleType forParam:@"channeltype"];


    
    [objectManager postObject:result usingBlock:^(RKObjectLoader *loader)
     {
         loader.delegate = delegate;
         loader.params = params;
         loader.targetObject = nil;
         loader.onDidLoadResponse = ^(RKResponse *response) {
             NSLog(@"Response did arrive");
             NSLog(@"%@",response.bodyAsString);
         };
     }];
}












@end
