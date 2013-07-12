//
//  AddLabeCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/12/13.
//
//



@interface AddLabelCell : UITableViewCell<UITextFieldDelegate>
{
    UITextField *_nameTextField;
    
    
}
@property (nonatomic,retain) UITextField *nameTextField;



@end