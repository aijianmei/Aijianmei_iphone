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
#import "DeviceDetection.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "BBSImageManager.h"


#define IMAGE_HEIGHT (ISIPAD ? 80 * 2.33 : 80)
#define SPACE_BETWEEN_TITLE_AND_TOP_ELDGE (ISIPAD ? 10 * 2.33 : 10)
#define SPACE_BETWEEN_TITLE_AND_NAME (ISIPAD ? 25 * 2.33 : 25)
#define SPACE_BETWEEN_NAME_AND_TEXTCONTENT (ISIPAD ? 40 * 2.33 : 20)
#define SPACE_BETWEEN_TEXTCONENT_AND_IMAGE_OR_VIDEO (ISIPAD ? 40 * 2.33 : 20)
#define SPACE_BETWEEN_IMAGE_OR_VIDEO_AND_TIMELABEL (ISIPAD ? 40 * 2.33 : 20)



#define VideoPlayerHeight   120
#define VideoPlayerWidth    250


@implementation BBSHomeCell
@synthesize post =_post;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc{
    
    [_post release];
    [super dealloc];
}

-(void)initMaskViews
{

    
}


+ (id)createCell:(id)delegate
{
    BBSHomeCell *cell = [BBSHomeTableCell createCellWithIdentifier:[self getCellIdentifier] delegate:delegate];
    [cell initMaskViews];
    return cell;
}

+ (NSString*)getCellIdentifier
{
    return @"BBSHomeCell";
}


+ (CGFloat)heightForTitleText:(NSString *)text
{
    
    
    if (text==nil) {
        return 0;
    }
    //size
    CGSize size = CGSizeMake(320, 50);

    
    //Dictionary
    NSAttributedString *attrStr = [[[NSAttributedString alloc] initWithString:text] autorelease];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0
                                    effectiveRange:&range];
    
    CGRect frame =[text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:dic
                                     context:nil];
    CGFloat titleHeight = CGRectGetHeight(frame);
    
    NSLog(@"h = %f", CGRectGetHeight(frame));
    NSLog(@"w = %f", CGRectGetWidth(frame));
    return titleHeight;
}
+ (CGFloat)heightForTopBasicInfoText:(NSString *)text
{
    if (text==nil) {
        return 0;
    }
    //size
    CGSize size = CGSizeMake(71, 21);
    
    //Dictionary
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0
                                    effectiveRange:&range];
    
    CGRect frame =[text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:dic
                                     context:nil];
    CGFloat heightForTopBasicInfoText = CGRectGetHeight(frame);
    
    NSLog(@"h = %f", CGRectGetHeight(frame));
    NSLog(@"w = %f", CGRectGetWidth(frame));
    
    return heightForTopBasicInfoText;
}
+ (CGFloat)heightForContentText:(NSString *)text
{
    if (text==nil) {
        return 0;
    }
    //size
    CGSize size = CGSizeMake(320, 100);
    
    //Dictionary
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0
                                    effectiveRange:&range];
    
    CGRect frame =[text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:dic
                                     context:nil];
    CGFloat heightForContentText = CGRectGetHeight(frame);
    
    NSLog(@"h = %f", CGRectGetHeight(frame));
    NSLog(@"w = %f", CGRectGetWidth(frame));
    return heightForContentText;

}
+ (CGFloat)heightForImages:(PostStatus *)postStatus
{
    CGSize size = CGSizeMake(80, 80);
    return size.height;
}
+ (CGFloat)heightForVideo:(PostStatus *)postStatus
{
    CGSize size = CGSizeMake(80, 80);
    return size.height;
}

+ (CGFloat)heightForBottomBasicInfoText:(NSString *)text
{
    if (text==nil) {
        return 0;
    }
    //size
    CGSize size = CGSizeMake(71, 21);
    
    //Dictionary
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0
                                    effectiveRange:&range];
    
    CGRect frame =[text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:dic
                                     context:nil];
    CGFloat heightForBottomBasicInfoText = CGRectGetHeight(frame);
    
    NSLog(@"h = %f", CGRectGetHeight(frame));
    NSLog(@"w = %f", CGRectGetWidth(frame));
    
    return heightForBottomBasicInfoText;

}

+ (CGFloat)getCellHeightWithBBSPost:(PostStatus *)post{
    
    
    CGFloat titleHeight = [BBSHomeCell heightForTitleText:post.content];
    CGFloat topBasicInfoHeight = [BBSHomeCell heightForTopBasicInfoText:post.content];
    CGFloat contentHeight = [BBSHomeCell heightForContentText:@"sf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadDDDDDDDDDDDDDDDD"];
    CGFloat imageHeight = [BBSHomeCell heightForImages:post];
//    CGFloat videoHeight = [BBSHomeCell heightForVideo:post];
    CGFloat bottomBasicInfoHeight = [BBSHomeCell heightForBottomBasicInfoText:post.content];

    
    CGFloat height = titleHeight        +
                     topBasicInfoHeight +
                     contentHeight      +
                     imageHeight        +
//                     videoHeight        +
                     bottomBasicInfoHeight +
          SPACE_BETWEEN_TITLE_AND_TOP_ELDGE  +
          SPACE_BETWEEN_IMAGE_OR_VIDEO_AND_TIMELABEL + SPACE_BETWEEN_NAME_AND_TEXTCONTENT+ SPACE_BETWEEN_TITLE_AND_NAME + SPACE_BETWEEN_TEXTCONENT_AND_IMAGE_OR_VIDEO
    ;
    return  height;
}

- (void)updateCellWithBBSPost:(PostStatus *)post{
     self.post =post;
    [self updateContentWithPostStatus:post];
}


-(void)updateContentWithPostStatus:(PostStatus *)post{
    
    //Title
    [self.titleContent setText:post.content];
    CGFloat y = SPACE_BETWEEN_TITLE_AND_TOP_ELDGE;
    CGFloat titleHeight =[BBSHomeCell heightForTitleText:post.content];
    [self resetView:self.titleContent y:y height:titleHeight];
    [self.titleContent setBackgroundColor:[UIColor greenColor]];

    
    //Avatar
    [self.avatar setImageWithURL:[NSURL URLWithString:post.avatarProfileUrl] placeholderImage:[ImageManager avatarPlacHolderImage]];
    
    
    
    //topInfo
    [self.nickName setText:post.userName];
    [self.gender setText:@"女"];
    [self.fitnessLevel setText:@"健身女汉子"];


    CGFloat name_y = SPACE_BETWEEN_TITLE_AND_NAME + CGRectGetMaxY(self.titleContent.frame);
    CGFloat name_Height =[BBSHomeCell heightForTopBasicInfoText:post.userName];
    
    [self resetView:self.nickName y:name_y height:name_Height];
    [self.nickName setBackgroundColor:[UIColor blueColor]];
    
    [self resetView:self.timestamp y:name_y height:name_Height];
    [self.gender setBackgroundColor:[UIColor blueColor]];

    [self resetView:self.timestamp y:name_y height:name_Height];
    [self.fitnessLevel setBackgroundColor:[UIColor blueColor]];
    
    
    //textConent
    [self.textContent setText:@"sf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadsasf;asfjdasfjajsd;f;jasjfjasf;asf;as;df;as;f;asfasf;asfadlsfalsfladlsfals;dfladlsfladslfadDDDDDDDDDDDDDDDD"];
    CGFloat content_y = SPACE_BETWEEN_NAME_AND_TEXTCONTENT + CGRectGetMaxY(self.nickName.frame);
    CGFloat contentHeight =[BBSHomeCell heightForContentText:self.textContent.text];
    [self resetView:self.textContent y:content_y height:contentHeight];
    [self.textContent setBackgroundColor:[UIColor redColor]];
    
    
    
    //Image Content
    if (post.imageurl) {
        [self.imageView setImageWithURL:[NSURL URLWithString:post.imageurl]
                       placeholderImage:[UIImage imageNamed:@"place_holder@2x.png"]
                                success:^(UIImage *image, BOOL cached)
         {
             [self updateImageViewFrameWithImage:image];
         }
                                failure:^(NSError *error)
         {
             
         }];
        
        
        //reset image frame center
        self.imageView.hidden = NO;
        
       CGFloat y = CGRectGetMaxY(self.textContent.frame) + SPACE_BETWEEN_TEXTCONENT_AND_IMAGE_OR_VIDEO;
        
        CGFloat width = IMAGE_HEIGHT;
        CGFloat height = IMAGE_HEIGHT;
        CGFloat x =  CGRectGetMinX(self.imageView.frame);
        self.imageView.frame = CGRectMake(x, y, width, height);
//
//        
//        //set source frame
//        y = CGRectGetMaxY(self.imageView.frame) + SPACE_IMAGE_SOURCE;
//        height = [BBSHomeCell heightForContentText:post.content];
//        [self resetView:self.source y:y height:height];
    }
    
    
    if (post.videoURL) {
        [self playVideoWithUrl:[NSURL URLWithString:post.videoURL]];
    }

    
    [self.timestamp setText:post.timestamp];
    [self.visitTimes setText:@"2242人访问"];
    [self.comments setText:@"21评论"];
    
    CGFloat time_y = SPACE_BETWEEN_IMAGE_OR_VIDEO_AND_TIMELABEL + CGRectGetMaxY(self.imageView.frame);
    CGFloat time_Height =[BBSHomeCell heightForTopBasicInfoText:post.userName];
    [self resetView:self.timestamp y:time_y height:time_Height];
    [self.timestamp setBackgroundColor:[UIColor orangeColor]];
    
    [self resetView:self.visitTimes y:time_y height:time_Height];
    [self.visitTimes setBackgroundColor:[UIColor orangeColor]];
    
    [self resetView:self.comments y:time_y height:time_Height];
    [self.comments setBackgroundColor:[UIColor orangeColor]];
    
}

- (void)resetView:(UIView *)view y:(CGFloat)y height:(CGFloat)height
{
    CGRect frame = view.frame;
    frame.size.height = height;
    frame.origin.y = y;
    view.frame = frame;
}

- (void)updateImageViewFrameWithImage:(UIImage *)image
{
    if (image) {
//        CGRect frame = (self.useContentLabel ? self.content.frame : self.contentTextView.frame);
        CGRect frame = self.imageView.frame;
        CGSize size = [[BBSImageManager defaultManager]
                       image:image
                       sizeWithConstHeight:IMAGE_HEIGHT
                       maxWidth:CGRectGetWidth(frame)];
        frame = self.imageView.frame;
        frame.size = size;
        self.imageView.frame = frame;
    }
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
