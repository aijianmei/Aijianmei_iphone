//
//  Article.h
//  WoJianMei
//
//  Created by Kaibin on 13-6-4.
//
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (nonatomic, copy)NSString *category_id;
@property (nonatomic, copy)NSString *_id;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *brief;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *click;
@property (nonatomic, copy)NSString *channel;
@property (nonatomic, copy)NSString *commentCount;
@property (nonatomic, copy)NSString *channeltype;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *shareurl;

@end
