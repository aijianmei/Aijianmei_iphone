//
//  UserManager.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-19.
//
//

#import "UserManager.h"
#import "User.h"
#import "PPDebug.h"


#define USERID @"AijianmeiUserId"
#define AVATAR_LOCAL_FILENAME   @"user_avatar.png"




@implementation UserManager:NSObject
@synthesize user =_user;


static UserManager* _defaultManager;

+ (UserManager*)defaultManager{
    if (_defaultManager == nil){
        _defaultManager = [[UserManager alloc] init];
    }
    return _defaultManager;
}

- (void)saveUserId:(NSString*)userId
             email:(NSString*)email
          password:(NSString*)password
          nickName:(NSString*)nickName
         avatarURL:(NSString*)avatarURL
{
    
}

- (void)setUserId:(NSString *)userId
{
}
- (void)setGender:(NSString*)gender
{
}
- (void)setEmail:(NSString *)email
{
}
- (void)setDeviceToken:(NSString*)deviceToken
{
}
- (void)setPassword:(NSString*)password
{
}
- (void)setAvatar:(NSString*)avatarURL
{
}
- (void)setBackground:(NSString*)url
{
}

- (NSString*)avatarURLFromOldStorage
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* value = [userDefaults objectForKey:KEY_AVATAR_URL];
    return value;
}



+ (BOOL)isUserExisted
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults objectForKey:USERID];
    if (userId) {
        return YES ;
    }
    return NO;
}

+ (NSString *)getUserId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:USERID];
}




+ (User*)createUserWithUserId:(NSString *)userId
                   sinaUserId:(NSString *)sinaUserId
                     qqUserId:(NSString *)qqUserId
                     userType:(NSString *)userType
                         name:(NSString *)name
              profileImageUrl:(NSString *)profileImageUrl
                       gender:(NSString *)gender
                        email:(NSString *)email
                     password:(NSString *)password
{
    User *user = [[[User alloc] init] autorelease];
    user.uid = userId;
    user.sinaUserId = sinaUserId;
    user.qqUserId = qqUserId;
    user.userType = userType;
    user.name = name;
    user.profileImageUrl = profileImageUrl;
    user.gender = gender;
    user.email = email;
    user.password = password;
    
    return user;
}






@end
