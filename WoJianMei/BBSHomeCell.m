//
//  BBSHomeCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "BBSHomeCell.h"
#import "PPDebug.h"
#import "BBSHomeTableCell.h"



@implementation BBSHomeCell





- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (id)createCell:(id)delegate
{
    BBSHomeCell *cell = [BBSHomeTableCell createCellWithIdentifier:[self getCellIdentifier] delegate:delegate];
    return cell;
}

+ (NSString*)getCellIdentifier
{
    return @"BBSHomeCell";
}

+ (CGFloat)getCellHeightWithBBSPost:(PBBBSPost *)post{
    return 147.0f;
}

- (void)updateCellWithBBSPost:(PBBBSPost *)post{
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
