//
//  PostStatus.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/6/13.
//
//

#import <Foundation/Foundation.h>

@interface PostStatus : NSObject
{
    NSString *_id;
    NSString *_uid;
    NSString *_userName;
    NSString *_like;
    NSString *_group;
    NSString *_content;
    NSString *_imageurl;
    NSString *_bigImageUrl;
    NSString *_avatarProfileUrl;
    NSString *_create_time;

}
@property (nonatomic,retain) NSString *_id;
@property (nonatomic,retain) NSString *uid;
@property (nonatomic,retain) NSString *userName;
@property (nonatomic,retain) NSString *like;
@property (nonatomic,retain) NSString *group;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) NSString *imageurl;
@property (nonatomic,retain) NSString *bigImageUrl;
@property (nonatomic,retain) NSString *avatarProfileUrl;
@property (nonatomic,retain) NSString *create_time;

- (NSString*)timestamp;


@end
