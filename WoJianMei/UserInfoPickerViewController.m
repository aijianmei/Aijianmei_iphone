//
//  GenderViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/8/13.
//
//

#import "UserInfoPickerViewController.h"
#import "UserService.h"
#import "User.h"
#import "AnimationManager.h"
#import "SLNumberPickerView.h"
#import "DeviceDetection.h"



@interface UserInfoPickerViewController ()

@end

@implementation UserInfoPickerViewController

@synthesize femaleButton =_femaleButton;
@synthesize maleButton =_maleButton;
@synthesize buttonBack =_buttonBack;
@synthesize buttonForward =_buttonForward;

@synthesize genderDesLabel =_genderDesLabel;

@synthesize weightLabel =_weightLabel;
@synthesize heightLabel =_heightLabel;
@synthesize ageLabel =_ageLabel;
@synthesize rulerbackgroundImageView =_rulerbackgroundImageView;
@synthesize referenceImageView =_referenceImageView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc {
    [_femaleButton  release];
    [_maleButton    release];
    [_buttonForward release];
    [_buttonBack    release];
    [_genderDesLabel release];
    [_weightLabel   release];
    [_heightLabel   release];
    [_ageLabel      release];
    [_rulerbackgroundImageView release];
    [_referenceImageView release];

    [super dealloc];

}
-(void)hideAllSubviewsInView{
    // Hide all subviews
    [self.heightLabel   setHidden:YES];
    [self.weightLabel   setHidden:YES];
    [self.ageLabel      setHidden:YES];
    [self.genderDesLabel setHidden:YES];
    [self.femaleButton  setHidden:YES];
    [self.maleButton    setHidden:YES];
    [self.buttonForward setHidden:YES];
    [self.buttonBack    setHidden:YES];
    [self.rulerbackgroundImageView setHidden:YES];
    [self.referenceImageView setHidden:YES];

    //Hide the  SLNumberLablel
    for (UIView *view  in [self.view subviews]){
        if ([view isMemberOfClass:[SLNumberPickerView class]]){
            sLNumberPickerView = (SLNumberPickerView *)view;
            [sLNumberPickerView setHidden:YES];
        }
    }
    
}
-(void)setAgeView{
    [self hideAllSubviewsInView];
    
    [self.ageLabel      setHidden:NO];
    [self.buttonBack    setHidden:NO];
    [self.buttonForward setHidden:NO];
    [sLNumberPickerView setHidden:NO];
    [self.rulerbackgroundImageView setHidden:NO];
    [self.referenceImageView setHidden:NO];


    [self.buttonForward setTitle:@"完成"
                        forState:UIControlStateNormal];
    [self.buttonForward setTitleColor:[UIColor whiteColor]
                             forState:UIControlStateNormal];
    [self.buttonForward  addTarget:self
                            action:@selector(dissmissViewController:)
                  forControlEvents:UIControlEventTouchUpInside];
    

    if (isFemale)
    {
        [self.femaleButton setHidden:NO];
        [self.maleButton   setHidden:YES];
        [self.femaleButton setFrame:CGRectMake(28,70,196,264)];

        
    }else {
        [self.maleButton   setHidden:NO];
        [self.femaleButton setHidden:YES];
        [self.maleButton setFrame:CGRectMake(48,70,110,262)];

    }

    [self.ageLabel setFrame:CGRectMake(100,11,320,21)];

    
    //add animations
    [self showWeightButtons:self.femaleButton];
    [self showWeightButtons:self.maleButton];
    
    
    //设置年龄的初始值  8600 == 172cm
    sLNumberPickerView.isWeightSceen =NO;
    sLNumberPickerView.isHeightSceen =NO;
    sLNumberPickerView.isAgeSceen =YES;
    
    [sLNumberPickerView scrollRectToVisible:CGRectMake(0, 3526, 40, 40) animated:YES];
    
}
-(void)setHeightView{
    
    
    [self hideAllSubviewsInView];
    [self.heightLabel   setHidden:NO];
    [self.buttonBack    setHidden:NO];
    [self.buttonForward setHidden:NO];
    [sLNumberPickerView setHidden:NO];
    [self.rulerbackgroundImageView setHidden:NO];
    [self.referenceImageView setHidden:NO];

    
       
    if (isFemale)
    {
        [self.femaleButton setHidden:NO];
        [self.maleButton   setHidden:YES];
        [self.femaleButton setFrame:CGRectMake(28,70,196,264)];

        
    }else {
        [self.maleButton   setHidden:NO];
        [self.femaleButton setHidden:YES];
        [self.maleButton setFrame:CGRectMake(48,70,110,262)];

    }
    
    [self setTitle:@"请选择你的身高!"];
    [self.heightLabel setFrame:CGRectMake(100,11,320,21)];


    
    //add animations
    [self showWeightButtons:self.femaleButton];
    [self showWeightButtons:self.maleButton];
    
    
    
    //设置身高的初始值 7000 == 170cm
    
    sLNumberPickerView.isWeightSceen =NO;
    sLNumberPickerView.isHeightSceen =YES;
    sLNumberPickerView.isAgeSceen =NO;

    [sLNumberPickerView scrollRectToVisible:CGRectMake(0, 7011, 40, 40) animated:YES];
    
      


}
-(void)setWeightView{
    
    [self hideAllSubviewsInView];
    //show the  back and foward button
    [self.buttonBack     setHidden:NO];
    [self.buttonForward  setHidden:NO];
    
    //show the number picker
    [sLNumberPickerView  setHidden:NO];
    [self.weightLabel    setHidden:NO];
    [self.rulerbackgroundImageView setHidden:NO];
    [self.referenceImageView setHidden:NO];

    
    if (isFemale)
    {
        [self.femaleButton setHidden:NO];
        [self.maleButton   setHidden:YES];
        [self.femaleButton setFrame:CGRectMake(28,70,196,264)];
    }else {
        [self.maleButton   setHidden:NO];
        [self.femaleButton setHidden:YES];
        [self.maleButton setFrame:CGRectMake(70,70,110,262)];

    }
    
    
    [self setTitle:@"请选择你的体重!"];
    [self.weightLabel setFrame:CGRectMake(100,11,320,21)];

    
    //add animations
    [self showWeightButtons:self.femaleButton];
    [self showWeightButtons:self.maleButton];
    
    
    //设置体重的初始值 //2500 = 50kg
    
    sLNumberPickerView.isWeightSceen =YES;
    sLNumberPickerView.isHeightSceen =NO;
    sLNumberPickerView.isAgeSceen =NO;
    
    [sLNumberPickerView scrollRectToVisible:CGRectMake(0, 2501, 40, 40) animated:NO];
    

    
}
-(void)setGenderView{
    [self hideAllSubviewsInView];
    [self.femaleButton setFrame:CGRectMake(104,27,116,180)];
    [self.maleButton   setFrame:CGRectMake(124,222,72,167)];
    [self.femaleButton   setHidden:NO];
    [self.maleButton     setHidden:NO];
    [self.genderDesLabel     setHidden:NO];

    
    [self setTitle:@"请选择你的性别!"];
    
    //Add animations
    [self showGenderButtons:self.femaleButton];
    [self showGenderButtons:self.maleButton];

}
-(void)clickFemaleButton:(id)sender{
     isFemale =YES;
    
    //保存用户数据
     User *user = [[UserService defaultService] user];
     [user setGender:@"0"];
    [[UserService defaultService] storeUserInfoByUid:user.uid];
    
    
    [self.maleButton setHidden:YES];
    [self setWeightView];
    
    [self popupMessage:@"女" title:nil];
    
        
   

    
}
-(void)clickMaleButton:(id)sender{
    isFemale = NO;
    
    //保存用户数据
    User *user = [[UserService defaultService] user];
    [user setGender:@"1"];
    [[UserService defaultService] storeUserInfoByUid:user.uid];
    
    
    [self.femaleButton setHidden:YES];
    [self setWeightView];
    [self popupMessage:@"男" title:nil];

}

-(void)clickForwardButton:(id)sender{
    
    //从体重跳到身高
    if (!self.weightLabel.isHidden) {
        [self setHeightView];
        [self popupMessage:self.weightLabel.text
                     title:nil];
        return;
    }
    //从身高跳到年龄
    if (!self.heightLabel.isHidden) {
        [self setAgeView];
        [self popupMessage:self.heightLabel.text
                     title:nil];

        return;
    }
    //从年龄跳到结束
    if (!self.ageLabel.isHidden) {
        [self clickDone];
        [self popupMessage:self.ageLabel.text title:nil];
        return;
    }
}
-(void)clickBackButton:(id)sender{
    
    //从体重跳到性别
    if (!self.weightLabel.isHidden) {
        [self setGenderView];
        return;
    }
    //从身高跳到体重
    if (!self.heightLabel.isHidden) {
        [self setWeightView];
        return;
    }
    //从年龄跳到身高
    if (!self.ageLabel.isHidden) {
        [self setHeightView];
        return;
    }
}

-(void)clickDone{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUI{
    
    [self.femaleButton addTarget:self action:@selector(clickFemaleButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.maleButton addTarget:self action:@selector(clickMaleButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttonForward addTarget:self
                           action:@selector(clickForwardButton:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.buttonBack addTarget:self
                        action:@selector(clickBackButton:)
              forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.buttonBack  setTitle:@"上一步"
                      forState:UIControlStateNormal];
    [self.buttonBack setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
    
    
    
    [self.buttonForward setTitle:@"下一步"
                        forState:UIControlStateNormal];
    [self.buttonForward setTitleColor:[UIColor whiteColor]
                             forState:UIControlStateNormal];

    

    
    
    
    //Set the labels
    [self.weightLabel setBackgroundColor:[UIColor clearColor]];
    [self.weightLabel setTextAlignment:NSTextAlignmentLeft];
    [self.weightLabel setTextColor:[UIColor grayColor]];

    
    [self.heightLabel   setBackgroundColor:[UIColor clearColor]];
    [self.heightLabel setTextAlignment:NSTextAlignmentLeft];
    [self.heightLabel setTextColor:[UIColor grayColor]];

    

    [self.ageLabel  setBackgroundColor:[UIColor clearColor]];
    [self.ageLabel setTextAlignment:NSTextAlignmentLeft];
    [self.ageLabel setTextColor:[UIColor grayColor]];

    
    
 
    
    if([DeviceDetection isIPhone5])
    {
        
    }
    else
    {
        [sLNumberPickerView setFrame:CGRectMake(0, 0, 30, 20)];

    }

    
    
    [self setGenderView];
    
}


-(void)showWeightButtons:(UIButton *)button{
    
    CABasicAnimation *fallButtonAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [fallButtonAnimation setDuration:1];
    [fallButtonAnimation setFromValue:[NSValue valueWithCGPoint:CGPointMake(0, button.center.y)]];
    [fallButtonAnimation setToValue:[NSValue valueWithCGPoint:button.center]];
    [fallButtonAnimation setFillMode:kCAFillModeForwards];
    [fallButtonAnimation setRemovedOnCompletion:NO];
    fallButtonAnimation.delegate = self;
    [fallButtonAnimation setRepeatCount :1];
    
    
    [button.layer removeAllAnimations];
    [button.layer addAnimation:fallButtonAnimation forKey:@"position"];
    
}



-(void)showGenderButtons:(UIButton *)button{
    
    CABasicAnimation *fallButtonAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [fallButtonAnimation setDuration:1];
    [fallButtonAnimation setFromValue:[NSValue valueWithCGPoint:CGPointMake(160, 0)]];
    [fallButtonAnimation setToValue:[NSValue valueWithCGPoint:button.center]];
    [fallButtonAnimation setFillMode:kCAFillModeForwards];
    [fallButtonAnimation setRemovedOnCompletion:NO];
    fallButtonAnimation.delegate = self;
    [fallButtonAnimation setRepeatCount :1];
    
    
    [button.layer removeAllAnimations];
    [button.layer addAnimation:fallButtonAnimation forKey:@"position"];
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
//    [self setNavigationLeftButton:@"下次再填" imageName:@"top_bar_backButton.png" action:@selector(dissmissViewController:)];
    
    [self initUI];
    
}

- (void)numberPickerViewDidChangeValue:(SLNumberPickerView *)picker {
    NSString* valueString = [NSString stringWithFormat:@"%i", picker.value];
    
    PPDebug(@"***** value %@*****",valueString);
    
    [picker setBackgroundColor:[UIColor clearColor]];
    
    NSString *weight = [NSString stringWithFormat:@"您的体重为:%@kg",valueString];
    
    [_weightLabel setText:weight];
    
    if (![self.weightLabel isHidden]) {
        User *user = [[UserService defaultService] user];
        [user setWeight: valueString];
        [[UserService defaultService]storeUserInfoByUid:user.uid];
    }
    
    

    NSString *height = [NSString stringWithFormat:@"您的身高为:%@cm",valueString];
    
    [_heightLabel setText:height];
    
    
    if (![self.heightLabel isHidden]) {
        
        User *user =  [[UserService defaultService] user];
        [user setHeight:valueString];
        [[UserService defaultService]storeUserInfoByUid:user.uid];
    }


    

    int age = [valueString integerValue];
    int withNewValue = age  + 1899;
    NSString *newAge = [NSString stringWithFormat: @"您的出生年:%i",withNewValue];
    
    [_ageLabel    setText:newAge];
    
    
    if (![self.ageLabel isHidden]) {
        
        int age = [valueString integerValue];
        int withNewValue = 2013 - (age  + 1899);
        NSString *ageValue = [NSString stringWithFormat:@"%i",withNewValue];
        User *user =  [[UserService defaultService] user];
        [user setAge:ageValue];
        [[UserService defaultService]storeUserInfoByUid:user.uid];
    }

    
}


-(void)dissmissViewController:(id)sender{

    [self dismissModalViewControllerAnimated:YES];
    
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
