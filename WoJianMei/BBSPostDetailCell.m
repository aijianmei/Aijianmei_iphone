//
//  BBSPostDetailCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "BBSPostDetailCell.h"
#import "PostStatus.h"
#import "UIImageView+WebCache.h"



@implementation BBSPostDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)initViews{
    
    [self.imageView setImage:[UIImage imageNamed:@"xldl_1.png"]];
    [self.avtarImageView setImage:[UIImage imageNamed:@"xldl_1.png"]];
}

- (void)setUseContentLabel:(BOOL)useContentLabel{


}

+ (id)createCell:(id)delegate{
    BBSPostDetailCell *cell = [BBSPostDetailTableCell createCellWithIdentifier:[self getCellIdentifier] delegate:delegate];
    [cell initViews];
    [cell setUseContentLabel:NO];
    return cell;

}
+ (NSString*)getCellIdentifier{
    return @"BBSPostDetailCell";
}
+ (CGFloat)getCellHeightWithBBSPost:(PostStatus *)post{
    
    return 386.0f;

}

- (void)updateCellWithBBSPost:(PostStatus *)post{
    
    [self updateContentWithBBSPost:post];

}
- (void)updateContentWithBBSPost:(PostStatus *)post{
    
    [self.avtarImageView setImageWithURL:[NSURL URLWithString:post.avatarProfileUrl] placeholderImage:nil success:^(UIImage *image, BOOL cached) {
        
    } failure:^(NSError *error) {
        
    }];

    [self.textView setText:post.content];
    
    
    [self.imgView  setImageWithURL:[NSURL URLWithString:post.imageurl]];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
