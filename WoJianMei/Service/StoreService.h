//
//  StoreService.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/17/14.
//
//

#import <Foundation/Foundation.h>
#import "CommonService.h"



//Delegate
@protocol StoreServiceDelegate <NSObject>
@optional
-(void)didGetProductsArray:(NSArray *)products errorCode:(int)errorCode;
@end



@class PPViewController;
@interface StoreService : CommonService

+(StoreService*)sharedService;
- (void)findPorductsWithThemeID:(NSString *)themeId
                      searchKey:(NSString*)searchKey
                      pageIndex:(NSString *)pageIndex
               viewController:(PPViewController<StoreServiceDelegate>* )viewController;


@end