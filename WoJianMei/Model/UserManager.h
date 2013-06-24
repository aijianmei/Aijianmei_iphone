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
                       snsId:(NSString *)snsId
                    userType:(NSString *)userType
                        name:(NSString *)nickName
                 profileImageUrl:(NSString *)avatar
                      gender:(NSString*)gender;

@end
