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
    
    if (uid) {
        NSString *uidInt = [NSString stringWithFormat:@"%d",uid];
        [params setValue:uidInt forParam:@"uid"];
    }
    if (gymGroup) {
        NSString *gymGroupInt = [NSString stringWithFormat:@"%d",gymGroup];
        [params setValue:gymGroupInt forParam:@"group"];
    }
    if (start)
    {
        NSString *startInt = [NSString stringWithFormat:@"%d",start];
        [params setValue:startInt forParam:@"start"];
    }
    if (offSet)
    {
        NSString *offSetInt = [NSString stringWithFormat:@"%d",offSet];
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
















@end
