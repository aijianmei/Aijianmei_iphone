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
#import "Status.h"

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


- (void)login:(id<UserServiceDelegate>)delegate{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CommonNetworkOutput *output = [FitnessNetworkRequest login];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (output.resultCode == ERROR_SUCCESS) {
//                
//                NSDictionary* jsonDict = [output.textData JSONValue];
//                NSString *app_version = (NSString*)[jsonDict objectForKey:PARA_FITNESS_APP_VERSION];
//                NSString *app_data_version = (NSString*)[jsonDict objectForKey:PARA_FITNESS_APP_DATA_VERSION];
//                
//                NSString *app_update_title = (NSString *)[jsonDict objectForKey:PARA_FITNESS_APP_UPDATE_TITLE];
//                NSString *app_update_content = (NSString *)[jsonDict objectForKey:PARA_FITNESS_APP_UPDATE_CONTENT];
                
//                if (delegate && [delegate respondsToSelector:@selector(queryVersionFinish:dataVersion:title:content:)]) {
//                    [delegate queryVersionFinish:app_version dataVersion:app_data_version title:app_update_title content:app_update_content];
//                }
                
                
            }
        });
    });
    
    
}

- (void)initStatusMap
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    RKObjectMapping *userMapping =[RKObjectMapping mappingForClass:[User class]];
    [userMapping mapKeyPathsToAttributes: @"status", @"_status", @"uid", @"_uid", nil];
    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@""];

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
    [self initStatusMap];
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
    [self initStatusMap];
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

- (void)getUserInfo:(NSString*)uid
                    delegate:(id<SinaWeiboRequestDelegate>)delegate
{
    _sinaweiboManager = [SinaWeiboManager sharedManager];
    [_sinaweiboManager.sinaweibo requestWithURL:@"users/show.json"
                                         params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                 uid, @"uid", nil]
                                     httpMethod:@"GET"
                                       delegate:delegate];
}

- (void)storeUserInfo:(NSDictionary*)userInfo
{
    NSLog(@"Store Sina UserInfo to Local");
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"SinaWeiboUserInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
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
    if ([_user.email length] == 0){
        return NO;
    }
    else{
        return YES;
    }
}

- (BOOL)hasbindSina
{
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"SinaWeiboUserInfo"];
    NSDictionary *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    NSString *uid = [userInfo objectForKey:@"id"];
    return (uid == nil ? NO : YES);
}


@end
