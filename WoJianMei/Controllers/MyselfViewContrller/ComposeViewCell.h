//
//  ComePoseViewCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/21/13.
//
//
#import "PPTableViewCell.h"
#import "ComposeViewCellInfo.h"

@class ComposeViewCellInfo;

@protocol ComposeViewCellDelegate <NSObject>
@optional

- (void)didClickConnectButton:(id)sender atIndex:(NSIndexPath*)indexPath;

@end


@interface ComposeViewCell : PPTableViewCell

{
    
    UIImageView       *_avatarImageView;
    UILabel                 *_nameLabel;
    UIButton             *_connectButton;
    
}
@property (nonatomic,retain) IBOutlet UIImageView *avatarImageView;
@property (nonatomic,retain) IBOutlet UILabel           *nameLabel;
@property (nonatomic,retain) IBOutlet UIButton       *connectButton;


- (void)setCellInfo:(ComposeViewCellInfo *)composeViewCellInfo indexPath:(NSIndexPath *)aIndexPath;

- (IBAction)clickConnectButton:(id)sender ;


@end
