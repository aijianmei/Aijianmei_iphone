//
//  PostViewCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/6/13.
//
//

#import "PostViewCell.h"
#import "PostService.h"
#import "PostStatus.h"

@implementation PostViewCell
@synthesize nameTextField =_nameTextField;


-(void)dealloc{
    [_nameTextField release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(5.0f, 12.0f, 250.0f,50.0f)];
        _nameTextField.delegate = self;
        [_nameTextField setTextAlignment:NSTextAlignmentLeft];
        [_nameTextField setBackground:[UIImage imageNamed:@"feedback_bg2.png"]];
        [self.contentView addSubview:_nameTextField];
        
    }
    return self;
}



#pragma mark -
#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    
    PostStatus *post =[[PostStatus alloc]init];
    [[PostService sharedService] setPostStatus:post];
     post.uid  =@"498";
    [post setContent:textField.text];
    [[PostService sharedService] setPostStatus:post];

    PPDebug(@"***********%@*********",textField.text);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
