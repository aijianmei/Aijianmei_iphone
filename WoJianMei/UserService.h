//
//  UserService.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/22/12.
//
//

#import <Foundation/Foundation.h>
#import "CommonService.h"




@protocol UserServiceDelegate <NSObject>

@optional

- (void)queryVersionFinish:(NSString*)version
               dataVersion:(NSString*)dataVersion
                     title:(NSString *)title
                   content:(NSString *)content;
@end





@interface UserService : CommonService


+ (UserService*)defaultService;

///获取新版本
- (void)queryVersion:(id<UserServiceDelegate>)delegate;

// 用户登陆
- (void)login:(id<UserServiceDelegate>)delegate;








@end
