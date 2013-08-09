//
//  PostViewCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/6/13.
//
//

#import <UIKit/UIKit.h>
#import "PPDebug.h"

@interface PostViewCell : UITableViewCell<UITextFieldDelegate>
{
    UITextField *_nameTextField;

}
@property (nonatomic,retain) UITextField *nameTextField;

@end
