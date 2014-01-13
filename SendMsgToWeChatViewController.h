//
//  SendMsgToWeChatViewController.h
//  ApiClient
//
//  Created by Tencent on 12-2-27.
//  Copyright (c) 2012年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"

@protocol sendMsgToWeChatViewDelegate <NSObject>

@optional
- (void) sendTextContent:(NSString*)nsText;
- (void) sendAppContentWithTitle:(NSString*)title
                     description:(NSString *)descriptoin image:(UIImage *)image urlLink :(NSString*)urlLink;
- (void)sendVideoContentWithTitle:(NSString*)title
                      description:(NSString *)descriptoin
                            image:(UIImage *)image
                        videoLink:(NSString*)videoLink;

- (void) sendImageContent;
- (void) sendNewsContent ;
- (void) doAuth;


- (void) changeScene:(NSInteger)scene;

- (void) sendTextContent;
- (void) sendLinkContent;
- (void) sendMusicContent;
- (void) sendVideoContent;
- (void) sendAppContent;
- (void) sendNonGifContent;
- (void) sendGifContent;
- (void) sendFileContent;
@end
