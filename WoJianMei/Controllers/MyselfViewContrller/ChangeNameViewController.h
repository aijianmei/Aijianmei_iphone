//
//  ChangeNameViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/9/13.
//
//

#import "PPTableViewController.h"

@interface ChangeNameViewController : PPTableViewController<UITextFieldDelegate>{


    UITextField *_nameTextField;
    
}
@property (nonatomic,retain) UITextField *nameTextField;

@end
