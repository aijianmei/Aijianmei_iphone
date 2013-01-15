//
//  SinaUserCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/12/13.
//
//

#import "SinaUserCell.h"
#import "SinaUser.h"


@implementation SinaUserCell
@synthesize  avatarImageView =_avatarImageView;
@synthesize nameLabel =_nameLabel;
@synthesize inviteButton =_inviteButton;


-(void)dealloc{

    
    [_avatarImageView release];
    [_nameLabel release];
    [_inviteButton release];
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
    return @"SinaUser";
}

+ (CGFloat)getCellHeight
{
    return 56.0f;
}

- (void)setCellInfo:(SinaUser *)sinaUser indexPath:(NSIndexPath *)aIndexPath;
{
    
    self.indexPath = aIndexPath;
    [self.avatarImageView setImage:sinaUser.avatarImage];
    [self.nameLabel setText:sinaUser.screenName];
    [self.inviteButton setImage:[UIImage imageNamed:@"menu-icon.png"] forState:UIControlStateNormal];
    
    
    
}



- (IBAction)clickInvitedButton:(id)sender {
    
       
    
    if ([delegate respondsToSelector:(@selector(didClickInviteButton:atIndex:))]) {
        [delegate didClickInviteButton:sender atIndex:self.indexPath];
    }
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
