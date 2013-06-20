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

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@implementation ArticleCell

@synthesize titleLabel = _titleLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize imgView = _imgView;
@synthesize releasedTimeLabel = _releasedTimeLabel;
@synthesize commentLabel = _commentLabel;

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
     return  nil;    

}

+ (NSString*)getCellIdentifier
{
    static NSString *string = @"ArticleCell";
    return  string;
}

+ (CGFloat)getCellHeight
{
    if (isPad) {
        return 210.f;
    }
    return 147.0f;
}

- (void)setCellInfo:(Article *)article
{
      //set articles cells
      [self.titleLabel setText:article.title];
      [self.descriptionLabel setText:article.brief];
      [self.imgView setImageWithURL:[NSURL URLWithString:article.img] placeholderImage:[UIImage imageNamed:@"11"]];
      [self.commentLabel setText:article.commentCount];
      [self.releasedTimeLabel setText:article.create_time];
}


@end
