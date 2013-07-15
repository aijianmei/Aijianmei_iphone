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


- (void)queryVersion:(id<UserServiceDelegate>)delegate{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CommonNetworkOutput *output = [FitnessNetworkRequest queryVersion];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (output.resultCode == ERROR_SUCCESS) {
                NSDictionary* jsonDict = [output.textData JSONValue];
                NSString *app_version = (NSString*)[jsonDict objectForKey:PARA_FITNESS_APP_VERSION];
                NSString *app_data_version = (NSString*)[jsonDict objectForKey:PARA_FITNESS_APP_DATA_VERSION];
                
                NSString *app_update_title = (NSString *)[jsonDict objectForKey:PARA_FITNESS_APP_UPDATE_TITLE];
                NSString *app_update_content = (NSString *)[jsonDict objectForKey:PARA_FITNESS_APP_UPDATE_CONTENT];
                
                if (delegate && [delegate respondsToSelector:@selector(queryVersionFinish:dataVersion:title:content:)]) {
                    [delegate queryVersionFinish:app_version dataVersion:app_data_version title:app_update_title content:app_update_content];
                }
            }
        });
    });
}


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



- (void)initResultMap
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKObjectMapping *resultMapping =[RKObjectMapping mappingForClass:[Result class]];
    [resultMapping mapKeyPathsToAttributes: @"errorCode", @"errorCode", @"uid", @"_uid", nil];
    [objectManager.mappingProvider setMapping:resultMapping forKeyPath:@""];

}
- (void)initVersionMap
{
    //获取在AppDelegate中生成的第一个RKObjectManager对象
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    //将json映射到class
    RKObjectMapping *articleMapping =[RKObjectMapping mappingForClass:[VersionInfo class]];
    [articleMapping mapKeyPathsToAttributes:
     @"version", @"version",
     @"downloadurl",@"downloadurl",nil];
    [objectManager.mappingProvider setMapping:articleMapping forKeyPath:@""];
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
        NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
        [queryParams setObject:@"au_register" forKey:@"auact"];
        [queryParams setObject:usertype forKey:@"usertype"];
        [queryParams setObject:snsId forKey:@"snsId"];
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
