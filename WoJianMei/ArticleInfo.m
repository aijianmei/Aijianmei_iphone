//
//  Video.m
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArticleInfo.h"

@implementation ArticleInfo




#define ArticleId     @"articleId"
#define Title         @"title"
#define Description   @"description"
#define Image         @"image"
#define ReleasedTime  @"releasedTime"
#define ClickTimes    @"clickTimes"
#define Comment       @"comment"
#define IsRead        @"isRead"



@synthesize  articleId =_articleId;
@synthesize  title =_title;
@synthesize description =_description;
@synthesize image =_image;
@synthesize releasedTime =_releasedTime;
@synthesize clickTimes =_clickTimes;
@synthesize comment =_comment;
@synthesize isRead =_isRead;


-(id)initWithId:(NSString*)aId
          title:(NSString*)atitle
    description:(NSString*)aDescription
          image:(UIImage *)aImage
   releasedTime:(NSString *)aReleasedTime
     clickTimes:(NSString*)aClickTimes
        comment:(NSString *)aComment
         isRead:(BOOL)aIsRead
{
    self = [super init];
    if (self) {
        self.articleId =aId;
        self.title = atitle;
        self.description=aDescription;
        self.image = aImage;
        self.releasedTime = aReleasedTime;
        self.clickTimes =aClickTimes;
        self.comment = aComment;
        self.isRead = [NSNumber numberWithBool:aIsRead];
    }

    return  self;
}






-(void)encodeWithCoder:(NSCoder *)aCoder{

    
    [aCoder encodeObject:self.articleId     forKey:ArticleId];
    [aCoder encodeObject:self.title         forKey:Title];
    [aCoder encodeObject:self.description   forKey:Description];
    [aCoder encodeObject:self.image         forKey:Image];
    [aCoder encodeObject:self.releasedTime  forKey:ReleasedTime];
    [aCoder encodeObject:self.clickTimes    forKey:ClickTimes];
    [aCoder encodeObject:self.comment       forKey:Comment];
    [aCoder encodeObject:self.isRead        forKey:IsRead];

    

}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self=[super init]) {
        self.articleId =[aDecoder     decodeObjectForKey:ArticleId];
        self.title = [aDecoder        decodeObjectForKey:Title];
        self.description =[aDecoder   decodeObjectForKey:Description];
        self.image = [aDecoder        decodeObjectForKey:Image];
        self.releasedTime = [aDecoder decodeObjectForKey:ReleasedTime];
        self.clickTimes = [aDecoder   decodeObjectForKey:ClickTimes];
        self.comment = [aDecoder      decodeObjectForKey:Comment];
        self.isRead = [aDecoder       decodeObjectForKey:IsRead];
    }
    return self;
}


- (void)updateByArticle:(ArticleInfo *)article
{
    self.articleId = article.articleId;
    self.title =article.title;
    self.description = article.description;
    self.image =article.image;
    self.releasedTime = article.releasedTime;
    self.clickTimes = article.clickTimes;
    self.comment =article.comment;
    self.isRead =article.isRead;
}

-(void)dealloc{

    [_articleId        release];
    [_image            release];
    [_title            release];
    [_description      release];
    [_image            release];
    [_releasedTime     release];
    [_clickTimes       release];
    [_comment          release];
    [_isRead           release];
    [super dealloc];

}


@end
