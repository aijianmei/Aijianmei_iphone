//
//  BBSHomeTableCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "BBSHomeTableCell.h"
#import "PPDebug.h"
#import "PostStatus.h"


@implementation BBSHomeTableCell

@synthesize avatar = _avatar;
@synthesize nickName = _nickName;
@synthesize gender =_gender;
@synthesize fitnessLevel =_fitnessLevel;
@synthesize titleContent = _titleContent;
@synthesize timestamp = _timestamp;
@synthesize imageMask = _imageMask;
@synthesize imageView =_imageView;


@synthesize avatarMask = _avatarMask;

@synthesize videoPlayer =_videoPlayer;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)dealloc
{
    PPRelease(_avatar);
    PPRelease(_nickName);
    PPRelease(_titleContent);
    PPRelease(_textContent);
    PPRelease(_timestamp);
    PPRelease(_imageView);
    PPRelease(_imageMask);
    PPRelease(_avatarMask);
    PPRelease(_bgImageView);
    
    
    PPRelease(_videoPlayer);

    [super dealloc];
}


- (void)initMaskViews
{
    [self.textContent setText:nil];
    
}

- (void)setUseContentLabel:(BOOL)useContentLabel
{

}



+ (id)createCellWithIdentifier:(NSString *)identifier
                      delegate:(id)delegate
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
    
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        PPDebug(@"create %@ but cannot find cell object from Nib", identifier);
        return nil;
    }
    
    BBSHomeTableCell  *cell = (BBSHomeTableCell *)[topLevelObjects objectAtIndex:0];
    cell.delegate = delegate;
    
    [cell initMaskViews];
    
    return cell;
    
}




- (void)updateContentWithPostStatus:(PostStatus *)status{
    
    
    

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
