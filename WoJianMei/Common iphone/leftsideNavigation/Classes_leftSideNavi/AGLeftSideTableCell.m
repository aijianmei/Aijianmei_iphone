//
//  AGLeftSideTableCell.m
//  AGShareSDKDemo
//
//  Created by 冯 鸿杰 on 13-1-30.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import "AGLeftSideTableCell.h"
#import "UITableViewCellUtil.h"

@implementation AGLeftSideTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {        
        [self setSelected:NO];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    int point = self.accessoryView.frame.origin.y;
    self.accessoryView.frame = CGRectMake(200, point, self.accessoryView.frame.size.width, self.accessoryView.frame.size.height);
}








@end
