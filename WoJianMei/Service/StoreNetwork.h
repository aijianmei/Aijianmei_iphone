//
//  StoreNetwork.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/17/14.
//
//

#import <Foundation/Foundation.h>



@class CommonNetworkOutput;

@interface StoreNetwork : NSObject

+ (CommonNetworkOutput*)findProducts:(NSString*)baseURL
                             themeID:(NSString *)themeId
                           searchKey:(NSString*)searchKey
                           pageIndex:(NSString *)pageIndex;
@end
