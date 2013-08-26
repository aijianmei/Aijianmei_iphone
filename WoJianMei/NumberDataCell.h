//
//  NumberDataCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import "PPTableViewCell.h"

@class NumberDataCell;
@class NumberData;

@protocol NumberDataCellDelegate <NSObject>

- (void)didClickCellTextField:(UITextField *)textField atIndex:(NSIndexPath*)indexPath;
@end



@interface NumberDataCell : PPTableViewCell<UITextFieldDelegate>

{
    
    UILabel     *_groupNumber;
    UITextField *_numberField;
    UITextField *_weightField;
    UITextField *_timeField;
    UILabel     *_caloriesLabel;

    
}
@property (nonatomic,retain) IBOutlet UILabel *caloriesLabel;
@property (nonatomic,retain) IBOutlet UILabel *groupNumber;
@property (nonatomic,retain) IBOutlet UITextField *numberField;
@property (nonatomic,retain) IBOutlet UITextField *weightField;
@property (nonatomic,retain) IBOutlet UITextField *timeField;
@property (nonatomic,assign) id <NumberDataCellDelegate> delegate ;



+ (NumberDataCell*) createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;
- (void)setCellInfo:(NumberData *)numberData;





@end
