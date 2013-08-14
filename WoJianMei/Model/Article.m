//
//  Article.m
//  WoJianMei
//
//  Created by Kaibin on 13-6-4.
//
//

#import "Article.h"


#define ID @"id"
#define Category_id @"category_id"
#define Title @"title"
#define Brief @"brief"
#define Create_time @"create_time"
#define Img @"img"
#define Click @"click"
#define CommentCount @"commentCount"
#define Channeltype @"channeltype"
#define Url @"url"
#define Shareurl @"shareurl"
#define Channel @"channel"


@implementation Article

@synthesize _id = _id;
@synthesize category_id =_category_id;
@synthesize title =_title;
@synthesize brief =_brief;
@synthesize create_time =_create_time;
@synthesize img =_img;
@synthesize click =_click;
@synthesize commentCount =_commentCount;
@synthesize channeltype =_channeltype;
@synthesize url =_url;
@synthesize shareurl =_shareurl;
@synthesize channel =_channel;



-(id)init{
    
    self = [super init];
    if (self) {
        //customrize
    }
    return self;
}



-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init])
    {
            
        self._id = [aDecoder decodeObjectForKey:ID];
        self.category_id =[aDecoder decodeObjectForKey:Category_id];
        self.title = [aDecoder decodeObjectForKey:Title];
        self.brief = [aDecoder decodeObjectForKey:Brief];
        self.create_time = [aDecoder decodeObjectForKey:Create_time];
        self.img = [aDecoder decodeObjectForKey:Img];
        self.click =[aDecoder decodeObjectForKey:Click];
        self.commentCount = [aDecoder decodeObjectForKey:CommentCount];
        self.channeltype =[aDecoder decodeObjectForKey:Channeltype];
        self.url =[aDecoder decodeObjectForKey:Url];
        self.channel = [aDecoder decodeObjectForKey:Channel];
        self.shareurl =[aDecoder decodeObjectForKey:Shareurl];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self._id forKey:ID];
    [aCoder encodeObject:self.category_id forKey:Category_id];
    [aCoder encodeObject:self.title forKey:Title];
    [aCoder encodeObject:self.brief forKey:Brief];
    [aCoder encodeObject:self.create_time forKey:Create_time];
    [aCoder encodeObject:self.img forKey:Img];
    [aCoder encodeObject:self.click forKey:Click];
    [aCoder encodeObject:self.commentCount forKey:CommentCount];
    [aCoder encodeObject:self.channeltype forKey:Channeltype];
    [aCoder encodeObject:self.url forKey:Url];
    [aCoder encodeObject:self.shareurl forKey:Shareurl];
    [aCoder encodeObject:self.channel forKey:Channel];
    
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


-(void)dealloc{
  
    [_id release];
    [_category_id release];
    [_title release];
    [_brief release];
    [_create_time release];
    [_img release];
    [_click release];
    [_commentCount release];
    [_channeltype release];
    [_url release];
    [_shareurl release];
    [_channel release];
   
    
    [super dealloc];
}








@end
