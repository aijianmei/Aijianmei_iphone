//
//  GenderViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/8/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "SLNumberPickerView.h"


@interface UserInfoPickerViewController : PPViewController<SLNumberPickerViewDelegate>
{
    
    UIButton *_femaleButton;
    UIButton *_maleButton;
    
    UIButton *_buttonForward;
    UIButton *_buttonBack;
    
    
    UILabel *_weightLabel;
    UILabel *_heightLabel;
    UILabel *_ageLabel;
    
    SLNumberPickerView *sLNumberPickerView;
    
    
    UIImageView *_rulerbackgroundImageView;
    UIImageView *_referenceImageView;
    
    
    BOOL isFemale;
   
    
    
}

@property (nonatomic,retain) IBOutlet UIButton *femaleButton;
@property (nonatomic,retain) IBOutlet UIButton *maleButton;

@property (nonatomic,retain) IBOutlet UIButton *buttonForward;
@property (nonatomic,retain) IBOutlet UIButton *buttonBack;

@property (nonatomic,retain) IBOutlet UILabel *weightLabel;
@property (nonatomic,retain) IBOutlet UILabel *heightLabel;
@property (nonatomic,retain) IBOutlet UILabel *ageLabel;

@property (nonatomic,retain) IBOutlet UIImageView *rulerbackgroundImageView;
@property (nonatomic,retain) IBOutlet UIImageView *referenceImageView;






-(void)initUI;







@end
