//
//  SecondViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMStaticContentTableViewController.h"
#import "SinaweiboManager.h"
#import "TencentOAuthManager.h"

@class HZActivityIndicatorView;
@interface More_SettingsViewController: JMStaticContentTableViewController<SinaWeiboDelegate,SinaWeiboRequestDelegate,UIAlertViewDelegate,TencentSessionDelegate>

{
    
    SinaweiboManager     *sinaweiboManager;
    TencentOAuthManager *tencentOAuthManager;

    HZActivityIndicatorView *indictorView;
}



@end
