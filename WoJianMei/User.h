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
    NSString *_name;
    NSString *_description;
    NSString *_gender;
    
    
}

@property (retain, nonatomic)  UIImage *avatarImage;
@property (retain ,nonatomic)  NSString *name;
@property (retain, nonatomic)  NSString *description;
@property (retain, nonatomic)  NSString *gender;


@end
