//
//  ArticleManager.h
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ArticleInfo;
@class WorkOut;


@interface ArticleManager : NSObject

{
    NSArray *_articleArray;

    NSMutableArray  *_articleList;
    NSMutableDictionary *_followArticleList;

}
@property (nonatomic,retain) NSArray*          articleArray;
@property (nonatomic,retain) NSMutableArray *articleList;
@property (nonatomic,retain) NSMutableDictionary *followArticleList;


+(ArticleManager *)defaultManager;



-(void)removeAllArticles;
-(void)addArticle:(ArticleInfo *)article;
-(void)removeArticle:(ArticleInfo *)article;
-(ArticleInfo *)getArticleByWorkOutType:(NSInteger)ArticleId;
-(void)addArticleWithId:(NSString*)aId
                title:(NSString *)aArticleTitle
            imageName:(NSString *)aImageName
            timeLeght:(NSString *)aTimeLenght   
             isFollow:(BOOL)aIsFollow
              workOut:(WorkOut*)aWorkOut;



- (ArticleInfo *)getArticleById:(NSString *)articleId;
- (ArticleInfo *)getFollowArticleById:(NSString *)articleId;



- (void)loadArticleList;
- (void)saveArticleList;



- (void)followArticle:(ArticleInfo*)article;
- (void)unfollowArticle:(ArticleInfo*)article;
- (BOOL)isArticleFollowed:(NSString*)articleId;

- (NSArray*)getAllFollowArticle;



extern  ArticleManager *GlobalGetArticleManager();

@end
