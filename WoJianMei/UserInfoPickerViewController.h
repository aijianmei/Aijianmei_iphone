//
//  GenderViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/8/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"

@interface UserInfoPickerViewController : PPViewController
{
    
    UIButton *_femaleButton;
    UIButton *_maleButton;
    
    UIButton *_buttonForward;
    UIButton *_buttonBack;
    UIButton *_finishButton;
    
    
    UILabel *_weightLabel;
    UILabel *_heightLabel;
    UILabel *_ageLabel;
    
}

@property (nonatomic,retain) IBOutlet UIButton *femaleButton;
@property (nonatomic,retain) IBOutlet UIButton *maleButton;

@property (nonatomic,retain) IBOutlet UIButton *buttonForward;
@property (nonatomic,retain) IBOutlet UIButton *buttonBack;
@property (nonatomic,retain) IBOutlet UIButton *finishButton;

@property (nonatomic,retain) IBOutlet UILabel *weightLabel;
@property (nonatomic,retain) IBOutlet UILabel *heightLabel;
@property (nonatomic,retain) IBOutlet UILabel *ageLabel;




-(void)initUI;







@end
