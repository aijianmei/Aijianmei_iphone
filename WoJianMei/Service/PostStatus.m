//
//  PostStatus.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/6/13.
//
//

#import "PostStatus.h"

@implementation PostStatus
@synthesize _id =_id;
@synthesize uid =_uid;
@synthesize userName =_userName;
@synthesize like =_like;
@synthesize group =_group;
@synthesize content =_content;
@synthesize imageurl =_imageurl;
@synthesize bigImageUrl =_bigImageUrl;
@synthesize create_time =_create_time;
@synthesize avatarProfileUrl =_avatarProfileUrl;
@synthesize videoURL =_videoURL;





-(id)initWithDictionary:(NSDictionary*)dictionary{
    self = [super init];
    if (self) {
    
        self._id = [dictionary objectForKey:@"id"];
        self.uid = [dictionary objectForKey:@"uid"];
        self.group = [dictionary objectForKey:@"group"];
        self.imageurl = [dictionary objectForKey:@"imageurl"];
        self.create_time = [dictionary objectForKey:@"create_time"];
        self.userName = [dictionary objectForKey:@"userName"];
        self.content = [dictionary objectForKey:@"content"];
        self.bigImageUrl = [dictionary objectForKey:@"bigImageUrl"];
        self.avatarProfileUrl = [dictionary objectForKey:@"avatarProfileUrl"];
        self.like = [dictionary objectForKey:@"like"];
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
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_create_time  intValue]];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    return _timestamp;
}


@end
