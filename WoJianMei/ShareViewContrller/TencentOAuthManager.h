//
//  TencentOAuthManager.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/16/13.
//
//

#import <Foundation/Foundation.h>
#import "TencentOAuth.h"



@interface TencentOAuthManager : NSObject
{


}
@property (retain, nonatomic) TencentOAuth *tencentOAuth;

+ (TencentOAuthManager *)defaultManager;


//此方法在AppDelegate中调用
- (void)createTencentQQWithAppId:(NSString *)appId
                        appPermission:(NSArray *)permissions
                   appRedirectURI:(NSString *)appRedirectURI
                        isInSafari:(BOOL)inSafari
                         delegate:(id<TencentSessionDelegate>)delegate;
- (void)setDelegate:(id<TencentSessionDelegate>)delegate;
- (void)storeAuthData;
- (void)removeAuthData;




@end
