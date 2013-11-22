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
#import "PPViewController.h"
#import "AWActionSheet.h"
#import "SinaWeibo.h"
#import "REComposeViewController.h"
#import "SinaWeiboManager.h"
#import "MoreViewController.h"
#import "CommentViewController.h"
#import "ArticleService.h"



@interface CommonArticleViewController : PPViewController<SinaWeiboRequestDelegate,REComposeViewControllerDelegate,UIGestureRecognizerDelegate,SinaWeiboDelegate,UIActionSheetDelegate,UIScrollViewDelegate,UIWebViewDelegate,ArticleServiceDelegate>

{
    UIButton *_likeButton;
    ArticleDetail *_articleDetail;
    int whichAcctionSheet;

    UIImage *postImage;
    
    SinaWeiboManager *_sinaweiboManager;

    
    CommentViewController *commentViewController;
    
    UIWebView *_webview;
    UIToolbar *_toolBar;
    
}

@property(nonatomic, retain) Article *article;
@property(nonatomic, retain) ArticleDetail *articleDetail;
@property(nonatomic, retain) IBOutlet UIWebView *webview;
@property(nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property(nonatomic,retain)  UIButton *likeButton;

@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;


- (void)updateUserInterface;
-(void)shareArticleWithTitle:(NSString*)title image:(UIImage *)image;




@end
