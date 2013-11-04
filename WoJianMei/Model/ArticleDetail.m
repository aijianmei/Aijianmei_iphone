//
//  ArticleDetail.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-8.
//
//

#import "ArticleDetail.h"

@implementation ArticleDetail

@synthesize _id = _id;




-(id)initWithid:(NSString *)articleId
         wapimg:(NSString *)wapimg
     wapcontent:(NSString *)wapcontent
          title:(NSString *)title
  CommentsCount:(NSString *)CommentsCount
          click:(NSString *)click
            img:(NSString *)img
     creat_time:(NSString *)creat_time
         author:(NSString *)author
        content:(NSString *)content
           like:(NSString *)like
   CommentsList:(NSString *)CommentsList
          brief:(NSString *)brief
{
    
    
    self = [super init];
    if (self) {
        //customrize
        self._id = articleId;
        self.wapimg =wapimg;
        self.content = wapcontent;
        self.title =title;
        self.CommentsCount =CommentsCount;
        self.click =click;
        self.img =img;
        self.create_time =creat_time;
        self.author =author;
        self.like =like;
        self.brief =brief;
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
