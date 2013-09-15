//
//  GenderViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/8/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "IZValueSelectorView.h"



@interface UserInfoPickerViewController : PPViewController<IZValueSelectorViewDataSource,IZValueSelectorViewDelegate>
{
    
    UIButton *_femaleButton;
    UIButton *_maleButton;
    
    UIButton *_buttonForward;
    UIButton *_buttonBack;
    
    
    UILabel *_genderDesLabel;
    
    UILabel *_weightLabel;
    UILabel *_heightLabel;
    UILabel *_ageLabel;
    
    
    
    UIImageView *_rulerVerticalBGView;
    UIImageView *_rulerHorizonBGView;
    
    
    
    
    BOOL isFemale;
   
    
    
}

@property (nonatomic,retain) IBOutlet UIButton *femaleButton;
@property (nonatomic,retain) IBOutlet UIButton *maleButton;

@property (nonatomic,retain) IBOutlet UIButton *buttonForward;
@property (nonatomic,retain) IBOutlet UIButton *buttonBack;

@property (nonatomic,retain) IBOutlet UILabel *genderDesLabel;


@property (nonatomic,retain) IBOutlet UILabel *weightLabel;
@property (nonatomic,retain) IBOutlet UILabel *heightLabel;
@property (nonatomic,retain) IBOutlet UILabel *ageLabel;

@property (nonatomic,retain) IBOutlet UIImageView *rulerVerticalBGView;
@property (nonatomic,retain) IBOutlet UIImageView *
rulerHorizonBGView;



@property (nonatomic,retain) IBOutlet UIImageView *referenceImageView;

@property (nonatomic,retain) IBOutlet UIImageView *horizenReferenceView;


@property (nonatomic,retain) IBOutlet IZValueSelectorView *selectorHeight;

@property (nonatomic,retain) IBOutlet IZValueSelectorView *selectorWeight;

@property (nonatomic,retain) IBOutlet IZValueSelectorView *selectorAge;









-(void)initUI;







@end
