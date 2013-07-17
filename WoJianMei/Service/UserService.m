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
#import "VersionInfo.h"

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
        [_defaultUserService getUserInfo];
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
    
    [self initResultMap];
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
    _sinaweiboManager = [SinaWeiboManager sharedManager];
    [_sinaweiboManager.sinaweibo requestWithURL:@"users/show.json"
                                         params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                 uid, @"uid", nil]
                                     httpMethod:@"GET"
                                       delegate:delegate];
}

- (void)storeSinaUserInfo:(NSDictionary*)userInfo
{
    NSLog(@"<storeSinaUserInfo>:%@",[[userInfo objectForKey:@"id"] stringValue]);
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:[[userInfo objectForKey:@"id"] stringValue]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary*)getSinaUserInfoWithUid:(NSString *)uid
{
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:uid];
    NSDictionary *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    return userInfo;
}




-(void)storeUserInfo
{
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"user"];
}

-(User*)getUserInfo
{
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    return user;
}

-(NSMutableDictionary*)createUserInfo:(NSString *)userName
{
    NSMutableDictionary *userInfo = [[[NSMutableDictionary alloc]init] autorelease];
    [userInfo setObject:userName forKey:@"userName"];
    return userInfo;
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
