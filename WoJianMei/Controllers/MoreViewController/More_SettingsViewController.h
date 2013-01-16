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


@class HZActivityIndicatorView;
@interface More_SettingsViewController: JMStaticContentTableViewController<SinaWeiboDelegate,SinaWeiboRequestDelegate,UIAlertViewDelegate>

{
    
    SinaweiboManager     *sinaweiboManager ;
    
    BOOL isLoginingInSinaWeibo;
    
    HZActivityIndicatorView *indictorView;
}



@end
