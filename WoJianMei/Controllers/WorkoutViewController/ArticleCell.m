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



@implementation ArticleCell



@synthesize titleLabel           =_titleLabel;
@synthesize descriptionLabel     =_descriptionLabel;
@synthesize ImageButton          =_ImageButton;
@synthesize releasedTimeLabel    =_releasedTimeLabel;
@synthesize commentLabel         =_commentLabel;
@synthesize clickTimesLabel      =_clickTimesLabel;


@synthesize delegate;



- (void)dealloc {
    
    
    [_titleLabel        release];
    [_descriptionLabel  release];
    [_ImageButton       release];
    [_releasedTimeLabel release];
    [_commentLabel      release];
    [_clickTimesLabel   release];
    
    [super dealloc];
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
    return 147.0f;
}


//从网络下载图片
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

//将所下载的图片保存到本地
-(void) saveImage:(UIImage *)image
     withFileName:(NSString *)imageName
           ofType:(NSString *)extension
      inDirectory:(NSString *)directoryPath
{
    if ([[extension lowercaseString] isEqualToString:@"png"]) {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    } else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"]) {
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:nil];
    } else {
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        NSLog(@"文件后缀不认识");
    }
}

//读取本地保存的图片
-(UIImage *) loadImage:(NSString *)fileName
                ofType:(NSString *)extension
           inDirectory:(NSString *)directoryPath
{
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}


- (void)setCellInfo:(Article *)article
{
      //set articles cells
      [self.titleLabel setText:article.title];
      [self.descriptionLabel setText:article.brief];
      [self.ImageButton setImage:[self getImageFromURL:article.img] forState:UIControlStateNormal];
      [self.commentLabel setText:article.commentCount];
      [self.releasedTimeLabel setText:article.create_time];
}


@end
