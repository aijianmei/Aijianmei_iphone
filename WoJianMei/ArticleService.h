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
- (void)findArticle:(id<RKObjectLoaderDelegate>)delegate;

@end
