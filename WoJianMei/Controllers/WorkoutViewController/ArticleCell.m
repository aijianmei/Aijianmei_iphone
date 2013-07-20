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
      [self.imgView setImageWithURL:[NSURL URLWithString:article.img] placeholderImage:[UIImage imageNamed:@"11.png"]];
      [self.commentLabel setText:article.commentCount];
      [self.releasedTimeLabel setText:article.create_time];
    
    PPDebug(@"%@",article.create_time);
    


    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *mydate = [dateFormatter dateFromString:@"2001-08-04 16:01:03"];
    NSLog(@"%@", mydate);
    [dateFormatter release];
    
    
    NSString * str = chineseBeforeTime(mydate);
    
    PPDebug(@"距离时间: %@",str);
    
    //删除日期以后的字符串
    NSMutableString *articleDate = [[NSMutableString alloc]initWithString:article.create_time];
    [articleDate deleteCharactersInRange:NSMakeRange(10,1)];
    NSLog(articleDate,nil);
    
    //获取当日时间
    NSMutableString *articletime = [[NSMutableString alloc]initWithString:article.create_time];
    [articletime deleteCharactersInRange:NSMakeRange(10,1)];
    NSLog(articletime,nil);
    
    
    NSMutableString *articletime1 = [[NSMutableString alloc]initWithString:articletime];
    [articletime1 deleteCharactersInRange:NSMakeRange(1,1)];
    NSLog(articletime1,nil);
    

    
    
    
    
    

}


@end
