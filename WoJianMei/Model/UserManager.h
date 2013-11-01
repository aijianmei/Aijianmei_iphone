//
//  UserManager.h
//  WoJianMei
//
//  Created by Kaibin on 13-6-19.
//
//

#import <Foundation/Foundation.h>
#import "User.h"


#define KEY_ALL_USER_PB_DATA            @"KEY_ALL_USER_PB_DATA"
#define KEY_USERID                      @"USER_KEY_USERID"
#define KEY_NICKNAME                    @"USER_KEY_NICKNAME"
#define KEY_AVATAR_URL                  @"USER_KEY_AVATAR_URL"
#define KEY_DEVICE_TOKEN                @"USER_KEY_DEVICE_TOKEN"
#define KEY_EMAIL                       @"USER_KEY_EMAIL"
#define KEY_PASSWORD                    @"USER_KEY_PASSWORD"
#define KEY_LANGUAGE                    @"USER_KEY_LANGUAGE"
#define KEY_GENDER                      @"USER_KEY_GENDER"
#define KEY_SNS_USER_DATA               @"USER_KEY_SNS_USER_DATA"
#define KEY_LOCATION                    @"USER_KEY_LOCATION"

#define KEY_SINA_LOGINID                @"USER_KEY_SINA_LOGINID"
#define KEY_QQ_LOGINID                  @"USER_KEY_QQ_LOGINID"
#define KEY_FACEBOOK_LOGINID            @"USER_KEY_FACEBOOK_LOGINID"
#define KEY_FACETIME_ID                 @"USER_KEY_FACETIME_ID"



@interface UserManager : NSObject{
    
    User *_user;

}

+ (UserManager*)defaultManager;

@property (nonatomic,retain) User *user;

+ (BOOL)isUserExisted;
+ (NSString *)getUserId;


+ (User*)createUserWithUserId:(NSString *)userId
                   sinaUserId:(NSString *)sinaUserId
                     qqUserId:(NSString *)qqUserId
                     userType:(NSString *)userType
                         name:(NSString *)name
              profileImageUrl:(NSString *)profileImageUrl
                       gender:(NSString *)gender
                        email:(NSString *)email
                     password:(NSString *)password;

- (void)saveUserId:(NSString*)userId
             email:(NSString*)email
          password:(NSString*)password
          nickName:(NSString*)nickName
         avatarURL:(NSString*)avatarURL;

@end
