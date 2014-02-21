//
//  RespForWeChatViewController.h
//  SDKSample
//
//  Created by Tencent on 12-4-9.
//  Copyright (c) 2012年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RespForWeChatViewDelegate <NSObject>
@optional
- (void) RespTextContent;
- (void) RespImageContent;
- (void) RespLinkContent;
- (void) RespMusicContent;
- (void) RespVideoContent;
- (void) RespAppContent;
- (void) RespNonGifContent;
- (void) RespGifContent;
- (void) RespFileContent;
@end