//
//  StoreService.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/17/14.
//
//

#import "StoreService.h"
#import "PPViewController.h"
#import "StoreNetwork.h"
#import "StoreNetworkConstants.h"
#import "PPNetworkRequest.h"
#import "CuzyAdSDK.h"




@implementation StoreService

//Singleton
+(StoreService*)sharedService{

    static StoreService *_sharedService = nil;
    @synchronized(self)
    {
        if (_sharedService == nil) {
            _sharedService = [[StoreService alloc] init];
        }
    }
    return _sharedService;
}

- (id)init
{
    self = [super init];
    return self;
}

- (void)findPorductsWithThemeID:(NSString *)themeId
                      searchKey:(NSString*)searchKey
                      pageIndex:(NSString *)pageIndex
                 viewController:(PPViewController<StoreServiceDelegate>* )viewController{

    [viewController showProgressHUDActivityWithText:@"加载中..."];
    dispatch_async(workingQueue, ^{
        
        //30内的产品
        [[CuzyAdSDK sharedAdSDK] setFilter_ComissionVolumeIn30days:@"30" withEnd:@""];
        
        NSMutableArray* returnArray =
        (NSMutableArray*)[[CuzyAdSDK sharedAdSDK] fetchRawItemArraysWithThemeID:themeId
                         orSearchKeywords:searchKey
                                                                  withPageIndex:[pageIndex integerValue]];
       
   
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
           [viewController hideProgressHUDActivity];
    
            if ([viewController respondsToSelector:@selector(didGetProductsArray:errorCode:)]){
                
                [viewController didGetProductsArray:returnArray errorCode:0];
                
            }
        });
    });
}



@end
