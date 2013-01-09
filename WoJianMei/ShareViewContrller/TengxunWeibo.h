//
//  TengxunWeibo.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/25/12.
//
//

#import <Foundation/Foundation.h>


@protocol TengxunWeiboDelegate ;


@interface TengxunWeibo : NSObject

{
    
    NSString *_accessTokenKey;
    NSString *_accessTokenSecret;
    
    
    NSString *_requestTokenKey;
    NSString *_requestTokenSecret;
   
    UIWebView *_authWebView;
    
    id<TengxunWeiboDelegate> delegate;

}

@property (nonatomic, retain) NSString *accessTokenKey;
@property (nonatomic, retain) NSString *accessTokenSecret;
@property (nonatomic, retain) NSString *requestTokenKey;
@property (nonatomic, retain) NSString *requestTokenSecret;
@property (nonatomic, retain) UIWebView *authWebView;
@property (nonatomic ,assign) id<TengxunWeiboDelegate> delegate;


- (id)initWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecrect
         andDelegate:(id<UIWebViewDelegate>)_delegate;


- (void)authorizeQQWeibo;
-(void)saveDefaultKey;
- (void)loadDefaultKey ;

-(void)removeAuthData;

- (void)authorizeQQWeibo ;



-(void)logout;
-(void)login;





@end

@protocol TengxunWeiboDelegate <NSObject>
@optional

- (void)tengxunWeiboDidLogIn:(TengxunWeibo *)tengxunWeibo;
- (void)tengxunWeiboDidLogOut:(TengxunWeibo *)tengxunWeibo;
- (void)tengxunWeiboLogInDidCancel:(TengxunWeibo *)tengxunWeibo;
- (void)tengxunWeibo:(TengxunWeibo *)tengxunWeibo logInDidFailWithError:(NSError *)error;
- (void)tengxunWeibo:(TengxunWeibo *)tengxunWeibo accessTokenInvalidOrExpired:(NSError *)error;


@end

