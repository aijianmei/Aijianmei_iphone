//
//  ChangeDescriptionViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/9/13.
//
//

#import "PPViewController.h"

@interface ChangeDescriptionViewController : PPViewController<UITextFieldDelegate>

{
    UITextField *_descriptionTextField;

}
@property (nonatomic,retain) IBOutlet UITextField *descriptionTextField;


@end
