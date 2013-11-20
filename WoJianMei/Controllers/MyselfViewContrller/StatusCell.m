//
//  StatusCell.m
//  zjtSinaWeiboClient
//
//  Created by jianting zhu on 12-1-5.
//  Copyright (c) 2012年 Dunbar Science & Technology. All rights reserved.
//

#import "StatusCell.h"
#import "UIImageView+WebCache.h"

#define IMAGE_VIEW_HEIGHT 80.0f

@implementation StatusCell
@synthesize retwitterBgImage;
@synthesize retwitterContentTF;
@synthesize retwitterContentImage;
@synthesize countLB;
@synthesize avatarImageButton;
@synthesize contentTF;
@synthesize userNameLB;
@synthesize bgImage;
@synthesize contentImage;
@synthesize retwitterMainV;
@synthesize cellIndexPath;
@synthesize fromLB;
@synthesize timeLB;
@synthesize likeButton;
@synthesize likeCountLabel;

- (void)dealloc {
    [avatarImageButton release];
    [contentTF release];
    [userNameLB release];
    [bgImage release];
    [contentImage release];
    [retwitterMainV release];
    [retwitterBgImage release];
    [retwitterContentTF release];
    [retwitterContentImage release];
    [cellIndexPath release];
    [countLB release];
    [fromLB release];
    [timeLB release];
    [likeCountLabel
     release];
    [likeButton release];
    [super dealloc];
}



// just replace ProductDetailCell by the new Cell Class Name
+ (StatusCell*) createCell:(id)delegate
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"StatusCell" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <StatusCell> but cannot find cell object from Nib");
        return nil;
    }
    
    ((StatusCell*)[topLevelObjects objectAtIndex:0]).delegate = delegate;
    
    return (StatusCell*)[topLevelObjects objectAtIndex:0];
    
}


//
-(void)setupCell:(PostStatus *)status avatarImageData:(NSData *)avatarData contentImageData:(NSData *)imageData
{
    self.contentTF.text = status.content;
    self.userNameLB.text = status.userName;
    [self.avatarImageButton setImage:[UIImage imageWithData:avatarData]
                            forState:UIControlStateNormal];
    [self.avatarImageButton addTarget:self action:@selector(clickAvatarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    timeLB.text = status.timestamp;
    [self.likeCountLabel setText:status.like];
    [self.likeButton setImage:[UIImage imageNamed:@"like_icon.png"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"Press_like_icon.png"] forState:UIControlStateSelected];
    
    [self.likeButton addTarget:self action:@selector(clickLikeButton:) forControlEvents:UIControlEventTouchUpInside];

    self.retwitterMainV.hidden = YES;
    
    [self.contentImage setImage:[UIImage imageNamed:@"place_holder.png"]];
    if (![imageData isEqual:[NSNull null]]) {       self.contentImage.image = [UIImage imageWithData:imageData];
    }
    NSString *url = status.imageurl;
    self.contentImage.hidden = url != nil && [url length] != 0 ? NO : YES;
    
    
    
    //计算cell的高度，以及背景图的处理
    [self setTFHeightWithImage:url != nil && [url length] != 0 ? YES : NO
                haveRetwitterImage:NO];

}


//计算cell的高度，以及背景图的处理
-(CGFloat)setTFHeightWithImage:(BOOL)hasImage haveRetwitterImage:(BOOL)haveRetwitterImage
{
    [contentTF layoutIfNeeded];
    
    //博文Text
    CGRect frame = contentTF.frame;
    frame.size = contentTF.contentSize;
    contentTF.frame = frame;
    
    //正文的图片
    frame = contentImage.frame;
    frame.origin.y = contentTF.frame.size.height + contentTF.frame.origin.y - 5.0f;
    frame.size.height = IMAGE_VIEW_HEIGHT;
    contentImage.frame = frame;
    
    return contentTF.contentSize.height ;
}

-(IBAction)tapDetected:(id)sender
{
    UITapGestureRecognizer*tap = (UITapGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView*)tap.view;
    if ([imageView isEqual:contentImage]) {
        if ([delegate respondsToSelector:@selector(cellImageDidTaped:image:)]) 
        {
            [delegate cellImageDidTaped:self image:contentImage.image];
        }
    }
}

-(void)clickLikeButton:(id)sender{
    
    
    
    if ([delegate respondsToSelector:@selector(cellLikeButtonDidClick:)]){
        
        
        [delegate cellLikeButtonDidClick:self];
    }
}

-(void)clickAvatarButton:(id)sender{
    if ([delegate respondsToSelector:@selector(cellAvatarButtonDidClick:)]){
        [delegate cellAvatarButtonDidClick:self];
    }
}

+ (NSString*)getCellIdentifier{
    
    
    return  @"StatusCell";
}


+ (CGFloat)getCellHeight{
    
    return 100;

}


@end
