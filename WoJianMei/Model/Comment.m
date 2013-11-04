//
//  Comment.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/1/13.
//
//

#import "Comment.h"

@implementation Comment
@synthesize _id =_id;



-(id)initWithid:(NSString *)Id
            uid:(NSString *)uid
        content:(NSString *)content
    create_time:(NSString *)create_time
        userimg:(NSString *)userimg
       username:(NSString*)username

{
    
    self = [super init];
    if (self) {
        //customrize
        
        self._id = Id;
        self.uid =uid;
        self.content =content;
        self.create_time =create_time;
        self.userimg = userimg;
        self.username = username;
        
    }
    return self;
}



- (NSString*)timestamp
{
	NSString *_timestamp;
    // Calculate distance time string
    //
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now,[_create_time intValue]);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"秒前" : @"秒前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"分钟前" : @"分钟前"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"小时前" : @"小时前"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"天前" : @"天前"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"周前" : @"周前"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            
            [dateFormatter setDateStyle:NSDateFormatterLongStyle];
            //只是需要精确到天
            //            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_create_time  intValue]];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    return _timestamp;
}

@end
