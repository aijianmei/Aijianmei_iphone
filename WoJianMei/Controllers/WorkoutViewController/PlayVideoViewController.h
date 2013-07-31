//
//  PlayVideoViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/31/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"


@class Video;
@class SDSegmentedControl;

@interface PlayVideoViewController : PPViewController<UIWebViewDelegate>
{
     Video *_video;
     SDSegmentedControl *_segmentedController;
    
    
    UILabel *_titleLabel;
    UITextView *_descriptionView;
    UILabel *_timeLabel;
}

@property (nonatomic,retain) Video *video;
@property (nonatomic,retain) SDSegmentedControl *segmentedController;
@property (nonatomic,retain) IBOutlet UILabel *titleLabel;
@property (nonatomic,retain) IBOutlet UITextView  *descriptionView;
@property (nonatomic,retain) IBOutlet UILabel  *timeLabel;
@property (nonatomic, retain) UIWebView *playerWebView;




-(void)addTitleButtonsSegmentedController;


@end
