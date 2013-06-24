//
//  UserManager.h
//  WoJianMei
//
//  Created by Kaibin on 13-6-19.
//
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject

+ (User*)createUserWithUserId:(NSString *)userId
                   sinaUserId:(NSString *)sinaUserId
                     qqUserId:(NSString *)qqUserId
                     userType:(NSString *)userType
                         name:(NSString *)name
              profileImageUrl:(NSString *)profileImageUrl
                       gender:(NSString *)gender;

@end
