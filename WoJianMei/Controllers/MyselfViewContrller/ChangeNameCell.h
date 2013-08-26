//
//  ChangeNameCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/12/13.
//
//

#import <UIKit/UIKit.h>


@interface ChangeNameCell : UITableViewCell<UITextFieldDelegate>
{
    UITextField *_nameTextField;
}
@property (nonatomic,retain) UITextField *nameTextField;



@end
