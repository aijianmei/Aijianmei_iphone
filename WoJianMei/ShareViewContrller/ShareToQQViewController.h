//
//  ShareToTencentQQViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/26/12.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "TencentOAuth.h"



 

@interface ShareToQQViewController : PPViewController<TencentSessionDelegate,UIAlertViewDelegate,UITextViewDelegate>


{

  	TencentOAuth* _tencentOAuth;
    NSMutableArray* _permissions;



}



@end
