//
//  PlayVideoViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/31/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "AWActionSheet.h"
#import "MoreViewController.h"
#import "SinaWeibo.h"
#import "REComposeViewController.h"


@class Video;
@class SDSegmentedControl;
@class CommentViewController;

@interface PlayVideoViewController : PPViewController<UIWebViewDelegate,REComposeViewControllerDelegate,SinaWeiboRequestDelegate,SinaWeiboDelegate>
{
     Video *_video;
     SDSegmentedControl *_segmentedController;
    
    
    UILabel *_titleLabel;
    UITextView *_descriptionView;
    UILabel *_timeLabel;
    
    
    CommentViewController *_commentViewController;
    UIImage *postImage;
    
    SinaWeiboManager *_sinaweiboManager;


}

@property (nonatomic,retain) Video *video;
@property (nonatomic,retain) SDSegmentedControl *segmentedController;
@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UITextView  *descriptionView;
@property (nonatomic,retain) IBOutlet UILabel  *timeLabel;
@property (nonatomic, retain) UIWebView *playerWebView;
@property (nonatomic,retain)  CommentViewController *commentViewController;
@property (nonatomic, assign) id<sendMsgToWeChatViewDelegate> delegate;






-(void)addTitleButtonsSegmentedController;


@end
