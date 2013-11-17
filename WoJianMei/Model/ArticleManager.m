//
//  ArticleManager.m
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArticleManager.h"
#import "ArticleInfo.h"
#define  ARTICLES_LIST        @"ARTICLES_LIST"



typedef enum CATALOG_INDEX

{
    HOME_CATALOG = 0,
    WORKOUT_CATALOG,
    NUTRI_CATALOG,
    SUPPLEMENT_CATALOG,
    LIFESTYLE_CATALOG
    
} CATALOG_INDEX;


ArticleManager *articleManager;
extern ArticleManager   *GlobalGetArticleManager()
{
    if (articleManager == nil) {
        articleManager = [[ArticleManager alloc] init];
    }
    return articleManager;
}

@implementation ArticleManager
@synthesize articleArray =_articleArray;
@synthesize  articleList = _articleList;
@synthesize followArticleList=_followArticleList;


+(ArticleManager *)defaultManager{

    return GlobalGetArticleManager();

}

- (id)init
{
    self = [super init];    
    if (self) {
        
        _articleList = [[NSMutableArray alloc]init];
        
        _followArticleList =[[NSMutableDictionary alloc]init];
        
        _articleArray = [[NSArray alloc]init];

        [self loadArticleList];
    }
    return self;
}


-(void)removeAllArticles{
    
    [self.articleList removeAllObjects];

}
-(void)addArticle:(ArticleInfo *)article{
    
    if (article ==nil) {
        return;
    }
    [_articleList addObject:article];

}
-(void)removeArticle:(ArticleInfo *)article{
    
    [_articleList removeObjectAtIndex:[article.articleId intValue]];
    
}
-(ArticleInfo *)getArticleByWorkOutType:(NSInteger)ArticleId{
    
    ArticleInfo *article = [_articleList objectAtIndex:ArticleId];
    
    
    return article;
}
-(void)addArticleWithId:(NSString*)aId
                  title:(NSString *)aArticleTitle
              imageName:(NSString *)aImageName
              timeLeght:(NSString *)aTimeLenght
               isFollow:(BOOL)aIsFollow
                workOut:(WorkOut*)aWorkOut{
    
//    ArticleInfo *article = [[ArticleInfo alloc]initWithId:[NSString stringWithFormat:@"%d",[_articleList count]]
//                                      title:aArticleTitle 
//                                  timeLeght:aTimeLenght 
//                                      image:[UIImage imageNamed:aImageName]
//                                   isFollow:NO 
//                                    workOut:aWorkOut];
    
//    [_articleList addObject:article];
//    [article release];

}
    
  
#pragma FOLLOW VIDEO
#pragma mark

-(void)loadArticleList
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData* listData = [userDefault objectForKey:ARTICLES_LIST];
    NSMutableDictionary *getFollowMatchList = [NSKeyedUnarchiver unarchiveObjectWithData:listData];
   [self.followArticleList setDictionary:getFollowMatchList];
}

- (void)saveArticleList{

    if (_followArticleList == nil)
        return;
    
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData *followList = [NSKeyedArchiver archivedDataWithRootObject:_followArticleList];
    [userDefault setObject:followList forKey:ARTICLES_LIST];
    
}

- (void)followArticle:(ArticleInfo*)article
{
    if (article == nil)
        return;
    
}

- (void)unfollowArticle:(ArticleInfo*)article
{
    if (article == nil)
        return;
    
}

- (BOOL)isArticleFollowed:(ArticleInfo*)article
{
    
    if (article.articleId == nil || _followArticleList == nil)
        return NO;
    return [_followArticleList objectForKey:article.articleId] != nil;
}



- (NSArray*)getAllFollowArticle
{     
    

    NSArray  *array = [_followArticleList allValues];
    
//    NSArray* sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        Article* article1 = (Article*)obj1;
//        Article* article2 = (Article*)obj2;
//        
//        NSComparisonResult result = [article1.status compare:article2.status];
//        if (result == NSOrderedSame) {
//            result = [article1.date compare:article2.date];
//            return result;
//        }
//        return -result;
//        
//    }];
    
    
//    return sortedArray;
    
    return array ;
}    

- (ArticleInfo *)getArticleById:(NSString *)articleId
{
    if (articleId == nil) {
        return nil;
    }
    for (int i = 0; i < [_articleList count]; ++i) {
        ArticleInfo *article = [_articleList objectAtIndex:i];
        if ([article.articleId isEqualToString:articleId]) {
            return article;
        }
    }
    return nil;
}

- (ArticleInfo *)getFollowArticleById:(NSString *)articleId
{
    if (articleId == nil) {
        return nil;
    }
    for (ArticleInfo* article in [_followArticleList allValues]) {
        if ([article.articleId isEqualToString:articleId]) {
            return article;
        }
    }
    return nil;
}

- (void)updateFollowArticle:(ArticleInfo*)article
{
    ArticleInfo *articleInFollow = [_followArticleList objectForKey:article.articleId];
    if (articleInFollow != nil) {
        [articleInFollow updateByArticle:articleInFollow];
    }
}

- (void)addContentsByCatalog:(int)catalogIndex index:(int)index
{
    
    switch (catalogIndex) {
            
        case HOME_CATALOG:
        {
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        
        }
            break;
        case WORKOUT_CATALOG:
        {
            
        }
            break;
        case NUTRI_CATALOG:
        {
            
        }
            break;
        case SUPPLEMENT_CATALOG:
        {
            
        }
            break;
        case LIFESTYLE_CATALOG:
        {
            
        }
            break;
        default:
            break;
    }
    


    
    
}


-(void)dealloc{
    
    [_articleList release ];
    [_followArticleList release];
    [super dealloc];
    
}


@end
