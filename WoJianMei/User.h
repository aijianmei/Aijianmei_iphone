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
    
    
}
@property (retain, nonatomic)  UIImage *avatarImage;
@property (retain, nonatomic)  UIImage *avatarBackGroundImage;
@property (retain ,nonatomic)  NSString *name;
@property (retain ,nonatomic)  NSString *motto;

@property (retain, nonatomic)  NSString *description;
@property (retain, nonatomic)  NSString *gender;


@end
