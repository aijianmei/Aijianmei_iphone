//
//  Article.h
//  WoJianMei
//
//  Created by Kaibin on 13-6-4.
//
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (nonatomic, retain)NSString *category_id;
@property (nonatomic, retain)NSString *_id;
@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *brief;
@property (nonatomic, retain)NSString *create_time;
@property (nonatomic, retain)NSString *img;
@property (nonatomic, retain)NSString *click;
@property (nonatomic, retain)NSString *commentCount;
@property (nonatomic, retain)NSString *channeltype;
@property (nonatomic, retain)NSString *url;
@property (nonatomic, retain)NSString *shareurl;
@property (nonatomic, retain)NSString *channel;


-(id)initWithid:(NSString *)articleId
    category_id:(NSString *)category_id
          title:(NSString *)title
          brief:(NSString *)brief
    create_time:(NSString *)create_time
            img:(NSString *)img
          click:(NSString *)click
   commentCount:(NSString *)commentCount
    channeltype:(NSString *)channeltype
            url:(NSString *)url
       shareurl:(NSString *)shareurl
        channel:(NSString *)channel;

- (NSString*)timestamp;



@end
