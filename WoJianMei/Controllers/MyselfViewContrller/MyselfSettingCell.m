//
//  MyselfSettingCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/11/13.
//
//

#import "MyselfSettingCell.h"
#import "User.h"
#import "UserService.h"

@implementation MyselfSettingCell
@synthesize detailLabelView =_detailLabelView;
@synthesize detailImageView =_detailImageView;
@synthesize textField =_textField;
@synthesize moreButton = _moreButton;
@synthesize lessButton = _lessButton;
@synthesize newdelegate;


-(void)dealloc{
    
    [_detailLabelView release];
    [_detailImageView release];
    [_textField release];
    [_moreButton release];
    [_lessButton release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.detailLabelView = [[UILabel alloc]initWithFrame:CGRectMake(145.0f, 11.0f, 115.0f,32.0f)];
        [self.detailLabelView setTextAlignment:NSTextAlignmentRight];
        [self.detailLabelView setBackgroundColor:[UIColor clearColor]];
        [self.detailLabelView setTextColor:[UIColor grayColor]];
        [self addSubview:_detailLabelView];
        
        
        
        
        self.detailImageView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 5.0f, 45.0f,42.0f)];
        [self.detailImageView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_detailImageView];

        
        
        
        
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 15, 142, 27)];
        _textField.delegate =self;
        [self.textField setBackground:[UIImage imageNamed:@"profile_data_BG.png"]];
        [_textField setTextAlignment:NSTextAlignmentCenter];
        [_textField setAdjustsFontSizeToFitWidth:YES];
        [_textField setFont:[UIFont systemFontOfSize:20]];
        [_textField setTextColor:[UIColor grayColor]];
        [self addSubview:_textField];

        
        
        self.moreButton = [[UIButton alloc]initWithFrame:CGRectMake(260,3, 40,22)];
        [self.moreButton setBackgroundImage:[UIImage imageNamed:@"more_data_Button.png"] forState:UIControlStateNormal];
    
        [_moreButton addTarget:self action:@selector(clickAddMoreButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_moreButton];
        
        
        self.lessButton = [[UIButton alloc]initWithFrame:CGRectMake(260, 30, 40, 22)];
        [_lessButton setBackgroundImage:[UIImage imageNamed:@"less_data_Button.png"] forState:UIControlStateNormal];

        [_lessButton addTarget:self action:@selector(clickLessButton:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_lessButton];
        
      
    }
    return self;
}
#pragma mark -
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    User *user =[[UserService defaultService] user];
    switch (textField.tag) {
        case 1:
        {
            NSLog(@"age textfield");
            user.age = textField.text;
        }
            break;
        case 2:
        {
            NSLog(@"height textfield");
            user.height = textField.text;
        }
            break;
        case 3:
        {
            NSLog(@"weight textfield");
            user.weight = textField.text;
        }
            break;
            
        default:
            break;
    }
    [[UserService defaultService] setUser:user];
}

-(void)clickAddMoreButton:(UIButton *)sender{
    
    
    UIButton *button =(UIButton *)sender;
    int buttonTag = [button tag];
    
    User *user =[[UserService defaultService] user];
    
    switch (buttonTag) {
        case 1:
        {
            int value = [_textField.text  integerValue];
            int nt = 1;
            
            NSString *newValue = [NSString stringWithFormat:@"%i",value +nt];
            user.age =newValue;
            
            [_textField setText:user.age];

            
        }
            break;
        case 3:
        {
            int value = [_textField.text  integerValue];
            int nt = 1;
            
            NSString *newValue = [NSString stringWithFormat:@"%i",value +nt];
            user.height =newValue;
            
            [_textField setText:user.height];

        }
            break;
        case 5:
        {
            int value = [_textField.text  integerValue];
            int nt = 1;
            
            NSString *newValue = [NSString stringWithFormat:@"%i",value +nt];
            user.weight =newValue;
            [_textField setText:user.weight];

            
        }
            break;
            
        default:
            break;
    }
    
    NSString *bmi = [self reCaluclateBMIValueByWeight:user.weight height:user.height];
    
    [user setBMIValue:bmi];
    
    [[UserService defaultService] setUser:user];
    [[UserService defaultService] storeUserInfoByUid:user.uid];
    
    if (newdelegate && [newdelegate respondsToSelector:@selector(didClickAddMoreButton:atIndex:)]) {
        
        [newdelegate didClickLessButton:sender atIndex:indexPath];
    }
    
    
}
-(void)clickLessButton:(UIButton *)sender{
    
    
    UIButton *button =(UIButton *)sender;
    int buttonTag = [button tag];
    
    User *user =[[UserService defaultService] user];
    
    switch (buttonTag) {
        case 2:
        {
            int value = [_textField.text  integerValue];
            int nt = -1;
            
            NSString *newValue = [NSString stringWithFormat:@"%i",value +nt];
            user.age =newValue;
            [_textField setText:user.age];

        }
            break;
        case 4:
        {
            int value = [_textField.text  integerValue];
            int nt = -1;
            
            NSString *newValue = [NSString stringWithFormat:@"%i",value +nt];
            user.height =newValue;
            [_textField setText:user.height];

        }
            break;
        case 6:
        {
            int value = [_textField.text  integerValue];
            int nt = -1;
            
            NSString *newValue = [NSString stringWithFormat:@"%i",value +nt];
            user.weight =newValue;
            [_textField setText:user.weight];

        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
    
    
  NSString *bmi = [self reCaluclateBMIValueByWeight:user.weight height:user.height];
    
   [user setBMIValue:bmi];
    
     [[UserService defaultService] setUser:user];
     [[UserService defaultService] storeUserInfoByUid:user.uid];
    

    
    
    
    if (newdelegate && [newdelegate respondsToSelector:@selector(didClickLessButton:atIndex:)]) {
        
        [newdelegate didClickLessButton:sender atIndex:indexPath];
    }
}


- (NSString *)reCaluclateBMIValueByWeight:(NSString *)aWeight height: (NSString *)aHeight{
    
    //重新计算BMI
    int weight = [aWeight integerValue];
    int height = [aHeight integerValue];
    float BMI =weight /(height * height * 0.01 *0.01);
    
    NSString *bmi = [NSString stringWithFormat:@"%.1f",BMI];
    return bmi;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:NO];

    // Configure the view for the selected state
}

@end
