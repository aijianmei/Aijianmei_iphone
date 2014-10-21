//
//  ProductDetailCell.m
//  groupbuy
//
//  Created by  on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ArticleCell.h"
#import "Article.h"
#import "WorkOut.h"
#import "UIImageView+WebCache.h"
#import "TimeUtils.h"
#import "UIImageView+TKCategory.h"

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@implementation ArticleCell

@synthesize titleLabel = _titleLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize imgView = _imgView;
@synthesize releasedTimeLabel = _releasedTimeLabel;
@synthesize commentLabel = _commentLabel;
@synthesize delegate ;

- (void)dealloc {

    [super dealloc];
    [_titleLabel release];
    [_descriptionLabel release];
    [_imgView release];
    [_releasedTimeLabel release];
    [_commentLabel release];
}

- (void)setCellStyle
{
    self.selectionStyle = UITableViewCellSelectionStyleGray;		   
}

- (void)awakeFromNib{
    [self setCellStyle];
}

// just replace ProductDetailCell by the new Cell Class Name
+ (ArticleCell*) createCell:(id)delegate
{
     NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ArticleCell" owner:self options:nil];
    
    if (isPad) {
         topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ArticleCell ~ipad" owner:self options:nil];
        
        
        
    }
    
   
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <ArticleCell> but cannot find cell object from Nib");
        return nil;
    }
    
    ((ArticleCell*)[topLevelObjects objectAtIndex:0]).delegate = delegate;
    
    return (ArticleCell*)[topLevelObjects objectAtIndex:0];

}

+ (NSString*)getCellIdentifier
{
    
    if (isPad) {
        return  @"ArticleCell ~ipad";
    }
    return @"ArticleCell";
}

+ (CGFloat)getCellHeight
{
    
    if (isPad) {
        return 157.0f;
    }
    return 147.0f;

}

- (void)setCellInfo:(Article *)article
{
//      //set articles cells
//      [self.titleLabel setText:article.title];
//      [self.descriptionLabel setText:article.brief];
//    
//    
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:article.img] placeholderImage:[UIImage imageNamed:@"place_holder.png"] options:SDWebImageCacheMemoryOnly];
//    
//    
//    CALayer * layer = [self.imgView layer];
//    layer.borderColor = [[UIColor whiteColor] CGColor];
//    layer.borderWidth = 3.0f;
//    
//    //添加四个边阴影
//    _imgView.layer.shadowColor = [UIColor blackColor].CGColor;
//    _imgView.layer.shadowOffset = CGSizeMake(0, 0);
//    _imgView.layer.shadowOpacity = 0.5;
//    _imgView.layer.shadowRadius = 10.0;
//    
//    //给iamgeview添加阴影 < wbr > 和边框
//    
//    //添加两个边阴影
//    _imgView.layer.shadowColor = [UIColor blackColor].CGColor;
//    _imgView.layer.shadowOffset = CGSizeMake(4, 4);
//    _imgView.layer.shadowOpacity = 0.5;
//    _imgView.layer.shadowRadius = 2.0;
//    
//    
//      [self.commentLabel setText:article.commentCount];
//      [self.releasedTimeLabel setText:article.timestamp];
//    
//      PPDebug(@"%@",article.create_time);
}


@end
