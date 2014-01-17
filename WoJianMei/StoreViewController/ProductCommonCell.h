//
//  ProductCommonCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/17/14.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewCell.h"

@interface ProductCommonCell : PPTableViewCell
{
    NSString    *_clickUrlString;
    UIImageView *_imageViewContent;
    UIImageView *_imageViewBG;
    UIButton    *_actionButton;
    UILabel     *_nameLabel;
    UIImageView *_devideLineImageView;
    UILabel     *_totalSaleCountLable;
    UILabel     *_priceLabel;
    
}
@property (retain, nonatomic) NSString* clickUrlString;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewContent;
@property (retain, nonatomic) IBOutlet UIImageView *imageViewBG;
@property (retain, nonatomic) IBOutlet UIButton *actionButton;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;

@property (retain, nonatomic) IBOutlet UIImageView *devideLineImageView;

@property (retain, nonatomic) IBOutlet UILabel *totalSaleCountLable;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;



-(void)initMaskViews;
+ (id)createCellWithIdentifier:(NSString *)identifier
                      delegate:(id)delegate;




@end
