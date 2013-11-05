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

- (NSString*)userId
{
    //    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    //    return [userDefaults objectForKey:KEY_USERID];
    
    return self.user.uid;
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


- (void)    saveUserId:(NSString*)userId
                 email:(NSString*)email
                height:(NSString *)height
              password:(NSString*)password
              nickName:(NSString*)nickName
             avatarURL:(NSString*)avatarURL
                  city:(NSString *)city
           loginStatus:(NSString *)loginStatus
            sinaUserId:(NSString *)sinaUserId
              qqUserId:(NSString *)qqUserId
              userType:(NSString *)userType
           labelsArray:(NSString *)labelsArray
                gender:(NSString *)gender
              BMIValue:(NSString *)BMIValue
              province:(NSString *)province
                   age:(NSString *)age
           description:(NSString *)description
                weight:(NSString *)weight
avatarBackgroundImageURL:(NSString *)avatarBackgroundImageURL;

{
    
    [self.user setUid:userId];
    [self.user setEmail:email];
    [self.user setHeight:height];
    [self.user setPassword:password];
    [self.user setName:nickName];
    [self.user setProfileImageUrl:avatarURL];
    [self.user setSinaUserId:sinaUserId];
    [self.user setQqUserId:qqUserId];
    [self.user setUserType:userType];
    [self.user setLabelsArray:nil];
    [self.user setGender:gender];
    [self.user setBMIValue:BMIValue];
    [self.user setProvince:province];
    [self.user setAge:age];
    [self.user setWeight:weight];
    [self.user setDescription:description];
    [self.user setAvatarImage:nil];
    
    
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










@end
