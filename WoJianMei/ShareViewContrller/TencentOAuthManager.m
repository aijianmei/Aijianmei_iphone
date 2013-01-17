//
//  TencentOAuthManager.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/16/13.
//
//

#import "TencentOAuthManager.h"


static TencentOAuthManager* _globalTencentOAuthManager = nil;


@interface TencentOAuthManager()
@property (retain, nonatomic) NSString *appId;
@property (retain, nonatomic) NSString *appRedirectURI;


@end


@implementation TencentOAuthManager
@synthesize tencentOAuth = _tencentOAuth;
@synthesize appId = _appId;
@synthesize appRedirectURI = _appRedirectURI;




-(void)dealloc{

    
    [_appId release];
    [_appRedirectURI release];
    [_tencentOAuth release];
    [super dealloc];
    
    
}


+ (TencentOAuthManager *)defaultManager
{
    if (_globalTencentOAuthManager == nil) {
        _globalTencentOAuthManager = [[TencentOAuthManager alloc] init];
    }
    
  
    return _globalTencentOAuthManager;
}


- (void)createTencentQQWithAppId:(NSString *)appId
                   appPermission:(NSArray *)permissions
                  appRedirectURI:(NSString *)appRedirectURI
                      isInSafari:(BOOL)inSafari
                        delegate:(id<TencentSessionDelegate>)delegate{

    
    /////移动应用 非社区应用。
    TencentOAuth *tencent = [[TencentOAuth alloc] initWithAppId:appId
                                            andDelegate:delegate];
    

         
    [self loadAuthData];
    
    
    
    if (_tencentOAuth.accessToken ==nil && _tencentOAuth.expirationDate ==nil && _tencentOAuth.openId ==nil) {
        
       
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *tencentQQInfo = [defaults objectForKey:@"tencentQQAuthData"];
        
        if ([tencentQQInfo objectForKey:@"AccessTokenKey"] && [tencentQQInfo objectForKey:@"ExpirationDateKey"] && [tencentQQInfo objectForKey:@"openId"])
        {
            _tencentOAuth.accessToken = [tencentQQInfo objectForKey:@"AccessTokenKey"];
            _tencentOAuth.expirationDate = [tencentQQInfo objectForKey:@"ExpirationDateKey"];
            _tencentOAuth.openId = [tencentQQInfo objectForKey:@"OpenId"];
            
        }

        

    }
    
    
    [tencent authorize:permissions inSafari:inSafari];
    
    
       tencent.redirectURI = appRedirectURI;
    

    
    self.tencentOAuth =tencent;
    [tencent release];

    
    
}

- (void)setDelegate:(id<TencentSessionDelegate>)delegate{
    
    self.tencentOAuth.sessionDelegate = delegate;

}

-(void)loadAuthData {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *tencentQQInfo = [defaults objectForKey:@"tencentQQAuthData"];
    
    if ([tencentQQInfo objectForKey:@"AccessTokenKey"] && [tencentQQInfo objectForKey:@"ExpirationDateKey"] && [tencentQQInfo objectForKey:@"openId"])
    {
        _tencentOAuth.accessToken = [tencentQQInfo objectForKey:@"AccessTokenKey"];
        _tencentOAuth.expirationDate = [tencentQQInfo objectForKey:@"ExpirationDateKey"];
        _tencentOAuth.openId = [tencentQQInfo objectForKey:@"OpenId"];
        
    }
    
}


- (void)storeAuthData{
    
    TencentOAuth *tencentOAuth = [self tencentOAuth];
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              tencentOAuth.accessToken, @"AccessTokenKey",
                              tencentOAuth.expirationDate, @"ExpirationDateKey",
                              tencentOAuth.openId,@"OpenId"
                              ,nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"tencentQQAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)removeAuthData{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"tencentQQAuthData"];
}

@end
