//
//  SinaUserCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/12/13.
//
//

#import "PPTableViewCell.h"



@class SinaUser;

@protocol SinaUserCellDelegate <NSObject>
@optional
- (void)didClickInviteButton:(id)sender atIndex:(NSIndexPath*)indexPath;

@end

@interface SinaUserCell : PPTableViewCell
{
    
    UIImageView *_avatarImageView ;
    UILabel *_nameLabel;
    UIButton *_inviteButton;
    
   
}
@property (nonatomic,retain) IBOutlet UIImageView *avatarImageView;
@property (nonatomic,retain) IBOutlet UILabel *nameLabel;
@property (nonatomic,retain) IBOutlet UIButton *inviteButton;







- (void)setCellInfo:(SinaUser *)sinaUser indexPath:(NSIndexPath *)aIndexPath;

- (IBAction)clickInvitedButton:(id)sender ;

@end
