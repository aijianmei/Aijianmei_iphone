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
#import "SinaWeiboManager.h"



#define USERID @"OriginalUserId"

#define USER_EMAIL @"Aijianmei_User_Email"
#define USER_PassWord @"Aijianmei_User_PassWord"


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


- (void)storeUserData:(User*)user {
    
    
    if (user == nil)
        return;
    
//    self.pbUser = user;
//    
//    NSData* data = [self.pbUser data];
//    if (data == nil)
//        return;
    
//    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:data forKey:KEY_ALL_USER_PB_DATA];
//    [userDefaults synchronize];
//    PPDebug(@"<storeUserData> store user data success!");


}
-(BOOL)storeUserInfoByUid:(NSString *)uid
{
    
    BOOL storeSuccess = NO;
    
    if (uid) {
    //以后程序启动的时候就是要读取默认的这个Uid数据;
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:USERID];
    
     NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:uid];
        
        PPDebug(@"Store userID %@ Successfully !",[ UserManager loadUserId]);
        storeSuccess = YES;
        return storeSuccess ;
    }

    
    return storeSuccess;
}

//获取保存在本地的用户信息
-(User*)getUserInfoByUid:(NSString *)uid
{
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:uid];
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return user;
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

- (BOOL)storeUserId:(NSString *)uid{
    
    BOOL storeSuccess  =NO;
    
    if (uid) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:uid forKey:USERID];
        PPDebug(@"#####Store user ID  %@ Successfully!!!",[UserManager loadUserId]);
        storeSuccess = YES;
        return storeSuccess;
    }
    else if(uid ==nil){
        PPDebug(@"#####Store user ID  Fail!!!");
        storeSuccess =NO;
        return storeSuccess;

    }
    
    
    
    return storeSuccess;
    
}
+ (NSString *)loadUserId
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userDefaults objectForKey:USERID];
    
    return uid;
}



-(BOOL)storeUserEmail:(NSString *)userEmail{
    
    BOOL storeSuccess = NO;
    if ([userEmail length] != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:userEmail forKey:USER_EMAIL];
        storeSuccess = YES;
        
        PPDebug(@"#####Store user Email  %@ Successfully!!!",[UserManager loadUserEmail]);
        return storeSuccess;
    }
    else if (userEmail  ==nil){
    PPDebug(@"####userEmail is nil");
        return storeSuccess;
    }
    
    return storeSuccess;
}

+ (NSString*)loadUserEmail{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userEmail =[userDefaults objectForKey:USER_EMAIL];
    return userEmail;
}
-(BOOL)storeUserPassword:(NSString *)userPassword{
    BOOL storeSuccess = NO;
    if ([userPassword length] != 0) {
    [[NSUserDefaults standardUserDefaults] setObject:userPassword forKey:USER_PassWord];
        storeSuccess = YES;
        PPDebug(@"#####Store User Password %@ Successfully!!!",[UserManager loadUserPassword]);
        return storeSuccess;
        
    }else if (userPassword ==nil){
        PPDebug(@"####Password is nil");
        return storeSuccess;
    }
    
    return storeSuccess;
}
+(NSString*)loadUserPassword{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userEmail =[userDefaults objectForKey:USER_PassWord];
    return userEmail;
}




-(void)deleteUserByUid:(NSString *)uid
{
    
    if ([self.user sinaUserId])
    {
        [self deleteSinaUserInfoWithUid:self.user.sinaUserId];
    }
    
    if ([self getUserInfoByUid:uid])
    {
        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:uid];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERID];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"####Delete User with ID :%@ Successfully!",uid);
        
        
        
        
    }
    
    [self setUser:nil];
}

//删除新浪微博的信息
- (void)deleteSinaUserInfoWithUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults]  removeObjectForKey:uid];
    NSLog(@"######Delete sinaweibo account with ID :%@",uid);
    [[SinaWeiboManager sharedManager] removeAuthData];
    [[[SinaWeiboManager sharedManager] sinaweibo] logOut];
    
}

//保存新浪微博的信息
- (void)storeSinaUserInfo:(NSDictionary*)userInfo
{
    NSLog(@"<storeSinaUserInfo>:%@",[[userInfo objectForKey:@"id"] stringValue]);
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:[[userInfo objectForKey:@"id"] stringValue]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//读取新浪微博的信息
- (NSDictionary*)getSinaUserInfoWithUid:(NSString *)uid
{
    if (!uid) {
        return nil;
    }
    
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:uid];
    NSDictionary *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    return userInfo;
}










@end
