//
//  WorkoutCatalog.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/26/13.
//
//

#import <Foundation/Foundation.h>



@interface Workout : NSObject
@property (nonatomic,retain) NSString *_id;
@property (nonatomic,retain) NSString *name;
@end



@interface WorkoutCatalog : NSObject
@property (nonatomic,retain) NSString *part;
@property (nonatomic,retain) NSArray *workouts;



@end
