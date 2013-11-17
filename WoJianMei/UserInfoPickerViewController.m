//
//  GenderViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/8/13.
//
//

#import "UserInfoPickerViewController.h"
#import "UserManager.h"
#import "User.h"
#import "AnimationManager.h"
#import "DeviceDetection.h"



@interface UserInfoPickerViewController ()
@property (nonatomic,assign) BOOL wantHorizontal;


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
@synthesize rulerHorizonBGView =_rulerHorizonBGView;
@synthesize rulerVerticalBGView =_rulerVerticalBGView;


@synthesize referenceImageView =_referenceImageView;
@synthesize horizenReferenceView =_horizenreferenceView;

@synthesize selectorHeight = _selectorHeight;
@synthesize selectorWeight = _selectorWeight;
@synthesize selectorAge    = _selectorAge;






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
    [_rulerVerticalBGView release];
    [_rulerHorizonBGView release];

    [_referenceImageView release];
    [_horizenreferenceView release];
    
    [_selectorHeight release];
    [_selectorWeight release];
    [_selectorAge release];


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
    [self.rulerVerticalBGView setHidden:YES];
    [self.rulerHorizonBGView setHidden:YES];

    [self.referenceImageView setHidden:YES];
    [self.horizenReferenceView setHidden:YES];


    [self.selectorAge    setHidden:YES];
    [self.selectorHeight setHidden:YES];
    [self.selectorWeight setHidden:YES];

    
    
}
-(void)setAgeView{
    [self hideAllSubviewsInView];
    
    [self.ageLabel      setHidden:NO];
    [self.buttonBack    setHidden:NO];
    [self.buttonForward setHidden:NO];
    [self.selectorAge setHidden:NO];
    [self.rulerHorizonBGView setHidden:NO];
    [self.rulerVerticalBGView setHidden:YES];

    [self.referenceImageView setHidden:YES];
    [self.horizenReferenceView setHidden:NO];


    [self.buttonForward setTitle:@"完成"
                        forState:UIControlStateNormal];
    [self.buttonForward setTitleColor:[UIColor whiteColor]
                             forState:UIControlStateNormal];
    
    [self.buttonForward  addTarget:self
                            action:@selector(clickForwardButton:)
                  forControlEvents:UIControlEventTouchUpInside];
    

    if (isFemale)
    {
        [self.femaleButton setHidden:NO];
        [self.maleButton   setHidden:YES];
        [self.femaleButton setFrame:CGRectMake(68,10,196,264)];
        
        //默认为20岁
        [self.ageLabel setText:@"1990年出生"];

        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:60
                                                     inSection:0];
        [_selectorAge.contentTableView scrollToRowAtIndexPath:indexPath
                                             atScrollPosition:UITableViewScrollPositionNone
                                                     animated:YES];
    }else {
        [self.maleButton   setHidden:NO];
        [self.femaleButton setHidden:YES];
        [self.maleButton setFrame:CGRectMake(105,10,110,262)];
        
        
        [self.ageLabel setText:@"1990年出生"];
        
        
        //默认为20岁
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:60
                                                     inSection:0];
        [_selectorAge.contentTableView scrollToRowAtIndexPath:indexPath
                                                atScrollPosition:UITableViewScrollPositionNone
                                                        animated:YES];
        
    }

    [self.ageLabel setFrame:CGRectMake(100,300,120,20)];
        
    
    
    if([DeviceDetection isIPhone5])
    {
        [self.rulerHorizonBGView setFrame:CGRectMake(20,380,270,77)];
        [self.selectorAge setFrame:CGRectMake(42, 400, 228, 49)];
        [self.horizenReferenceView setFrame:CGRectMake(117,400,4, 24)];
        PPDebug(@"This is iphone 5");
        
    }
    else
    {
        PPDebug(@"This is iphone 4");
        [self.rulerHorizonBGView setFrame:CGRectMake(20,326,270,77)];
        [self.selectorAge setFrame:CGRectMake(42, 345, 228, 49)];
        [self.horizenReferenceView setFrame:CGRectMake(117, 345,4, 24)];
        

    }

    
    
    //add animations
    [self showWeightButtons:self.femaleButton];
    [self showWeightButtons:self.maleButton];
    
    
}
-(void)setHeightView{
    
    
    [self hideAllSubviewsInView];
    [self.heightLabel   setHidden:NO];
    [self.buttonBack    setHidden:NO];
    [self.buttonForward setHidden:NO];
    [self.rulerHorizonBGView setHidden:YES];
    [self.rulerVerticalBGView setHidden:NO];
    
    [self.referenceImageView setHidden:NO];

    
       
    if (isFemale)
    {
        [self.femaleButton setHidden:NO];
        [self.maleButton   setHidden:YES];
        [self.femaleButton setFrame:CGRectMake(28,70,196,264)];
        [self.heightLabel setText:@"160cm"];

        
        //女为160cm
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:100
                                                     inSection:0];
        [_selectorHeight.contentTableView scrollToRowAtIndexPath:indexPath
                                                atScrollPosition:UITableViewScrollPositionNone
                                                        animated:YES];
        
    }else {
        [self.maleButton   setHidden:NO];
        [self.femaleButton setHidden:YES];
        [self.maleButton setFrame:CGRectMake(48,70,110,262)];
        [self.heightLabel setText:@"175cm"];

        //男性为175cm
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:115
                                                     inSection:0];
        [_selectorHeight.contentTableView scrollToRowAtIndexPath:indexPath
                                                atScrollPosition:UITableViewScrollPositionNone
                                                        animated:YES];
    }
    
    
    [self.selectorHeight setHidden:NO];
    [self.heightLabel setFrame:CGRectMake(100,11,320,21)];

    [self.buttonForward setTitle:@"下一步"
                        forState:UIControlStateNormal];

    if([DeviceDetection isIPhone5])
    {
        PPDebug(@"This is iphone 5");
        [self.referenceImageView setFrame:CGRectMake(239,205.5,24,4)];
    }
    else
    {
        PPDebug(@"This is iphone 4");
        [self.referenceImageView setFrame:CGRectMake(239,161,24,4)];
        
    }


    
    
    
    
    //add animations
    [self showWeightButtons:self.femaleButton];
    [self showWeightButtons:self.maleButton];
    
    
    
      


}
-(void)setWeightView{
    
    [self hideAllSubviewsInView];
    //show the  back and foward button
    [self.buttonBack     setHidden:NO];
    [self.buttonForward  setHidden:NO];
    
    //show the number picker
    [self.weightLabel    setHidden:NO];
    [self.rulerHorizonBGView setHidden:NO];
    [self.horizenReferenceView setHidden:NO];

    
    if (isFemale)
    {
        [self.femaleButton setHidden:NO];
        [self.maleButton   setHidden:YES];
        [self.femaleButton setFrame:CGRectMake(68,10,196,264)];
        [self.weightLabel setText:@"45KG"];
        //男性为45kg
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:20
                                                     inSection:0];
        [_selectorWeight.contentTableView scrollToRowAtIndexPath:indexPath
                                                atScrollPosition:UITableViewScrollPositionNone
                                                        animated:YES];
        


    }else {
        [self.maleButton   setHidden:NO];
        [self.femaleButton setHidden:YES];
        [self.maleButton setFrame:CGRectMake(105,10,110,262)];
        [self.weightLabel setText:@"60KG"];
        //男性为60kg
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:35
                                                     inSection:0];
        [_selectorWeight.contentTableView scrollToRowAtIndexPath:indexPath
                                                atScrollPosition:UITableViewScrollPositionNone
                                                        animated:YES];
        


    }
    
    
    [self.weightLabel setFrame:CGRectMake(140,300,80,20)];

    
    //add animations
    [self showWeightButtons:self.femaleButton];
    [self showWeightButtons:self.maleButton];
    
    
    [self.selectorWeight setHidden:NO];
    [self.rulerHorizonBGView setHidden:NO];

    
    
    if([DeviceDetection isIPhone5])
    {
        [self.rulerHorizonBGView setFrame:CGRectMake(20,380,270,77)];
        [self.selectorWeight setFrame:CGRectMake(42, 400, 228, 49)];
        [self.horizenReferenceView setFrame:CGRectMake(117,400,4, 24)];
        PPDebug(@"This is iphone 5");

    }
    else
    {
        PPDebug(@"This is iphone 4");
        [self.rulerHorizonBGView setFrame:CGRectMake(20,326,270,77)];
        [self.selectorWeight setFrame:CGRectMake(42, 345, 228, 49)];
        [self.horizenReferenceView setFrame:CGRectMake(117, 345,4, 24)];

    }
    
    [self.buttonForward setTitle:@"下一步"
                        forState:UIControlStateNormal];
    
    
    
    
}

-(void)setGenderView{
    [self hideAllSubviewsInView];
    
    
    
    if([DeviceDetection isIPhone5])
    {
               PPDebug(@"This is iphone 5");
        
        [self.femaleButton setFrame:CGRectMake(104,27,116,180)];
        [self.maleButton   setFrame:CGRectMake(114,252,82,187)];

        
    }
    else
    {
        PPDebug(@"This is iphone 4");
        
        [self.femaleButton setFrame:CGRectMake(104,27,116,180)];
        [self.maleButton   setFrame:CGRectMake(124,222,72,167)];

        
    }

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
     User *user = [[UserManager defaultManager] user];
     [user setGender:@"0"];
    [[UserManager defaultManager] storeUserInfoByUid:user.uid];
    
    
    [self.maleButton setHidden:YES];
    [self setWeightView];
    
    [self popupMessage:@"女" title:nil];
    
        
   

    
}
-(void)clickMaleButton:(id)sender{
    isFemale = NO;
    
    //保存用户数据
    User *user = [[UserManager defaultManager] user];
    [user setGender:@"1"];
    [[UserManager defaultManager] storeUserInfoByUid:user.uid];
    
    
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
        [self popupMessage:self.ageLabel.text
                     title:nil];
        
        [self clickDone];
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
    [self dismissViewControllerAnimated:YES completion:^{}];
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

    
    
    
    
    //YOU CAN ALSO ASSIGN THE DATA SOURCE AND THE DELEGATE IN CODE (IT'S ALREADY DONE IN NIB, BUT DO AS YOU PREFER)
    //垂直
    self.selectorHeight.dataSource = self;
    self.selectorHeight.delegate = self;
    self.selectorHeight.shouldBeTransparent = YES;
    self.selectorHeight.horizontalScrolling = NO;
    [self.selectorHeight setBackgroundColor:[UIColor clearColor]];
    
    
    //水平
    self.selectorWeight.dataSource = self;
    self.selectorWeight.delegate = self;
    self.selectorWeight.shouldBeTransparent = YES;
    self.selectorWeight.horizontalScrolling = YES;
    [self.selectorWeight setBackgroundColor:[UIColor clearColor]];

    
    
    self.selectorAge.dataSource = self;
    self.selectorAge.delegate = self;
    self.selectorAge.shouldBeTransparent = YES;
    self.selectorAge.horizontalScrolling = YES;
    [self.selectorAge setBackgroundColor:[UIColor clearColor]];


    
    
    //You can toggle Debug mode on selectors to see the layout
    self.selectorHeight.debugEnabled = NO;
    self.selectorWeight.debugEnabled = NO;
    self.selectorAge.debugEnabled = NO;

 
    
    
    
    
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


#pragma IZValueSelector dataSource
- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector {
    
    if ([valueSelector isDescendantOfView:_selectorHeight])
    {
        return 170;

    }
    
    if ([valueSelector isDescendantOfView:_selectorWeight])
    {
        return 200;

    }
    
    if ([valueSelector isDescendantOfView: _selectorAge])
    {
        return 80;
        
    }

    
    
    return 30;
}



//ONLY ONE OF THESE WILL GET CALLED (DEPENDING ON the horizontalScrolling property Value)
- (CGFloat)rowHeightInSelector:(IZValueSelectorView *)valueSelector {
    return 70.0;
}

- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector {
    return 70.0;
}


- (UIView *)selector:(IZValueSelectorView *)valueSelector
   viewForRowAtIndex:(NSInteger)index
{
    UILabel * label = nil;
    
    if (valueSelector == self.selectorWeight) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(-35, 10, 70, self.selectorWeight.frame.size.height)];

        int weightBase = 25 ;
        label.text = [NSString stringWithFormat:@"%d",        index + weightBase];
        label.textAlignment =  NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        
        
    }
    
    if(valueSelector == self.selectorHeight) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(5, -35, self.selectorHeight.frame.size.width, 70)];
        
        int heightBase = 60 ;
        label.text = [NSString stringWithFormat:@"%d",        index + heightBase];
        label.textAlignment =  NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];

    }
    
    if(valueSelector == self.selectorAge) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(-35, 10, 70, self.selectorAge.frame.size.height)];
        int ageBase = 1930 ;
        label.text = [NSString stringWithFormat:@"%d",        index + ageBase];
        label.textAlignment =  NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];

    
    }

    return label;
}

- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector {
    //Just return a rect in which you want the selector image to appear
    //Use the IZValueSelector coordinates
    //Basically the x will be 0
    //y will be the origin of your image
    //width and height will be the same as in your selector image
    if (valueSelector == self.selectorWeight) {
        //
        return CGRectMake(self.selectorWeight.frame.size.width/2 - 35.0, 0.0, 70.0, 50.0);
    }
    if(valueSelector == self.selectorHeight) {
        return CGRectMake(0.0, self.selectorHeight.frame.size.height/2 - 35.0, 50.0, 70.0);
    }
    if(valueSelector == self.selectorAge) {
        return CGRectMake(self.selectorAge.frame.size.width/2 - 35.0, 0.0, 70.0, 50.0);
    }
    
    return CGRectMake(0, 0, 0, 0);

}

#pragma IZValueSelector delegate
- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index {
    
    NSLog(@"Selected index %d",index);
    
    if ([self.selectorWeight isEqual:valueSelector])
    {
       
        int weightBase = 25;
        NSString *weight = [NSString stringWithFormat:@"%dkg",index + weightBase];
        
        [self.weightLabel setText:weight];
        User *user = [[UserManager defaultManager] user];
            [user setWeight: weight];
            [[UserManager defaultManager] storeUserInfoByUid:user.uid];
    }
    
    if ([self.selectorHeight isEqual:valueSelector])
    {
        int heightBase = 60;
        NSString *height = [NSString stringWithFormat:@"%dcm",heightBase +index];
        
        [self.heightLabel setText:height];
            
            User *user =  [[UserManager defaultManager] user];
            [user setHeight:height];
            [[UserManager defaultManager] storeUserInfoByUid:user.uid];

    }
    
    int age = 0;
    if ([self.selectorAge isEqual:valueSelector])

    {
        
        int ageBase = 1930 ;

        //出生时间
         age = index   +  ageBase ;
        
        //岁数
        int withNewValue = 2013 - age;
        
        NSString *ageValue = [NSString stringWithFormat:@"%i",withNewValue];
        
        User *user =  [[UserManager defaultManager] user];
        [user setAge:ageValue];
        [[UserManager defaultManager] storeUserInfoByUid:user.uid];
        
        
        }
    
        NSString *birthYear = [NSString stringWithFormat:@"%d年出生",age];
        [self.ageLabel setText:birthYear];

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
