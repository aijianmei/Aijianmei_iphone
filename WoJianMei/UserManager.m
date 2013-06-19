//
//  UserManager.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-19.
//
//

#import "UserManager.h"

@implementation UserManager

+ (UserManager*)sharedManager
{
    static UserManager* _sharedManager = nil;
    @synchronized(self)
    {
        if (_sharedManager == nil) {
            _sharedManager = [[UserManager alloc] init];
        }
    }
    return _sharedManager;
}

+ (BOOL)createUserWithUserId:(NSString *)userId
                     snsId:(NSString *)snsId
                    userType:(int)userType
                        name:(NSString *)nickName
                      avatarImage:(NSString *)avatar
{
    return YES;
}

@end
