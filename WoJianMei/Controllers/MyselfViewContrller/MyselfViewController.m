//
//  MyselfViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import "MyselfViewController.h"
#import "WorkOutDataViewController.h"

#import "MyselfTableViewCell.h"
#import "ImageManager.h"
#import "Myself_SettingsViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import <CoreText/CoreText.h>
#import "WorkOutProcessViewController.h"

#define USER                          @"user"
#define USER_NAME                     @"screen_name"
#define USER_DESCRIPTION              @"description"
#define USER_AVATAR_IMAGE             @"avatar_large"
#define USER_GENDER                   @"gender"


@interface MyselfViewController ()
@end

@implementation MyselfViewController
@synthesize headerVImageButton=_headerVImageButton;
@synthesize myHeaderView =_myHeaderView;
@synthesize userNameLabel=_userNameLabel;
@synthesize mottoLabel = _mottoLabel;
@synthesize userGenderLabel = _userGenderLabel;
@synthesize sina_userInfo =_sina_userInfo;
@synthesize user =_user;



-(void)dealloc{
    
    
    [_headerVImageButton release];
    [_footerVImageV release];
    [_myHeaderView release];
    [_userNameLabel release];
    [_mottoLabel release];
    [_userGenderLabel release];
    [_sina_userInfo release], _sina_userInfo = nil;
    [_user release];
    [super dealloc];
}

-(void)viewDidUnload{
    
    [super viewDidUnload];
    self.headerVImageButton =nil;
    self.userNameLabel = nil;
    self.mottoLabel = nil;
    self.headerVImageButton =nil;
    self.footerVImageV =nil;
    self.myHeaderView =nil;
    self.userNameLabel =nil;
    self.mottoLabel =nil;
    self.userGenderLabel =nil;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self hidesBottomBarWhenPushed];
}


/* display new or existing cached image */

- (void)upgradeUI
{
    
   
    
    [self.headerVImageButton setBackgroundImage:self.user.avatarImage forState:UIControlStateNormal];
    
    NSString *userName = [self.user name];
    [self.userNameLabel setText:userName];
    
    NSString *userGender = [self.user gender];
    
    
    if ([userGender  isEqualToString:@"m"]) {
        
        [self.userGenderLabel setText:@"男"];

    }else{
        [self.userGenderLabel setText:@"女"];
        
    }
    
    NSString *description = [self.user description];
    [self.mottoLabel setText:description];
    

    
    
}

-(void)test{

    NSLog(@"i am testing now !!!");
}

-(void)initUI{
    
    
    [self setTitle:@"我"];
    
    [self setNavigationRightButton:@"设置" imageName:@"settings.png" action:@selector(clickSettingsButton:)];
    [self setNavigationLeftButton:@"智能设备" imageName:@"settings.png" action:@selector(clickSettingsButton:)];
    


    
     //////// Set the headerView of the buttons  
    
    self.myHeaderView  =[[UIView alloc]init];
    [_myHeaderView setFrame: CGRectMake(0, 0, 100, 220)];
    [_myHeaderView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 260, 160)];
    [backGroundImageView setImage:[UIImage imageNamed:@"profile_backgroud.png"]];
    [_myHeaderView addSubview:backGroundImageView];
    [backGroundImageView release];
    
    
    ////// set the Username
    self.userNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(100, 130, 145, 30)];
    _userNameLabel.backgroundColor =[UIColor clearColor];
   [_userNameLabel setTextAlignment:NSTextAlignmentRight];
    _userNameLabel.textColor = [UIColor whiteColor];
    
      
    
    
    [self.myHeaderView addSubview:self.userNameLabel];
    
    

    
    
    self.headerVImageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_headerVImageButton addTarget:self action:@selector(clickVatarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _headerVImageButton.layer.borderWidth = 4.0f;
    _headerVImageButton.layer.cornerRadius = 8.0f;
    _headerVImageButton.layer.borderColor = [UIColor clearColor].CGColor;
    
    
    [_headerVImageButton setFrame:CGRectMake(250, 115, 70, 70)];
    [_headerVImageButton setBackgroundColor:[UIColor clearColor]];
    [_headerVImageButton setImage:[ImageManager avatarbackgroundImage] forState:UIControlStateNormal];
    
    
    //// descritpin broundground
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"description_bround.png"]];
    
    
    [imageview setFrame:CGRectMake(0, 160, 320, 50)];
    
    [self.myHeaderView addSubview:imageview];
    [imageview release];
    
    //////set the motto
    
    //初始化label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 147, 250, 50)];
    //设置自动行数与字符换行
    [label setNumberOfLines:2];
    label.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    NSString *s = @"这是一个测试！！！adsfsaf时发生发勿忘我勿忘我勿忘我勿忘我勿忘我阿阿阿阿阿阿阿阿阿阿阿阿阿啊00000000阿什顿。。。";
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    //设置一个行高上限
    CGSize size = CGSizeMake(250,50);
    
    //计算实际frame大小，并将label的frame变成实际大小
     CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [label setFrame:CGRectMake(0, 160, labelsize.width, labelsize.height)];
    
    
    self.mottoLabel = label;
    [self.mottoLabel setTextAlignment:NSTextAlignmentLeft];
    [self.mottoLabel setBackgroundColor:[UIColor clearColor]];
    [self.mottoLabel  setLineBreakMode:NSLineBreakByTruncatingTail];
    [_myHeaderView addSubview:self.mottoLabel];
    
    
    ////// set the User Gender
    self.userGenderLabel  = [[UILabel alloc]initWithFrame:CGRectMake(265, 190, 100, 30)];
    _userGenderLabel.backgroundColor =[UIColor clearColor];
    [self.myHeaderView addSubview:self.userGenderLabel];
    

    [self.myHeaderView addSubview:self.headerVImageButton];
    [self.dataTableView setTableHeaderView:self.myHeaderView];
    
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self initUI];
    /* prepare to use our own on-disk cache */
   
    
    self.dataList = [NSArray arrayWithObjects:@"性别",@"年龄",@"身高",@"体重",@"BMI", nil];
    
    /////Demo datas
    User *user1 = [[User alloc]init];
    user1.description = @"我非常喜欢健身运动！！！如果你都喜欢，你就告诉我啦！哈哈哈哈哈哈";
    user1.name = @"TomCallon";
    user1.gender = @"m";
    user1.avatarBackGroundImage = [UIImage imageNamed:@"profile_backgroud.png"];
    user1.avatarImage = [UIImage imageNamed:@"user_image.png"];
    
    
    self.user = user1;
    [user1 release];
    
    [self upgradeUI];
    
    
    
}

#pragma mark ----------------------------------------————————————————
#pragma mark  tableviewDelegate Method


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 5;
            break;
        case 4:
            return 1;
            break;
            
        default:
            break;
    }
    
    return [self.dataList count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [MyselfTableViewCell getCellIdentifier];
    
    MyselfTableViewCell *cell = (MyselfTableViewCell *)[self.dataTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell) {
        cell = [[[MyselfTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        cell.textLabel.textColor=[UIColor colorWithRed:0x46/255.0 green:0x46/255.0 blue:0x46/255.0 alpha:1.0];
    }
    
        
    switch (indexPath.section) {
        case 0:
            [cell.textLabel setText:@"我的健身历程"];
            break;
        case 1:
            [cell.textLabel setText:@"健身小助手"];
            break;
        case 2:
            [cell.textLabel setText:@"标签"];
            break;
        case 3:
            [cell.textLabel setText:[self.dataList objectAtIndex:indexPath.row]];
            break;
        case 4:
            [cell.textLabel setText:@"城市"];
            break;
            
        default:
            break;
    }
    
    
    UIImage *normalImage = [UIImage imageNamed:@"144x144.png"];
    UIImage *mySelectedImage = [UIImage imageNamed:@"144x144.png"];
    
    UIButton *accessoryViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    accessoryViewButton.frame = CGRectMake(0.0f, 0.0f, normalImage.size.width -120, normalImage.size.height -120);
    accessoryViewButton.userInteractionEnabled = YES;
    [accessoryViewButton setImage:normalImage forState:UIControlStateNormal];
    [accessoryViewButton setImage:mySelectedImage forState:UIControlStateHighlighted];
    
    cell.accessoryView = accessoryViewButton;

    return cell;
}

////Click the cell methos
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //TODO
    switch (indexPath.section) {
        case 0:
            NSLog(@"I did click %@",@"我的健身历程");
        
            [self.navigationController performSegueWithIdentifier:@"WorkoutProcessSegue" sender:self];
            
            break;
        case 1:
            NSLog(@"I did click %@",@"我的健身小助手");
                
            [self performSegueWithIdentifier:@"WorkoutImageViewSegue" sender:self];
            
            break;
        case 2:
            NSLog(@"I did click %@",@"标签");
            ////for testing
            
            [self performSegueWithIdentifier:@"WorkoutImageViewSegue" sender:self];
            
            break;
        case 3:
            switch (indexPath.row) {
                case 0:
                    NSLog(@"this is %@",@"性别");
                    ////for testing by Tom Callon 
                    [self performSegueWithIdentifier:@"WorkoutImageViewSegue" sender:self];
                    break;
                case 1:
                    NSLog(@"this is %@",@"年龄");
                    
                    WorkOutDataViewController *rvController = [[[WorkOutDataViewController alloc]init] autorelease];
                    [self.navigationController pushViewController:rvController animated:YES];
                    
                    break;
                case 2:
                    NSLog(@"this is %@",@"身高");
                    break;
                case 3:
                    NSLog(@"this is %@",@"体重");
                    break;
                case 4:
                    NSLog(@"this is %@",@"BMI");
                    break;
                    
                default:
                    break;
            }
                    break;
        case 4:
            NSLog(@"I did click %@",@"城市");
            break;
            
        default:
            break;
    }
    
}


#pragma mark -
#pragma mark Hide and Show TabBar Methods

- (void)showTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0]; // UITransitionView
    UIView *window = parent.superview;
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds) - CGRectGetHeight(tabBar.frame);
                         tabBar.frame = tabFrame;
                         CGRect contentFrame = content.frame;
                         contentFrame.size.height -= tabFrame.size.height;
                     }];
}


- (void)hideTabBar {
    UITabBar *tabBar = self.tabBarController.tabBar;
    UIView *parent = tabBar.superview; // UILayoutContainerView
    UIView *content = [parent.subviews objectAtIndex:0];  // UITransitionView
    UIView *window = parent.superview;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect tabFrame = tabBar.frame;
                         tabFrame.origin.y = CGRectGetMaxY(window.bounds);
                         tabBar.frame = tabFrame;
                         content.frame = window.bounds;
                     }];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"WorkoutProcessSegue"])
    {
//        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
//        
//        UIViewController *vc = segue.destinationViewController;
//        
//       vc.hidesBottomBarWhenPushed = YES;
        
        
    }

        
}

-(void)clickSettingsButton:(id)sender{
    
    Myself_SettingsViewController *vc = [[Myself_SettingsViewController alloc]init];
    [self.navigationController pushViewController :vc animated:YES];
     vc.user = self.user;
    [vc release];
    
    [self hideTabBar];
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self.dataTableView reloadData];
    [self upgradeUI];
    [self showTabBar];
}




-(void)clickVatarButton:(id)sender{
    
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"照相"
                                              otherButtonTitles:@"相册",nil];
    [share showFromTabBar:self.tabBarController.tabBar];
    [share release];

    
    
}




#pragma mark -
#pragma mark - ImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image != nil){
        
    [self.navigationController  dismissViewControllerAnimated:YES completion:^{
        
        [self.headerVImageButton setImage:image forState:UIControlStateNormal];
         self.user.avatarImage = image;
        [self storeUserInfo];
        
    }];
  }
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
}




-(void)storeUserInfo{
    
     NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:USER];
    
    [self upgradeUI];
    
}


#pragma mark --actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
        {
            [self takePhoto];
        }
            break;
        case 1:
        {
            [self  selectPhoto];
            
        }
            break;
        case 2:
            
        {
            NSLog(@"Button index :%d",buttonIndex);
        }
            break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
