//
//  StatusCell.h
//  zjtSinaWeiboClient
//
//  Created by jianting zhu on 12-1-5.
//  Copyright (c) 2012年 Dunbar Science & Technology. All rights reserved.
//

#import "PPTableViewCell.h"
#import "PostStatus.h"

@class StatusCell;

@protocol StatusCellDelegate <NSObject>

-(void)cellImageDidTaped:(StatusCell *)theCell image:(UIImage*)image;
-(void)cellLikeButtonDidClick:(StatusCell *)theCell;
-(void)cellAvatarButtonDidClick:(StatusCell *)theCell;

@end

@interface StatusCell : PPTableViewCell
{
    
    UIButton *avatarImageButton;
    UITextView *contentTF;
    UILabel *userNameLB;
    UIImageView *bgImage;
    UIImageView *contentImage;
    UIView *retwitterMainV;
    UIImageView *retwitterBgImage;
    UITextView *retwitterContentTF;
    UIImageView *retwitterContentImage;
    UIButton *likeButton;
    UILabel *likeCountLabel;
    
    NSIndexPath *cellIndexPath;
}
@property (retain, nonatomic) IBOutlet UILabel *countLB;
@property (retain, nonatomic) IBOutlet UIButton *avatarImageButton;
@property (retain, nonatomic) IBOutlet UITextView *contentTF;
@property (retain, nonatomic) IBOutlet UILabel *userNameLB;
@property (retain, nonatomic) IBOutlet UIImageView *bgImage;
@property (retain, nonatomic) IBOutlet UIImageView *contentImage;
@property (retain, nonatomic) IBOutlet UIView *retwitterMainV;
@property (retain, nonatomic) IBOutlet UIImageView *retwitterBgImage;
@property (retain, nonatomic) IBOutlet UITextView *retwitterContentTF;
@property (retain, nonatomic) IBOutlet UIImageView *retwitterContentImage;
@property (assign, nonatomic) id<StatusCellDelegate> delegate;
@property (retain, nonatomic) NSIndexPath *cellIndexPath;
@property (retain, nonatomic) IBOutlet UILabel *fromLB;
@property (retain, nonatomic) IBOutlet UILabel *timeLB;
@property (retain,nonatomic)  IBOutlet UIButton *likeButton;
@property (retain,nonatomic) IBOutlet UILabel *likeCountLabel;


-(CGFloat)setTFHeightWithImage:(BOOL)hasImage haveRetwitterImage:(BOOL)haveRetwitterImage;
-(void)setupCell:(PostStatus*)status avatarImageData:(NSData*)avatarData contentImageData:(NSData*)imageData;




+ (StatusCell*) createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;




@end
