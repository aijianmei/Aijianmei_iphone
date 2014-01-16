//
//  BBSPostDetailCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "PPTableViewCell.h"

@interface BBSPostDetailTableCell : PPTableViewCell{

    UIImageView *_avtarImageView;
    
    UILabel *_nameLabel;
    UILabel *_fitnessLevel;
    UILabel *_floorLabel;
    
    UITextView *_textView;
    
    UIImageView *_imgView;
    
}


@property(nonatomic,retain) IBOutlet UIImageView *avtarImageView;
@property(nonatomic,retain) IBOutlet UILabel *nameLabel;
@property(nonatomic,retain) IBOutlet UILabel *fitnessLevel;
@property(nonatomic,retain) IBOutlet UILabel *floorLabel;
@property(nonatomic,retain) IBOutlet UITextView *textView;
@property(nonatomic,retain) IBOutlet UIImageView *imgView;




+ (id)createCellWithIdentifier:(NSString *)identifier
                      delegate:(id)delegate;



@end
