//
//  ArticleDetail.h
//  WoJianMei
//
//  Created by Kaibin on 13-6-8.
//
//

#import <Foundation/Foundation.h>

@interface ArticleDetail : NSObject

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *wapimg;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *click;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *brief;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *like;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *CommentsCount;



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
          brief:(NSString *)brief;

- (NSString*)timestamp;



@end

