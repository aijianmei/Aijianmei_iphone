//
//  ArticleService.h
//  WoJianMei
//
//  Created by Kaibin on 13-6-4.
//
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface ArticleService : NSObject

+(ArticleService*)sharedService;


- (void)findArticleWithAucode:(NSString*)aucode
                        auact:(NSString*)auact
                     listtype:(NSString*)listtype
                     category:(NSString*)category
                         type:(NSString*)type
                         page:(NSString*)page
                        pnums:(NSString*)pnums
                          uid:(NSString*)uid
                     delegate:(id<RKObjectLoaderDelegate>)delegate;

- (void)findArticle:(id<RKObjectLoaderDelegate>)delegate;

@end
