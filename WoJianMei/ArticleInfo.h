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
    NSString     *_description;
    NSString           *_title;
    UIImage            *_image;
    NSString    *_releasedTime;
    NSString         *_comment;
    NSString      *_clickTimes;

    NSNumber          *_isRead;

    
    
    
}
@property (nonatomic, retain) NSString       *articleId;
@property (nonatomic, retain) NSString           *title;
@property (nonatomic, retain) NSString     *description;
@property (nonatomic, retain) UIImage            *image;
@property (nonatomic, retain) NSString    *releasedTime;
@property (nonatomic, retain) NSString         *comment;
@property (retain, nonatomic) NSNumber       *isRead;

-(id)initWithId:(NSString*)aId
          title:(NSString*)atitle
    description:(NSString*)aDescription
          image:(UIImage *)aImage
   releasedTime:(NSString *)aReleasedTime
        comment:(NSString *)aComment
         isRead:(BOOL)aIsRead;

- (void)updateByArticle:(ArticleInfo *)article;




@end
