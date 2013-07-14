//
//  articleViewController.h
//  FTCoreText
//
//  Created by Francesco Frison on 18/08/2011.
//  Copyright 2011 Fuerte International. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTCoreTextView.h"
#import "PPViewController.h"
#import "Article.h"
#import "ArticleDetail.h"
#import <RestKit/RestKit.h>
#import "AWActionSheet.h"


@interface articleViewController : PPViewController <FTCoreTextViewDelegate,RKObjectLoaderDelegate,UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) FTCoreTextView *coreTextView;
@property(nonatomic, retain) Article *article;
@property(nonatomic, retain) ArticleDetail *articleDetail;
@property(nonatomic, retain) UIWebView *webview;


@end
