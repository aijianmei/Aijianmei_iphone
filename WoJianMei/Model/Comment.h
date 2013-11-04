//
//  Comment.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/1/13.
//
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (nonatomic,copy)NSString *_id;
@property (nonatomic,copy)NSString *uid;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *create_time;
@property (nonatomic,copy)NSString *userimg;
@property (nonatomic,copy)NSString *username;


-(id)initWithid:(NSString *)Id
            uid:(NSString *)uid
        content:(NSString *)content
    create_time:(NSString *)create_time
        userimg:(NSString *)userimg
       username:(NSString*)username;

-(NSString*)timestamp;
@end
