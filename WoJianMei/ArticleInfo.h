//
//  Article.h
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleInfo : NSObject<NSCoding>

{


    NSString       *_articleId;
    NSString           *_title;
    NSString          *_author;
    NSString     *_description;
    NSString         *_content;
    NSString           *_image;
    NSString            *_like;
    NSString    *_releasedTime;
    NSString      *_clickTimes;
    NSString         *_comment;
    NSArray      *_commentList;
    
//    NSNumber          *_isRead;
}
@property (nonatomic, copy) NSString     *articleId;
@property (nonatomic, copy) NSString     *title;
@property (nonatomic, copy) NSString     *author;
@property (nonatomic, copy) NSString     *description;
@property (nonatomic, copy) NSString     *content;
@property (nonatomic, copy) NSString     *image;
@property (nonatomic, copy) NSString     *like;
@property (nonatomic, copy) NSString     *releasedTime;
@property (nonatomic, copy) NSString     *clickTimes;
@property (nonatomic, copy) NSString     *comment;
@property (nonatomic,retain)NSArray      *commentList;
//@property (nonatomic, retain) NSNumber       *isRead;

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
    commentList:(NSArray*)aCommnetList;
//         isRead:(BOOL)aIsRead;

- (void)updateByArticle:(ArticleInfo *)article;

@end
