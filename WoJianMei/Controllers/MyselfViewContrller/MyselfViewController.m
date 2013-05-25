//
//  MyselfViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import "MyselfViewController.h"
#import "RootViewController.h"

#import "MyselfTableViewCell.h"
#import "ImageManager.h"
#import "Myself_SettingsViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "TencentOAuthManager.h"
#import "FileStreame.h"
#import "key.h"
#import <CoreText/CoreText.h>


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
    
    ///set the right buttons
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(clickSettingsButton:)];
    ////set the left buttons
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithTitle:@"智能配件" style:UIBarButtonItemStyleBordered target:self action:@selector(test)];
    
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    [self.navigationItem setRightBarButtonItem:rightBarButton];

    [rightBarButton release];
    [leftBarButton release];
    
     //////// Set the headerView of the buttons  
    
    self.myHeaderView  =[[UIView alloc]init];
    [_myHeaderView setFrame: CGRectMake(0, 0, 100, 170)];
    [_myHeaderView setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
    [backGroundImageView setImage:[UIImage imageNamed:@"Default@2x.png"]];
    [_myHeaderView addSubview:backGroundImageView];
    [backGroundImageView release];
    
    
    ////// set the Username
    self.userNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(100, 90, 145, 30)];
    _userNameLabel.backgroundColor =[UIColor clearColor];
  [_userNameLabel setTextAlignment:NSTextAlignmentRight];

    [self.myHeaderView addSubview:self.userNameLabel];
    
    

    
    //////set the motto
    
    //初始化label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 250, 50)];
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
    [label setFrame:CGRectMake(0, 120, labelsize.width, labelsize.height)];
    
    
    self.mottoLabel = label;
    
//    self.mottoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, 250, 50)];
     _mottoLabel.backgroundColor = [UIColor redColor];
    [self.mottoLabel setTextAlignment:NSTextAlignmentLeft];
    [self.mottoLabel  setLineBreakMode:NSLineBreakByTruncatingTail];
    [_myHeaderView addSubview:self.mottoLabel];
    
   
    
    
    
    
    
    self.headerVImageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_headerVImageButton addTarget:self action:@selector(clickVatarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _headerVImageButton.layer.borderWidth = 4.0f;
    _headerVImageButton.layer.cornerRadius = 8.0f;
    _headerVImageButton.layer.borderColor = [UIColor clearColor].CGColor;

    
    [_headerVImageButton setFrame:CGRectMake(250, 88, 70, 70)];
    [_headerVImageButton setBackgroundColor:[UIColor clearColor]];
    [_headerVImageButton setImage:[ImageManager avatarbackgroundImage] forState:UIControlStateNormal];
    
    
    
    ////// set the User Gender
    self.userGenderLabel  = [[UILabel alloc]initWithFrame:CGRectMake(250, 30, 100, 30)];
    _userGenderLabel.backgroundColor =[UIColor clearColor];
    [self.myHeaderView addSubview:self.userGenderLabel];
    

    [self.myHeaderView addSubview:self.headerVImageButton];
    [self.dataTableView setTableHeaderView:self.myHeaderView];


    [self setBackgroundImageName:@"BackGround.png"];
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
    user1.avatarBackGroundImage = [UIImage imageNamed:@"Default@2x.png"];
    user1.avatarImage = [UIImage imageNamed:@"114x114.png"];
    
    
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
            [self performSegueWithIdentifier:@"WorkoutProcessSegue" sender:self];
            break;
        case 1:
            NSLog(@"I did click %@",@"我的健身小助手");
            
        ////for testing
            
            [self performSegueWithIdentifier:@"WorkoutNoteViewSegue" sender:self];
            
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
                    [self performSegueWithIdentifier:@"WorkoutDatasViewSegue" sender:self];
                    break;
                case 1:
                    NSLog(@"this is %@",@"年龄");
                    
                    RootViewController *rvController = [[RootViewController alloc]init];
                    
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






-(void)clickSettingsButton:(id)sender{
    
    Myself_SettingsViewController *vc = [[Myself_SettingsViewController alloc]init];
    [self.navigationController pushViewController :vc animated:YES];
     vc.user = self.user;
    [vc release];
    
    
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self.dataTableView reloadData];
    [self upgradeUI];
    [self hideActivity];
    
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
