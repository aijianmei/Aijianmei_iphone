//
//  ChangeNameCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/12/13.
//
//

#import "ChangeNameCell.h"
#import "UserService.h"
#import "User.h"

@implementation ChangeNameCell
@synthesize nameTextField =_nameTextField;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(5.0f, 12.0f, 250.0f,32.0f)];
        _nameTextField.delegate = self;
        [_nameTextField setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_nameTextField];
        [_nameTextField setText:@"输入用户名"];
        [_nameTextField becomeFirstResponder];
        
        
    }
    return self;
}



-(void)dealloc{
    [_nameTextField release];
    [super dealloc];
}


- (void)clickDeleteButton:(id)sender {
    [_nameTextField setText:@""];
}


#pragma mark -
#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    User *user =[[UserService defaultService] user];
    user.name = textField.text;
    [[UserService defaultService] setUser:user];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
