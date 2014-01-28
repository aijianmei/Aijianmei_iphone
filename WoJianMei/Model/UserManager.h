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
- (NSString*)userId;
- (BOOL)storeUserId:(NSString *)uid;
+ (NSString *)loadUserId;


//Set the email and password info at login view controller
-(BOOL)storeUserEmail:(NSString *)userEmail;
+ (NSString*)loadUserEmail;

-(BOOL)storeUserPassword:(NSString *)userPassword;
+(NSString*)loadUserPassword;



- (void)storeUserData:(User*)user;

-(BOOL)storeUserInfoByUid:(NSString *)uid;
//获取保存在本地的用户信息
-(User*)getUserInfoByUid:(NSString *)uid;

+ (User*)createUserWithUserId:(NSString *)userId
                   sinaUserId:(NSString *)sinaUserId
                     qqUserId:(NSString *)qqUserId
                     userType:(NSString *)userType
                         name:(NSString *)name
              profileImageUrl:(NSString *)profileImageUrl
                       gender:(NSString *)gender
                        email:(NSString *)email
                     password:(NSString *)password;

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


-(void)deleteUserByUid:(NSString *)uid;
//删除新浪微博的信息
- (void)deleteSinaUserInfoWithUid:(NSString *)uid;
//保存新浪微博的信息
- (void)storeSinaUserInfo:(NSDictionary*)userInfo;
//读取新浪微博的信息
- (NSDictionary*)getSinaUserInfoWithUid:(NSString *)uid;


@end
