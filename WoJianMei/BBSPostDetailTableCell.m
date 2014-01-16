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

-(void)dealloc{
    
    [_avtarImageView release];
    _avtarImageView =nil;
    
    [_nameLabel release];
    _nameLabel =nil;
    
    [_fitnessLevel release];
    _fitnessLevel =nil;
    
     [_floorLabel release];
    _floorLabel = nil;
    
    [_textView release];
    _textView =nil;
    
    [_imgView release];
    _imgView =nil;
    
    
    [super dealloc];
}
-(void)initMaskViews{
    
    [self.imageView setImage:nil];
    [self.avtarImageView setImage:[UIImage imageNamed:@"xldl_1.png"]];
    

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

@end
