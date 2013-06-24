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
#define Author        @"author"
#define Description   @"description"
#define Content       @"content"
#define Image         @"image"
#define Like          @"like"
#define ReleasedTime  @"releasedTime"
#define ClickTimes    @"clickTimes"
#define Comment       @"comment"
#define CommentList   @"commentList"
//#define IsRead        @"isRead"

@synthesize articleId =_articleId;
@synthesize title =_title;
@synthesize author =_author;
@synthesize description =_description;
@synthesize content =_content;
@synthesize image =_image;
@synthesize like =_like;
@synthesize releasedTime =_releasedTime;
@synthesize clickTimes =_clickTimes;
@synthesize comment =_comment;
@synthesize commentList =_commentList;
//@synthesize isRead =_isRead;


-(id)initWithId:(NSString*)aId
          title:(NSString*)atitle
         author:(NSString*)aAuthor
    description:(NSString*)aDescription
        content:(NSString*)aContent
          image:(NSString*)aImage
           like:(NSString*)aLike
   releasedTime:(NSString*)aReleasedTime
     clickTimes:(NSString*)aClickTimes
        comment:(NSString*)aComment
    commentList:(NSArray*)aCommnetList
//         isRead:(BOOL)aIsRead
{
    self = [super init];
    if (self) {
        self.articleId =aId;
        self.title = atitle;
        self.author = aAuthor;
        self.description=aDescription;
        self.image = aImage;
        self.like = aLike;
        self.releasedTime = aReleasedTime;
        self.clickTimes =aClickTimes;
        self.comment = aComment;
        self.commentList =aCommnetList;
//        self.isRead = [NSNumber numberWithBool:aIsRead];
    }

    return  self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:self.articleId     forKey:ArticleId];
    [aCoder encodeObject:self.title         forKey:Title];
    [aCoder encodeObject:self.author        forKey:Author];
    [aCoder encodeObject:self.description   forKey:Description];
    [aCoder encodeObject:self.content       forKey:Content];
    [aCoder encodeObject:self.image         forKey:Image];
    [aCoder encodeObject:self.like          forKey:Like];
    [aCoder encodeObject:self.releasedTime  forKey:ReleasedTime];
    [aCoder encodeObject:self.clickTimes    forKey:ClickTimes];
    [aCoder encodeObject:self.comment       forKey:Comment];
    [aCoder encodeObject:self.commentList   forKey:CommentList];
//    [aCoder encodeObject:self.isRead        forKey:IsRead];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self=[super init]) {
        self.articleId =[aDecoder     decodeObjectForKey:ArticleId];
        self.title =    [aDecoder     decodeObjectForKey:Title];
        self.author =   [aDecoder     decodeObjectForKey:Author];
        self.description =[aDecoder   decodeObjectForKey:Description];
        self.content    = [aDecoder   decodeObjectForKey:Content];
        self.image = [aDecoder        decodeObjectForKey:Image];
        self.like = [aDecoder         decodeObjectForKey:Like];
        self.releasedTime = [aDecoder decodeObjectForKey:ReleasedTime];
        self.clickTimes = [aDecoder   decodeObjectForKey:ClickTimes];
        self.comment = [aDecoder      decodeObjectForKey:Comment];
        self.commentList = [aDecoder      decodeObjectForKey:CommentList];
//        self.isRead = [aDecoder       decodeObjectForKey:IsRead];
    }
    return self;
}


- (void)updateByArticle:(ArticleInfo *)article
{
    self.articleId = article.articleId;
    self.title =article.title;
    self.author = article.author;
    self.description = article.description;
    self.content = article.content;
    self.image =article.image;
    self.like = article.like;
    self.releasedTime = article.releasedTime;
    self.clickTimes = article.clickTimes;
    self.comment =article.comment;
    self.commentList = article.commentList;
//    self.isRead =article.isRead;
}

-(void)dealloc{
    
    [_commentList release];
//    [_isRead release];
    [super dealloc];

}


@end
