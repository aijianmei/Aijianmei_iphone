//
//  TengxunWeiboManager.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/25/12.
//
//

#import <Foundation/Foundation.h>
#import "UIWebViewUtil.h"
#import "TengxunWeibo.h"

@interface TencentWeiboManager : NSObject<UIWebViewDelegate,TengxunWeiboDelegate>

{
    TengxunWeibo *_tengxunWeibo;
    
}

@property (nonatomic,retain) TengxunWeibo *tengxunWeibo;
@property (nonatomic, retain) NSURLConnection	*connection;
@property (nonatomic, retain) NSString *qqWeiBoAppKey;
@property (nonatomic, retain) NSString *qqWeiBoAppSecret;

- (void)sendQQWeibo:(id)sender;
//- (NSString*)valueForKey:(NSString *)key ofQuery:(NSString*)query;
- (void)loadDefaultKey;
-(void)saveDefaultKey;



+ (TencentWeiboManager *)defaultManager;



//此方法在AppDelegate中调用
- (void)createTengxunweiboWithAppKey:(NSString *)appKey
                           appSecret:(NSString *)appSecret
                     requestTokenKey:(NSString *)requestTokenKey
                  requestTokenSecret:(NSString *)requestTokenSecret
                         andDelegate:(id<TengxunWeiboDelegate>)delegate;

- (void)setDelegate:(id<TengxunWeiboDelegate>)delegate;

- (void)storeAuthData;
- (void)removeAuthData;
- (void)loadAuthData;



@end
