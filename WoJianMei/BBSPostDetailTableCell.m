//
//  BBSPostDetailCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "BBSPostDetailTableCell.h"
#import "PPDebug.h"

@implementation BBSPostDetailTableCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initMaskViews{
    
    

}

+ (id)createCellWithIdentifier:(NSString *)identifier
                      delegate:(id)delegate{

    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
    
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        PPDebug(@"create %@ but cannot find cell object from Nib", identifier);
        return nil;
    }
    
    BBSPostDetailTableCell  *cell = (BBSPostDetailTableCell *)[topLevelObjects objectAtIndex:0];
    cell.delegate = delegate;
    [cell initMaskViews];
    return cell;


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
