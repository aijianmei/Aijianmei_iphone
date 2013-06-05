//
//  Video.m
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArticleInfo.h"

@implementation ArticleInfo



//NSString       *_articleId;
//NSString     *_description;
//NSString           *_title;
//UIImage            *_image;
//NSString    *_releasedTime;
//NSString         *_comment;
//NSString      *_clickTimes;
//
//NSNumber          *_isRead;




@synthesize  articleId =_articleId;
@synthesize image =_image;
@synthesize title =_title;
@synthesize timeLenght =_timeLength;
@synthesize workOut =_workOut;
@synthesize isFollow =_isFollow;


-(id)initWithId:(NSString*)aId
          title:(NSString*)atitle 
      timeLeght:(NSString *)aTimeLenght 
          image:(UIImage *)aImage  
       isFollow:(BOOL)aIsFollow
        workOut:(WorkOut*)aWorkOut
{
    self = [super init];
    if (self) {
        self.articleId =aId;
        self.title = atitle;
        self.timeLenght=aTimeLenght;
        self.image = aImage;
        self.workOut = aWorkOut;
        self.isFollow = [NSNumber numberWithBool:aIsFollow];
    }

    return  self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.articleId forKey:@"articleId"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.timeLenght forKey:@"timeLenght"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.workOut forKey:@"workOut"];
    [aCoder encodeObject:self.isFollow forKey:@"isFollow"];

}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self=[super init]) {
        self.articleId =[aDecoder decodeObjectForKey:@"articleId"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.timeLenght =[aDecoder decodeObjectForKey:@"timeLenght"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
        self.workOut = [aDecoder decodeObjectForKey:@"workOut"];
        self.isFollow = [aDecoder decodeObjectForKey:@"isFollow"];
    }
    return self;
}


- (void)updateByArticle:(ArticleInfo *)article
{
    self.articleId = article.articleId;
    self.title =article.title;
    self.timeLenght = article.timeLenght;
    self.image =article.image;
    self.workOut = article.workOut;
    self.isFollow =article.isFollow;

}

-(void)dealloc{

    [_articleId release];
    [_image release];
    [_title release];
    [_timeLength release];
    [_workOut release];
    [_isFollow release];
    [super dealloc];

}


@end
