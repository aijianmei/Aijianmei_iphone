//
//  ArticleManager.m
//  WoJianMei
//
//  Created by Tom Callon on 8/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArticleManager.h"
#import "ArticleInfo.h"
#define FOLLOW_VIDEO_LIST        @"FOLLOW_VIDEO_LIST"


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

        [self loadFollowArticleList];
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
    
    ArticleInfo *article = [[ArticleInfo alloc]initWithId:[NSString stringWithFormat:@"%d",[_articleList count]]
                                      title:aArticleTitle 
                                  timeLeght:aTimeLenght 
                                      image:[UIImage imageNamed:aImageName]
                                   isFollow:NO 
                                    workOut:aWorkOut];
    [_articleList addObject:article];
    [article release];

}
    
  
#pragma FOLLOW VIDEO
#pragma mark

- (void)loadFollowArticleList
{
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData* listData = [userDefault objectForKey:FOLLOW_VIDEO_LIST];
    NSMutableDictionary *getFollowMatchList = [NSKeyedUnarchiver unarchiveObjectWithData:listData];
   [self.followArticleList setDictionary:getFollowMatchList];
}

- (void)saveFollowArticleList
{
    if (_followArticleList == nil)
        return;
    
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    NSData *followList = [NSKeyedArchiver archivedDataWithRootObject:_followArticleList];
    [userDefault setObject:followList forKey:FOLLOW_VIDEO_LIST];
    
}

- (void)followArticle:(ArticleInfo*)article
{
    if (article == nil)
        return;
    
    [article setIsFollow:[NSNumber numberWithBool:YES]];
    if ([_followArticleList objectForKey:article.articleId] == nil){
        [self.followArticleList setObject:article forKey:article.articleId];
        [self saveFollowArticleList];
        NSLog(@"my follow articlelist %@",[_followArticleList description]);
        NSLog(@"follow match (%@)", [ArticleInfo description]);
    }
    
}

- (void)unfollowArticle:(ArticleInfo*)article
{
    if (article == nil)
        return;
    
    [article setIsFollow:[NSNumber numberWithBool:NO]];
    [_followArticleList removeObjectForKey:article.articleId];
    [self saveFollowArticleList];
    
    NSLog(@"unfollow match (%@)", [article description]);
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

-(void)dealloc{
    
    [_articleList release ];
    [_followArticleList release];
    [super dealloc];
    
}


@end
