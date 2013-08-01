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
@end
