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
    NSString *_uid;
    NSString *_userType;
    NSString *_profileImageUrl;
    NSString *_avatarBackGroundImage;
    NSString *_name;
    
    NSString *_description;
    NSString *_gender;
    NSString *_sinaUserId;
    NSString *_qqUserId;
    NSString *_email;
    
    NSString *_password;
//    NSNumber *_loginStatus;
    NSMutableArray  *_labelsArray;
    NSString *_age;
    NSString *_height;
    
    NSString *_weight;
    NSString *_BMIValue;
    NSString *_province;
    NSString *_city;
    
    UIImage *_avatarImage;
}

@property (retain, nonatomic)  NSString *uid;
@property (retain, nonatomic)  NSString *userType;
@property (retain, nonatomic)  NSString *profileImageUrl;
@property (retain, nonatomic)  NSString *avatarBackGroundImage;
@property (retain ,nonatomic)  NSString *name;
@property (retain, nonatomic)  NSString *description;
@property (retain, nonatomic)  NSString *gender;

@property (retain, nonatomic)  NSString *sinaUserId;
@property (retain, nonatomic)  NSString *qqUserId;
@property (retain, nonatomic)  NSString *email;
@property (retain, nonatomic)  NSString *password;
//@property (nonatomic, assign)  NSNumber *loginStatus;
@property (retain, nonatomic)  NSMutableArray  *labelsArray;

@property (retain, nonatomic)  NSString *age;
@property (retain, nonatomic)  NSString *height;
@property (retain, nonatomic)  NSString *weight;
@property (retain, nonatomic)  NSString *BMIValue;
@property (retain, nonatomic)  NSString *province;

@property (retain, nonatomic)  NSString *city;
@property (retain, nonatomic)  UIImage *avatarImage;






@end
