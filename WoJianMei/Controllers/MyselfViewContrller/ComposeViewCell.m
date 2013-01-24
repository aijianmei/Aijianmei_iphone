//
//  ComePoseViewCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/21/13.
//
//

#import "ComposeViewCell.h"
#import "ComposeViewCellInfo.h"
#import "UIImageUtil.h"


@implementation ComposeViewCell
@synthesize avatarImageView =_avatarImageView;
@synthesize nameLabel =_nameLabel;
@synthesize connectButton =_connectButton;

-(void)dealloc{
    
    
    [_avatarImageView release];
    [_nameLabel release];
    [_connectButton release];
    [super dealloc];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (NSString*)getCellIdentifier
{
    return @"ComposeCell";
}

+ (CGFloat)getCellHeight
{
    return 53.0f;
}



- (void)setCellInfo:(ComposeViewCellInfo *)composeViewCellInfo indexPath:(NSIndexPath *)aIndexPath
{
    
     self.indexPath = aIndexPath;
    
    ////
    UIImage *avatarImage = [UIImage imageNamed:composeViewCellInfo.avatarImageName];
    [self.avatarImageView setImage:avatarImage];
    
    
    
     /////
    [self.nameLabel setText:composeViewCellInfo.name];
    
    
    
    ////
    UIImage *connectButtonImage = [UIImage imageNamed:composeViewCellInfo.connectButtonName];
    [self.connectButton setImage:connectButtonImage forState:UIControlStateNormal];
    
    
}

- (IBAction)clickConnectButton:(id)sender ;
{
    
    if ([delegate respondsToSelector:(@selector(didClickConnectButton:atIndex:))]) {
        [delegate didClickConnectButton:sender atIndex:self.indexPath];
    }
}


@end
