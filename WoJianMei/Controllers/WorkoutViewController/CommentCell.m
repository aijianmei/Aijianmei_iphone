//
//  CommentCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/23/13.
//
//

#import "CommentCell.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (Comment*) createCell:(id)delegate{
    return  nil;
}
+ (NSString*)getCellIdentifier
{
    static NSString *string = @"ArticleCell";
    return  string;
}

+ (CGFloat)getCellHeight
{
   
    return 47.0f;
}
- (void)setCellInfo:(Comment *)comment{
    
}

@end
