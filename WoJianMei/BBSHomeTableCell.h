//
//  BBSHomeTableCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "PPTableViewCell.h"

@interface BBSHomeTableCell : PPTableViewCell
{
    UILabel        *_titleContent;
    UIImageView    *_avatar;
    UILabel        *_nickName;
    UILabel        *_gender;
    UILabel        *_fitnessLevel;
    UILabel        *_timestamp;
    UILabel        *_visitTimes;
    UILabel          *_comments;
    UIImageView         *_image;
    UIButton        *_imageMask;
    UIButton       *_avatarMask;
}

@property (retain, nonatomic) IBOutlet UILabel *titleContent;
@property (retain, nonatomic) IBOutlet UIImageView   *avatar;
@property (retain, nonatomic) IBOutlet UILabel     *nickName;
@property (retain, nonatomic) IBOutlet UILabel       *gender;
@property (retain, nonatomic) IBOutlet UILabel *fitnessLevel;
@property (retain, nonatomic) IBOutlet UILabel    *timestamp;
@property (retain, nonatomic) IBOutlet UILabel   *visitTimes;
@property (retain, nonatomic) IBOutlet UILabel     *comments;
@property (retain, nonatomic) IBOutlet UIImageView *bgImageView;
@property (retain, nonatomic) UIButton           *avatarMask;
@property (retain, nonatomic) UIButton            *imageMask;



+ (id)createCellWithIdentifier:(NSString *)identifier
                      delegate:(id)delegate;


@end
