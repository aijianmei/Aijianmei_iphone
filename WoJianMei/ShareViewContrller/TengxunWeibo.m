//
//  TengxunWeibo.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/25/12.
//
//

#import "TengxunWeibo.h"
#import "TencentWeiboManager.h"


#define kQQAccessTokenKey       @"QQAccessTokenKey"
#define kQQAccessTokenSecret	@"QQAccessTokenSecret"
#define TengxunWeiboAuthData    @"TengxunWeiboAuthData"



#define VERIFY_URL      @"http://open.t.qq.com/cgi-bin/authorize?oauth_token="


@implementation TengxunWeibo


@synthesize accessTokenKey;
@synthesize accessTokenSecret;
@synthesize requestTokenKey;
@synthesize requestTokenSecret;
@synthesize authWebView;
@synthesize delegate;




-(void)dealloc{
    
    
    [_accessTokenKey release];
    [_accessTokenSecret release];
    [_requestTokenKey release];
    [_requestTokenSecret release];
    [_authWebView release];
        
    [super dealloc];
}



- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecrect
         andDelegate:(id)_delegate{
    
    
    self = [super init];
    if (self) {
        
        }
    
    
    return self;
}



- (void)loadDefaultKey {
	self.accessTokenKey = [[NSUserDefaults standardUserDefaults] valueForKey:kQQAccessTokenKey];
	self.accessTokenSecret = [[NSUserDefaults standardUserDefaults] valueForKey:kQQAccessTokenSecret];
}

-(void)saveDefaultKey{
    
    [[NSUserDefaults standardUserDefaults] setValue:self.accessTokenKey forKey:kQQAccessTokenKey];
    [[NSUserDefaults standardUserDefaults] setValue:self.accessTokenSecret forKey:kQQAccessTokenSecret];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                                  self.accessTokenKey, kQQAccessTokenKey,
                                  self.accessTokenSecret,kQQAccessTokenSecret, nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:TengxunWeiboAuthData];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}


-(void)removeAuthData{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:TengxunWeiboAuthData];
    [[NSUserDefaults standardUserDefaults] synchronize];
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



@end
