//
//  BBSHomeCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "BBSHomeCell.h"
#import "PPDebug.h"
#import "BBSHomeTableCell.h"
#import "PostStatus.h"
#import "UIImageView+WebCache.h"
#import "ImageManager.h"

#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define VideoPlayerHeight   120
#define VideoPlayerWidth    250


@implementation BBSHomeCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (id)createCell:(id)delegate
{
    BBSHomeCell *cell = [BBSHomeTableCell createCellWithIdentifier:[self getCellIdentifier] delegate:delegate];
    return cell;
}

+ (NSString*)getCellIdentifier
{
    return @"BBSHomeCell";
}


+ (CGFloat)heightForTitleText:(NSString *)text
{
    CGSize size = CGSizeMake(100, 100);
    return size.height;
}

+ (CGFloat)heightForContentText:(NSString *)text
{
    CGSize size = CGSizeMake(100, 100);
    return size.height;
}

+ (CGFloat)heightForSourceText:(NSString *)text
{
    CGSize size = CGSizeMake(100, 100);
    return size.height;
}


+ (CGFloat)getCellHeightWithBBSPost:(PostStatus *)post{
    
    CGFloat sourceHeight = [BBSHomeCell heightForSourceText:post.content];
    
    CGFloat contentHeight = [BBSHomeCell heightForContentText:post.content];
    
    CGFloat titleHeight = [BBSHomeCell heightForTitleText:post.content];
    
    
    CGFloat height = contentHeight + sourceHeight + titleHeight;
    
    
    return 147.0f + height;
}

- (void)updateCellWithBBSPost:(PostStatus *)post{

    [self.timestamp setText:post.timestamp];
    [self.avatar setImageWithURL:[NSURL URLWithString:post.avatarProfileUrl] placeholderImage:[ImageManager avatarPlacHolderImage]];
    [self.titleContent setText:post.content];
    [self.nickName setText:post.userName];
    
    
    if (post.imageurl) {
        [self.imageView setImageWithURL:[NSURL URLWithString:post.imageurl] placeholderImage:[UIImage imageNamed:@"place_holder@2x.png"]];
    }
    
    
    if (post.videoURL) {
        [self playVideoWithUrl:[NSURL URLWithString:post.videoURL]];
    }
    
    
    [self updateContentWithPostStatus:post];
    
}


-(void)updateContentWithPostStatus:(PostStatus *)status{
    
    [self.timestamp  setFrame:CGRectMake(CGRectGetMinX(self.timestamp.frame),130 + 100,CGRectGetWidth(self.timestamp.frame),CGRectGetHeight(self.timestamp.frame))];
    
    [self.visitTimes  setFrame:CGRectMake(CGRectGetMinX(self.visitTimes.frame),230,CGRectGetWidth(self.visitTimes.frame),CGRectGetHeight(self.visitTimes.frame))];
    
    [self.comments  setFrame:CGRectMake(CGRectGetMinX(self.comments.frame),230 ,CGRectGetWidth(self.comments.frame),CGRectGetHeight(self.comments.frame))];
    
}


-(void)playVideoWithUrl:(NSURL*)videoURL{

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:self.videoPlayer];
        
    
    


    
        self.videoPlayer=[[MPMoviePlayerController alloc] initWithContentURL:videoURL];
        [self.videoPlayer.view setFrame:CGRectMake (70,67,VideoPlayerWidth,VideoPlayerHeight)];
        [self.videoPlayer.view setBackgroundColor:[UIColor redColor]];
        
        self.videoPlayer.movieSourceType=MPMovieSourceTypeFile;
        //本地文件播放要设置视频资源为文件类型资源，若设置为stream 则会错误
        [self.videoPlayer prepareToPlay];
        if(self.videoPlayer.isPreparedToPlay)
        {
            [self.videoPlayer play];
        }
    
        [self addSubview:self.videoPlayer.view];
}

- (void)moviePlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //    [self.videoPlayer stop];
    //    [self.videoPlayer.view removeFromSuperview];
    //    self.videoPlayer = nil;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
