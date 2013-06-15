//
//  UserService.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/22/12.
//
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
    
}

+ (UserService*)defaultService;

///获取新版本
- (void)queryVersion:(id<UserServiceDelegate>)delegate;

// 用户登陆
- (void)login:(id<UserServiceDelegate>)delegate;


- (BOOL)hasBindAccount;


//新浪微博用户数据注册
- (void)registerUserWithSinaUserInfo:(NSDictionary*)userInfo
                            delegate:(id<RKObjectLoaderDelegate>)delegate;


//获取用户信息
- (void)getUserInfo:(NSString*)uid
                    delegate:(id<SinaWeiboRequestDelegate>)delegate;

@end
