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

+ (CGFloat)getCellHeightWithBBSPost:(PostStatus *)post{
    
    if (post.videoURL) {
        return 147.0f + 100.0f;
    }
    return 147.0f;
}

- (void)updateCellWithBBSPost:(PostStatus *)post{
    
    
    [self.timestamp setText:post.timestamp];
    [self.avatar setImageWithURL:[NSURL URLWithString:post.avatarProfileUrl] placeholderImage:[ImageManager avatarPlacHolderImage]];
    [self.comments setText:post.content];
    [self.nickName setText:post.userName];
    [self.imageView setImageWithURL:[NSURL URLWithString:post.imageurl] placeholderImage:[UIImage imageNamed:@"place_holder@2x.png"]];
    
    
    if (post.videoURL) {
        [self updateContentWithPostStatus:post];
    }
    
    if (post.videoURL) {
        [self playVideoWithUrl:[NSURL URLWithString:post.videoURL]];

   }
}


-(void)updateContentWithPostStatus:(PostStatus *)status{
 
        
    [self.imageView setHidden:YES];
    
    

}


-(void)playVideoWithUrl:(NSURL*)videoURL{

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:self.videoPlayer];
        
    
    
    
        self.videoPlayer=[[MPMoviePlayerController alloc] initWithContentURL:videoURL];
        [self.videoPlayer.view setFrame:CGRectMake (70,67,200,70)];
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
