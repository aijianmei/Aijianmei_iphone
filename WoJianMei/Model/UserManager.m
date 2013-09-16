//
//  UserManager.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-19.
//
//

#import "UserManager.h"
#import "User.h"
#define USERID @"AijianmeiUserId"


@implementation UserManager:NSObject
@synthesize user =_user;


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
//    user.loginStatus = [NSNumber numberWithBool:YES];
    return user;
}






@end
