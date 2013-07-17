//
//  UserService.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/22/12.
//


#import <Foundation/Foundation.h>
#import "CommonService.h"
#import <RestKit/RestKit.h>
#import "SinaWeiboManager.h"
#import "User.h"

@protocol UserServiceDelegate <NSObject>


@optional

- (void)queryVersionFinish:(NSString*)version
               dataVersion:(NSString*)dataVersion
                     title:(NSString *)title
                   content:(NSString *)content;
@end

@interface UserService : CommonService
{
    SinaWeiboManager *_sinaweiboManager;
    User *_user;
    
}

@property(nonatomic, retain) User *user;

+ (UserService*)defaultService;

//注册用户
- (void)registerUserWithUsername:(NSString*)name
                           email:(NSString*)email
                        password:(NSString*)password
                        usertype:(NSString*)usertype
                           snsId:(NSString*)snsId
                 profileImageUrl:(NSString*)profileImageUrl
                             sex:(NSString*)sex
                             age:(NSString*)age
                     body_weight:(NSString*)weight
                          height:(NSString*)height
                         keyword:(NSString*)keyword
                        province:(NSString*)province
                            city:(NSString*)city
                        delegate:(id<RKObjectLoaderDelegate>)delegate;

///获取新版本
- (void)queryVersionWithDelegate:(id<RKObjectLoaderDelegate>)delegate;

//意见反馈
- (void)postFeedbackWithUid:(NSString*)uid
                    content:(NSString*)content
                   delegate:(id<RKObjectLoaderDelegate>)delegate;


// 用户登录，只是使用邮箱密码马上可以登录
- (void)loginUserWithEmail:(NSString*)email
                     password:(NSString*)password
                     usertype:(NSString*)usertype
                     delegate:(id<RKObjectLoaderDelegate>)delegate;


- (void)fecthUserInfoWithUid:(NSString*)uid
                    delegate:(id<RKObjectLoaderDelegate>)delegate;

//新浪微博用户数据注册
- (void)registerUserWithSinaUserInfo:(NSDictionary*)userInfo
                            delegate:(id<RKObjectLoaderDelegate>)delegate;

//本地注册
- (void)loginUserWithUseremail:(NSString*)email
                      password:(NSString*)password
                      usertype:(NSString*)usertype
                      delegate:(id<RKObjectLoaderDelegate>)delegate;



- (void)registerAijianmeiUserWithUsername:(NSString*)name
                                    email:(NSString*)email
                                 password:(NSString*)password
                                 usertype:(NSString*)usertype
                                 delegate:(id<RKObjectLoaderDelegate>)delegate;
//获取新浪用户信息
- (void)fetchSinaUserInfo:(NSString*)uid
                    delegate:(id<SinaWeiboRequestDelegate>)delegate;

//保存新浪用户信息
- (void)storeSinaUserInfo:(NSDictionary*)userInfo;

- (NSDictionary*)getSinaUserInfoWithUid:(NSString*)uid;
- (void)fechUserBySnsId:(NSString*)snsID
               userType:(NSString*)userType
               delegate:(id<RKObjectLoaderDelegate>)delegate;

//保存用户信息到本地
-(void)storeUserInfoByUid:(NSString *)uid;
//获取保存在本地的用户信息
-(User*)getUserInfoByUid:(NSString *)uid;

-(NSMutableDictionary*)createUserInfo:(NSString *)userName;

//是否绑定邮箱
- (BOOL)hasBindEmail;

//是否绑定账号
- (BOOL)hasBindAccount;



@end
