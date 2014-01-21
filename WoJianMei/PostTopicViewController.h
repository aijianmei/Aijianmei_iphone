//
//  PostTopicViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/3/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PostService.h"
#import "TopicPickerDisplayView.h"


@interface PostTopicViewController : PPViewController<UIActionSheetDelegate,TopicPickerCommonViewDelegate,PostStatusServiceDelegate>
{
    MPMoviePlayerController *_videoPlayer;
    
}
@property (nonatomic,retain) MPMoviePlayerController *videoPlayer;
@property (nonatomic,retain) NSURL *movieURL;

- (IBAction)clickPickImagesButton:(id)sender;
- (IBAction)clickProductsButton:(id)sender;
- (IBAction)clickVideoButton:(id)sender;


@end
