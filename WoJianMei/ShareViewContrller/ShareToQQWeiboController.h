//
//  ShareToQQController.h
//  Travel
//
//  Created by haodong qiu on 12年4月7日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "TengxunWeibo.h"

@interface ShareToQQWeiboController : PPViewController<UIWebViewDelegate, UITextViewDelegate,TengxunWeiboDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *shareBackgroundImageView;

- (IBAction)backgroundTap:(id)sender;
-(void)logout;


-(void)addView:(UIView *)view;

@end