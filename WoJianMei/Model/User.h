//
//  User.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/8/13.
//
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>

{
    UIImage  *_avatarImage;
    UIImage  *_avatarBackGroundImage;
    NSString *_name;
    NSString *_motto;
    NSString *_description;
    NSString *_gender;
    NSString *_sinaUserId;
    NSString *_qqUserId;
    NSString *_email;
    NSString *_uid;
    NSString *_userType;
    NSString *_profileImageUrl;
    
}

@property (retain, nonatomic)  UIImage *avatarImage;
@property (retain, nonatomic)  UIImage *avatarBackGroundImage;
@property (retain ,nonatomic)  NSString *name;
@property (retain ,nonatomic)  NSString *motto;
@property (retain, nonatomic)  NSString *description;
@property (retain, nonatomic)  NSString *gender;
@property (retain, nonatomic)  NSString *sinaUserId;
@property (retain, nonatomic)  NSString *email;
@property (retain, nonatomic)  NSString *uid;
@property (retain, nonatomic)  NSString *qqUserId;
@property (retain, nonatomic)  NSString *userType;
@property (retain, nonatomic)  NSString *profileImageUrl;
@property (nonatomic, assign) NSNumber *loginStatus;


@end
