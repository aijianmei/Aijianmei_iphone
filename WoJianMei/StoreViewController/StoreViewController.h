//
//  StoreViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/6/14.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "StoreService.h"
#import "CuzyAdSDK.h"




@interface StoreViewController : PPTableViewController<StoreServiceDelegate,CuzyAdSDKDelegate>

{
    
}
@property(nonatomic,readwrite) BOOL loadingmore;


-(void)showDetailTaobaoWebView:(NSString*)urlString;




@end
