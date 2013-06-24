//
//  UserManager.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-19.
//
//

#import "UserManager.h"
#import "User.h"

@implementation UserManager:NSObject


+ (User*)createUserWithUserId:(NSString *)userId
                     snsId:(NSString *)snsId
                    userType:(NSString*)userType
                        name:(NSString *)nickName
                      profileImageUrl:(NSString *)profileImageUrl
                      gender:(NSString*)gender
{
    User *user = [[[User alloc] init] autorelease];
    user.uid = userId;
    user.snsId = snsId;
    user.userType = userType;
    user.name = nickName;
    user.profileImageUrl = profileImageUrl;
    user.gender = gender;
    return user;
}



@end
