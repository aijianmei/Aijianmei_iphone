//
//  TengxunWeiboManager.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/25/12.
//
//

#import "TencentWeiboManager.h"
//#import "QWeiboSyncApi.h"
//#import "QWeiboAsyncApi.h"
//#import "NSURL+QAdditions.h"


#define kQQAccessTokenKey       @"QQAccessTokenKey"
#define kQQAccessTokenSecret	@"QQAccessTokenSecret"




static TencentWeiboManager* _globalTengxunweiboManager = nil;



@implementation TencentWeiboManager
@synthesize tengxunWeibo =_tengxunWeibo;
@synthesize connection;
@synthesize qqWeiBoAppKey;
@synthesize qqWeiBoAppSecret;



-(void)dealloc{
    
    [_tengxunWeibo release];
    [connection release];
    [qqWeiBoAppKey release];
    [qqWeiBoAppSecret release];
    

    [super dealloc];
}



+ (TencentWeiboManager *)defaultManager
{
    if (_globalTengxunweiboManager == nil) {
        _globalTengxunweiboManager = [[TencentWeiboManager alloc] init];
    }
    return _globalTengxunweiboManager;
}

- (void)createTengxunweiboWithAppKey:(NSString *)appKey
                           appSecret:(NSString *)appSecret
                     requestTokenKey:(NSString *)requestTokenKey
                  requestTokenSecret:(NSString *)requestTokenSecret
                         andDelegate:(id)delegate
{

    self.qqWeiBoAppKey = @"100669978";
    self.qqWeiBoAppSecret = @"b383e7a0201c154e290cf9b839b95998";

    
    TengxunWeibo *tempTengxunWeibo = [[TengxunWeibo alloc]initWithAppKey:self.qqWeiBoAppKey appSecret:self.qqWeiBoAppSecret  andDelegate:delegate];
    self.tengxunWeibo = tempTengxunWeibo;    
    [tempTengxunWeibo release];
    
     [self.tengxunWeibo loadDefaultKey];
    
    
    if (self.tengxunWeibo.accessTokenKey == nil || self.tengxunWeibo.accessTokenSecret ==nil) {
        //获取request_token
//        QWeiboSyncApi *api = [[[QWeiboSyncApi alloc] init] autorelease];
//        NSString *retString = [api getRequestTokenWithConsumerKey:self.qqWeiBoAppKey consumerSecret:self.qqWeiBoAppSecret];
//       
//        ///已经获取了request_Token_Key  and  request_Token_Secret  and expiredDate
//        NSDictionary *params = [NSURL parseURLQueryString:retString];
//         self.tengxunWeibo.requestTokenKey = [params objectForKey:@"oauth_token"];
//         self.tengxunWeibo.requestTokenSecret = [params objectForKey:@"oauth_token_secret"];
//        NSString *expiredDate = [params objectForKey:@"expires_in"];
//        NSLog(@"Tell me about the %@",expiredDate);
//        
//        ////进行授权页面的载入
//        [self.tengxunWeibo authorizeQQWeibo];
    }
}


- (void)setDelegate:(id<TengxunWeiboDelegate>)delegate{

    self.tengxunWeibo.delegate = delegate;
}

- (void)loadAuthData{
    
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kQQAccessTokenKey] && [[NSUserDefaults standardUserDefaults] valueForKey:kQQAccessTokenSecret]) {
        
        self.tengxunWeibo.accessTokenKey = [[NSUserDefaults standardUserDefaults] valueForKey:kQQAccessTokenKey];
        self.tengxunWeibo.accessTokenSecret = [[NSUserDefaults standardUserDefaults] valueForKey:kQQAccessTokenSecret];
        
    }
    
    
}

- (NSString*)valueForKey:(NSString *)key ofQuery:(NSString*)query
{
	NSArray *pairs = [query componentsSeparatedByString:@"&"];
	for(NSString *aPair in pairs){
		NSArray *keyAndValue = [aPair componentsSeparatedByString:@"="];
		if([keyAndValue count] != 2) continue;
		if([[keyAndValue objectAtIndex:0] isEqualToString:key]){
			return [keyAndValue objectAtIndex:1];
		}
	}
	return nil;
}



- (void)storeAuthData{

}


- (void)removeAuthData{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kQQAccessTokenKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kQQAccessTokenSecret];

    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* tengxunWeiboCookies = [cookies cookiesForURL:
                                    [NSURL URLWithString:@"http://open.t.qq.com/"]];
    
    for (NSHTTPCookie* cookie in tengxunWeiboCookies)
    {
        [cookies deleteCookie:cookie];
    }
    
}


@end
