//
//  CommentViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/23/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import <RestKit/RestKit.h>
#import "FaceToolBar.h"

@class Video;
@class Article;

@interface CommentViewController : PPTableViewController<UITextFieldDelegate,RKObjectLoaderDelegate,FaceToolBarDelegate>
{
      Video *_video;
      Article *_article;

    FaceToolBar *_faceToolBar;
    
}

@property (nonatomic,retain) Video *video;
@property (nonatomic,retain) Article *article;
@property (nonatomic,retain) FaceToolBar *faceToolBar;
;



-(void)loadDatas;
@end
