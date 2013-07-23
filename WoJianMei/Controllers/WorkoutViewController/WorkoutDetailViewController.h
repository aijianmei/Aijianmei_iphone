//
//  WorkoutDetailViewController.h
//  WoJianMei
//
//  Created by Kaibin on 13-6-6.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "Article.h"
#import "ArticleDetail.h"
#import <RestKit/RestKit.h>
#import "PPViewController.h"
#import "AWActionSheet.h"


@interface WorkoutDetailViewController : PPViewController<RKObjectLoaderDelegate,UIWebViewDelegate,UIScrollViewDelegate>

{
    UIToolbar *_toolBar;
    UIButton *_likeButton;
    ArticleDetail *_articleDetail;
}

@property(nonatomic, retain) Article *article;
@property(nonatomic, retain) ArticleDetail *articleDetail;
@property(nonatomic, retain) UIWebView *webview;
@property(nonatomic, retain) UIToolbar *toolBar;
@property(nonatomic,retain)  UIButton *likeButton;



- (void)showNavigationBar;
- (void)hideNavigationBar;
- (void)updateUserInterface;




@end
