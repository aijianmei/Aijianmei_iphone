//
//  CommentViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/23/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "ArticleService.h"

@class Video;
@class Article;
@class YFInputBar;

@interface CommentViewController : PPTableViewController<UITextFieldDelegate,ArticleServiceDelegate,UIGestureRecognizerDelegate>
{
      Video       *_video;
      Article   *_article;
      YFInputBar *_inputBar;
    
}

@property (nonatomic,retain) Video *video;
@property (nonatomic,retain) Article *article;
@property (nonatomic,retain) YFInputBar *inputBar;






-(void)loadDatas;
@end
