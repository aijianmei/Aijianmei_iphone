//
//  UserService.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/22/12.
//
//

#import "UserService.h"
#import "CommonService.h"
#import "FitnessNetworkConstants.h"
#import "FitnessNetworkRequest.h"
#import "JSON.h"
#import "User.h"
#import "Result.h"
#import "SinaResult.h"
#import "VersionInfo.h"
#import <RestKit/RestKit.h>



@implementation UserService


static UserService* _defaultUserService = nil;

- (void)dealloc
{
    [_user release];
    [super dealloc];
}

+ (UserService*)defaultService
{
    if (_defaultUserService == nil) {
            _defaultUserService = [[UserService alloc] init];
        [_defaultUserService getUserInfoByUid:@"0"];
    }
    return _defaultUserService;
}

//更新版本的接口
- (void)initVersionMap
{
    //获取在AppDelegate中生成的第一个RKObjectManager对象
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    //将json映射到class
    RKObjectMapping *articleMapping =[RKObjectMapping mappingForClass:[VersionInfo class]];
    [articleMapping mapKeyPathsToAttributes:
     @"version", @"version",
     @"downloadurl",@"downloadurl",
     @"app_update_title",@"updateTitle",
     @"app_update_content",@"updateContent",nil];
    [objectManager.mappingProvider setMapping:articleMapping forKeyPath:@""];
}


//用户版本更新
- (void)queryVersionWithDelegate:(id<RKObjectLoaderDelegate>)delegate
{
    [self initVersionMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_getversion
        
        NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
        [queryParams setObject:@"au_getversion" forKey:@"auact"];
        
    
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


//用户反馈
- (void)postFeedbackWithUid:(NSString*)uid
                    content:(NSString*)content
                   delegate:(id<RKObjectLoaderDelegate>)delegate
{
    
    [self initResultMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
      //  http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_sendsuggestion&uid=1&content=ohmygod
        
        NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
        [queryParams setObject:@"au_sendsuggestion" forKey:@"auact"];
        [queryParams setObject:uid forKey:@"uid"];
        [queryParams setObject:content forKey:@"content"];
        
        
        
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

// 用户登录，只是使用邮箱密码马上可以登录
- (void)loginUserWithEmail:(NSString*)email
                        password:(NSString*)password
                        usertype:(NSString*)usertype
                        delegate:(id<RKObjectLoaderDelegate>)delegate{
    
    [self initResultMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *queryParams = [[[NSMutableDictionary alloc] init] autorelease];
        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
        [queryParams setObject:@"au_login" forKey:@"auact"];
        [queryParams setObject:email forKey:@"email"];
        [queryParams setObject:password forKey:@"userpassword"];
        [queryParams setObject:usertype forKey:@"usertype"];

        
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

// 用户登录，只是使用邮箱密码马上可以登录
- (void)fecthUserInfoWithUid:(NSString*)uid
                  delegate:(id<RKObjectLoaderDelegate>)delegate
{
    
    [self initUserMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *queryParams = [[[NSMutableDictionary alloc] init] autorelease];
        
     /*   http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_getuserinfobyuid&uid=435
      */
        
        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
        [queryParams setObject:@"au_getuserinfobyuid" forKey:@"auact"];
        [queryParams setObject:uid forKey:@"uid"];
        
        
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

- (void)initSinaResultMap
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKObjectMapping *resultMapping =[RKObjectMapping mappingForClass:[SinaResult class]];
    [resultMapping mapKeyPathsToAttributes:
     @"uid", @"_uid",
     @"errorCode", @"errorCode",
     nil];
    [objectManager.mappingProvider setMapping:resultMapping forKeyPath:@""];
    
}


- (void)fechUserIdBySnsId:(NSString*)snsID
               delegate:(id<RKObjectLoaderDelegate>)delegate
{
    [self initSinaResultMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_getuidbysnsid&snsid=1787966731
        
        NSMutableDictionary *queryParams = [[[NSMutableDictionary  alloc]init] autorelease];
        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
        [queryParams setObject:@"au_getuidbysnsid" forKey:@"auact"];
        [queryParams setObject:snsID forKey:@"snsid"];
        
        
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






- (void)registerAijianmeiUserWithUsername:(NSString*)name
                                    email:(NSString*)email
                                 password:(NSString*)password
                                 usertype:(NSString*)usertype
                                 delegate:(id<RKObjectLoaderDelegate>)delegate

{
    [self initResultMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *queryParams = [[[NSMutableDictionary alloc] init] autorelease];
        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
        [queryParams setObject:@"au_register" forKey:@"auact"];
        [queryParams setObject:usertype forKey:@"usertype"];
        [queryParams setObject:name forKey:@"username"];
        [queryParams setObject:password forKey:@"userpassword"];
        [queryParams setObject:email forKey:@"email"];

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


- (void)initResultMap
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKObjectMapping *resultMapping =[RKObjectMapping mappingForClass:[Result class]];
    [resultMapping mapKeyPathsToAttributes:
     @"errorCode", @"errorCode",
     @"uid", @"_uid",
     nil];
    [objectManager.mappingProvider setMapping:resultMapping forKeyPath:@""];

}

- (void)registerUserWithUsername:(NSString*)name
                           email:(NSString*)email
                        password:(NSString*)password
                        usertype:(NSString*)usertype
                           snsId:(NSString*)snsId
                 profileImageUrl:(NSString*)profileImageUrl
                             sex:(NSString*)sex
                             age:(NSString*)age
                     body_weight:(NSString*)weight
                          height:(NSString*)height
                         keyword:(NSString*)keyword
                        province:(NSString*)province
                            city:(NSString*)city
                        delegate:(id<RKObjectLoaderDelegate>)delegate

{
    [self initResultMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *queryParams = [[[NSMutableDictionary alloc] init] autorelease];
        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
        [queryParams setObject:@"au_register" forKey:@"auact"];
        [queryParams setObject:usertype forKey:@"usertype"];
        [queryParams setObject:snsId forKey:@"snsid"];
        [queryParams setObject:name forKey:@"username"];
        [queryParams setObject:email forKey:@"email"];
        [queryParams setObject:password forKey:@"userpassword"];
        [queryParams setObject:profileImageUrl forKey:@"profileImageUrl"];
        [queryParams setObject:sex forKey:@"sex"];
        [queryParams setObject:weight forKey:@"body_weight"];
        [queryParams setObject:height forKey:@"height"];
        [queryParams setObject:keyword forKey:@"keyword"];
        [queryParams setObject:province forKey:@"province"];
        [queryParams setObject:city forKey:@"city"];
        
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


- (void)loginUserWithUseremail:(NSString*)email
                      password:(NSString*)password
                      usertype:(NSString*)usertype
                      delegate:(id<RKObjectLoaderDelegate>)delegate{

    [self initResultMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *queryParams = [[[NSMutableDictionary alloc] init] autorelease];
        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
        [queryParams setObject:@"au_login" forKey:@"auact"];
        [queryParams setObject:email forKey:@"email"];
        [queryParams setObject:password forKey:@"userpassword"];
        [queryParams setObject:usertype forKey:@"usertype"];

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

- (void)initUserMap
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKObjectMapping *resultMapping =[RKObjectMapping mappingForClass:[User class]];
    [resultMapping mapKeyPathsToAttributes:
     @"uid", @"_uid",
     @"userType", @"userType",
     @"profileImageUrl", @"profileImageUrl",
     @"avatarBackGroundImage",@"avatarBackGroundImage",
     @"name", @"name",
     @"description", @"description",
     @"gender", @"gender",
     @"sinaUserId",@"sinaUserId",
     @"qqUserId",@"qqUserId",
     @"email", @"email",
     @"loginStatus",@"loginStatus",
     @"labelsArray", @"labelsArray",
     @"age", @"age",
     @"height", @"height",
     @"weight", @"weight",
     @"BMIValue", @"BMIValue",
     @"province", @"province",
     @"city", @"city",
     nil];
    
    [objectManager.mappingProvider setMapping:resultMapping forKeyPath:@""];
    
}

/* 当用户选择使用新浪微博登陆的时候，要
    进行判断，该新浪微博的id 是否已经是我们的用户
 */

- (void)registerUserWithSinaUserInfo:(NSDictionary*)userInfo
                            delegate:(id<RKObjectLoaderDelegate>)delegate
{
    [self initResultMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:userInfo];
        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
        [queryParams setObject:@"au_register" forKey:@"auact"];
        [queryParams setObject:@"sina" forKey:@"usertype"];
        
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


- (void)fechUserBySnsId:(NSString*)snsID
               userType:(NSString*)userType
                            delegate:(id<RKObjectLoaderDelegate>)delegate
{
    [self initUserMap];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
   // http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_getuserinfobysnsid&snsid=2578458467&usertype=sina
        
        
        NSMutableDictionary *queryParams = [[[NSMutableDictionary  alloc]init] autorelease];
        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
        [queryParams setObject:@"au_getuserinfobysnsid" forKey:@"auact"];
        [queryParams setObject:snsID forKey:@"snsid"];
        [queryParams setObject:userType forKey:@"usertype"];

        
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





- (void)fetchSinaUserInfo:(NSString*)uid
                    delegate:(id<SinaWeiboRequestDelegate>)delegate
{
     //https://api.weibo.com/2/users/show.json

    _sinaweiboManager = [SinaWeiboManager sharedManager];
    [_sinaweiboManager.sinaweibo requestWithURL:@"users/show.json"
                                         params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                 uid, @"uid", nil]
                                     httpMethod:@"GET"
                                       delegate:delegate];
}

//保存新浪微博的信息
- (void)storeSinaUserInfo:(NSDictionary*)userInfo
{
    NSLog(@"<storeSinaUserInfo>:%@",[[userInfo objectForKey:@"id"] stringValue]);
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:[[userInfo objectForKey:@"id"] stringValue]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//读取新浪微博的信息
- (NSDictionary*)getSinaUserInfoWithUid:(NSString *)uid
{
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:uid];
    NSDictionary *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    return userInfo;
}
//删除新浪微博的信息
- (void)deleteSinaUserInfoWithUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults]  removeObjectForKey:uid];
    NSLog(@"######Delete sinaweibo account with ID :%@",uid);
    [[SinaWeiboManager sharedManager] removeAuthData];
    
}



-(void)storeUserInfoByUid:(NSString *)uid
{
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:uid];
}


-(User*)getUserInfoByUid:(NSString *)uid
{
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:uid];
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return user;
}

-(void)deleteUserByUid:(NSString *)uid
{
    [self deleteSinaUserInfoWithUid:self.user.sinaUserId];
    
    if ([self getUserInfoByUid:uid]) {
        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:uid];
        NSLog(@"####Delete User with ID :%@ Successfully!",uid);
    }
    
    [self setUser:nil];
}

//关注爱健美网新浪微博
- (void)createSinaFriendshipWithUid:(NSString*)uid
                 delegate:(id<SinaWeiboRequestDelegate>)delegate
{
    
    //https://api.weibo.com/2/friendships/create.json
    
    
    _sinaweiboManager = [SinaWeiboManager sharedManager];
    [_sinaweiboManager.sinaweibo requestWithURL:@"friendships/create.json"
                                         params: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                  uid, @"uid", nil]
                                     httpMethod:@"POST"
                                       delegate:delegate];
    
}


-(void)shareThroughSinaWeiboWithImageArray:(NSArray *)imageArray
                               TextContent:(NSString *)TextContent
                                  delegate:(id<SinaWeiboRequestDelegate>)delegate
{
        NSString *status = @"我正在使用爱健美客户端！";
        UIImage *pic =[UIImage imageNamed:@"Default-568h@2x.png"];


         NSMutableDictionary * params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               status, @"status",pic,@"pic",nil];

          [[SinaWeiboManager sharedManager].sinaweibo requestWithURL:@"statuses/upload.json"
                                                    params:params
                                                httpMethod:@"POST"
                                                  delegate:delegate];
    
}

+ (void)followWeixinUser:(NSString *)userData{

  

}



-(void)postObject:(NSObject*)object
     WithDelegate:(id<RKObjectLoaderDelegate>)delegate;
{
    
   // http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_uploadimg
  //    http://42.96.132.109/wapapi/imgtest.php
    
    //Router setup:  设定你要POST的物体的上传路径
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    RKURL *url = [RKURL URLWithBaseURL:objectManager.baseURL resourcePath:@"/imgtest.php"];
    
//    [objectManager.router routeClass:[User class] toResourcePath:@"/imgtest.php" forMethod:RKRequestMethodPOST];
    
    
    
//    NSLog(@"Post an Image baseURL %@",[objectManager baseURL]);
    
     

    
    //Mapping setup:
 //     @"uid",
//     @"userType",
//     @"profileImageUrl",
//     @"avatarBackGroundImage",
//     @"name",
//     @"description",
//     @"gender",
//     @"sinaUserId",
//     @"qqUserId",
//     @"email",
//     @"loginStatus",
//     @"labelsArray",
//     @"age",
//     @"height",
//     @"weight",
//     @"BMIValue",
//     @"province",
//     @"city",
//       @"errorCode",
//       @"uid",
//     @"avatarimage1",
//     @"backgroundimage1",
//     nil];
    
//    [objectManager.mappingProvider addObjectMapping:userMapping];
//    [objectManager.mappingProvider setSerializationMapping:[userMapping inverseMapping] forClass:[Result class]];
//    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@"Result"];
    
    
}


+ (NSData *)postImage:(UIImage *)image
            imageName:(NSString *)imageName
            urlString:(NSString *)urlString
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"%@\"\r\n", imageName] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    NSURLResponse *respose = nil;
    NSError *error = nil;
     
    NSLog(@"<DDNetwork> postImage:%@", urlString);
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respose error:&error];
        if (error == nil) {
            NSLog(@"succ");
        } else {
            NSLog(@"error");
        }
        NSLog(@"respose url:%@ textEncodingName:%@ MIMEType:%@ suggestedFilename:%@ expectedContentLength:%lld", respose.URL, respose.textEncodingName, respose.MIMEType,  respose.suggestedFilename, respose.expectedContentLength);
    
    return data;
}

-(void)postImageDelegate:(id<RKObjectLoaderDelegate>)delegate{

    
    //    http://42.96.132.109/wapapi/imgtest.php
    //Router setup: 
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager.router routeClass:[User class] toResourcePath:@"/imgtest.php" forMethod:RKRequestMethodPOST];
    
    NSLog(@"Post an Image baseURL %@%@",[objectManager baseURL],@"/imgtest.php");
    
    //Mapping setup:
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[User class]];
    [userMapping mapKeyPathsToAttributes:
     @"uid", @"uid",
     @"avatarimage", @"profileImageUrl",
     @"backgroundimage",@"avatarBackGroundImage",
     nil];    
    [objectManager.mappingProvider addObjectMapping:userMapping];
    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@""];
    
    //The post
    User *user = [[User alloc] init];
    [user setUid:@"1111"];
    
    
    
    UIImage *image1 = [UIImage imageNamed:@"touxiang_40x40.png"];
    UIImage *image2 = [UIImage imageNamed:@"table_header_bg.png"];
    NSData *imageData1 = UIImagePNGRepresentation(image1);
    NSData *imageData2 = UIImagePNGRepresentation(image2);
    
    
    
    [objectManager postObject:user usingBlock:^(RKObjectLoader *loader)
     {
         RKParams* params = [RKParams params];
         [params setValue:user.uid forParam:@"uid"];
         
         [params setData:imageData1 MIMEType:@"image/png" forParam:@"avatarimage"];
         [params setData:imageData2 MIMEType:@"image/png" forParam:@"backgroundimage"];
         
         loader.params = params;
         
         
         
         loader.targetObject = nil;
         loader.delegate = delegate;

         loader.onDidLoadResponse = ^(RKResponse *response) {
             NSLog(@"Response did arrive");
             NSLog(@"%@",response.bodyAsString);
             
         };

     }];

}





- (BOOL)hasBindAccount
{
    if ([self hasbindSina] || [self hasBindEmail])
        return YES;
    else
        return NO;
}

- (BOOL)hasBindEmail
{
    if ([_user.email length] > 0){
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL)hasbindSina
{
    if ([_user.sinaUserId length] > 0)
        return YES;
    else
        return NO;
}

@end
