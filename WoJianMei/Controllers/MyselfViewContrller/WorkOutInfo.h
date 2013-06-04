//
//  WorkOutInfo.h
//  WoJianMei
//
//  Created by Tom Callon  on 6/4/13.
//
//

#import <Foundation/Foundation.h>

@interface WorkOutInfo : NSObject<NSCoding>

{
    
    //workout datas 里边应该有的信息；
    
    NSDate          *_date;
    UIImage        *_image;
    NSString        *_note;
    NSMutableArray *_datas;
    
}

@property (retain, nonatomic)  NSDate          *date;
@property (retain, nonatomic)  UIImage        *image;
@property (retain ,nonatomic)  NSString        *note;
@property (retain ,nonatomic)  NSMutableArray *datas;

@end
