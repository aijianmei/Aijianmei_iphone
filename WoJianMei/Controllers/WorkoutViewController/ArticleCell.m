//
//  ProductDetailCell.m
//  groupbuy
//
//  Created by  on 11-11-3.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "ArticleCell.h"
#import "Video.h"
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
    [_clickTimesLabel       release];
    
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



- (void)setCellInfo:(Video *)video
{
    //set videos cells
    

}


@end
