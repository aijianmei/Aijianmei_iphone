//
//  CommentViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/23/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "FaceToolBar.h"
#import <RestKit/RestKit.h>

@class Video;
@class Article;

@interface CommentViewController : PPTableViewController<UITextFieldDelegate,FaceToolBarDelegate,RKObjectLoaderDelegate>
{
      Video *_video;
      Article *_article;

}

@property (nonatomic,retain) Video *video;
@property (nonatomic,retain) Article *article;


-(void)loadDatas;
@end
