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
#import "UserService.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "LabelsView.h"


#define USER                          @"user"
#define USER_NAME                     @"screen_name"
#define USER_DESCRIPTION              @"description"
#define USER_AVATAR_IMAGE             @"avatar_large"
#define USER_GENDER                   @"gender"


@interface MyselfViewController ()
@end

@implementation MyselfViewController
@synthesize headerVImageButton=_headerVImageButton;
@synthesize backGroundImageView = _backGroundImageView;
@synthesize myHeaderView =_myHeaderView;
@synthesize userNameLabel=_userNameLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize sina_userInfo =_sina_userInfo;
@synthesize user =_user;



-(void)dealloc{
    
    [_headerVImageButton release];
    [_backGroundImageView release];
    [_footerVImageV release];
    [_myHeaderView release];
    [_userNameLabel release];
    [_descriptionLabel release];
    [_sina_userInfo release],_sina_userInfo = nil;
    [_user release];
    [super dealloc];
}

-(void)viewDidUnload{
    
    [super viewDidUnload];
    self.headerVImageButton =nil;
    self.backGroundImageView =nil;
    self.userNameLabel = nil;
    self.headerVImageButton =nil;
    self.footerVImageV =nil;
    self.myHeaderView =nil;
    self.userNameLabel =nil;
    self.descriptionLabel =nil;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)addHeaderView{
    self.myHeaderView  =[[UIView alloc]init];
    [_myHeaderView setFrame: CGRectMake(0, 0, 320, 200)];
    [self.dataTableView setTableHeaderView:self.myHeaderView];

}

-(void)addAvatarBGImageView{
    self.backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    [self.backGroundImageView setImageWithURL:[NSURL URLWithString:self.user.avatarBackGroundImage] placeholderImage:[UIImage imageNamed:@"profile_backgroud.png"]];
    [self.myHeaderView addSubview:_backGroundImageView];
}


-(void)addAvtarImageButton{
    self.headerVImageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_headerVImageButton addTarget:self action:@selector(clickVatarButton:) forControlEvents:UIControlEventTouchUpInside];
    _headerVImageButton.layer.borderWidth = 4.0f;
    _headerVImageButton.layer.cornerRadius = 8.0f;
    _headerVImageButton.layer.borderColor = [UIColor clearColor].CGColor;
    [_headerVImageButton setFrame:CGRectMake(240, 115, 70, 70)];
    [_headerVImageButton setBackgroundColor:[UIColor clearColor]];
    [_headerVImageButton setImage:[UIImage imageNamed:@"touxiang_40x40"] forState:UIControlStateNormal];
    [self.myHeaderView addSubview:_headerVImageButton];

     
}

-(void)addUserNameLabel{
    
    ////// set the Username
    self.userNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(30, 130, 145, 30)];
    _userNameLabel.backgroundColor =[UIColor clearColor];
    [_userNameLabel setTextAlignment:NSTextAlignmentRight];
    _userNameLabel.textColor = [UIColor whiteColor];
    [_userNameLabel setText:@"用户名"];
    [self.myHeaderView addSubview:self.userNameLabel];    
}

-(void)addDescriptionBG
{
    //// Descritpin broundground
    UIImageView *descriptionBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"description_bround.png"]];
    [descriptionBG setFrame:CGRectMake(0, 160, 320, 50)];
    [self.myHeaderView addSubview:descriptionBG];
    [descriptionBG release];
}

-(void)addDescriptionLabel{

    //初始化label
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 147, 270, 50)];
    //设置自动行数与字符换行
    [descriptionLabel setNumberOfLines:2];
    descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
    // 测试字串
    NSString *s = @"这是一个测试！！！ADSFASDFASDFASDFSADFASDFASFASFASFASDFASDFASDFASFASDFASDFASDFASDFASDFASDFASFASDFASDFASDFASDFASDFASDFA";
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    //设置一个行高上限
    CGSize size = CGSizeMake(230,50);
    
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [descriptionLabel setFrame:CGRectMake(0, 160, labelsize.width, labelsize.height)];
    
    
    self.descriptionLabel = descriptionLabel;
    [self.descriptionLabel setTextAlignment:NSTextAlignmentLeft];
    [self.descriptionLabel setBackgroundColor:[UIColor clearColor]];
    [self.descriptionLabel  setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.myHeaderView addSubview:self.descriptionLabel];
    [_myHeaderView bringSubviewToFront:_headerVImageButton];
}


-(void)initUI{
    
    [self addHeaderView];
    [self addAvatarBGImageView];
    [self addAvtarImageButton];
    [self addUserNameLabel];
    [self addDescriptionBG];
    [self addDescriptionLabel];
}


-(void)loadUserData{
    
    NSString *uid = [[[UserService defaultService] user] uid];
    
    //本地数据存在的时候直接读取本地数据;
    if ([[UserService defaultService] getUserInfoByUid:uid]) {
        
        [self setUser:[[UserService defaultService] getUserInfoByUid:uid]];
        
        [self upgradeUI];

    }else{
    //本地数据不存在，用户第一次登陆的时候，就往服务器拉数据
         [[UserService defaultService] fecthUserInfoWithUid:uid delegate:self];
    }
}

- (void)upgradeUI
{
    [self.headerVImageButton setImageWithURL:[NSURL URLWithString:_user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
    [self.backGroundImageView setImageWithURL:[NSURL URLWithString:self.user.avatarBackGroundImage] placeholderImage:[UIImage imageNamed:@"profile_backgroud.png"]];
    [self.userNameLabel setText:_user.name];
    [self.descriptionLabel setText:_user.description];
    
    [dataTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.dataList = [NSArray arrayWithObjects:@"性别",@"年龄",@"身高",@"体重",@"BMI", nil];

    [self setTitle:@"我"];
    [self setNavigationRightButton:@"设置" imageName:@"top_bar_commonButton.png" action:@selector(clickSettingsButton:)];
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];

    [self initUI];
    
    [self loadUserData];
    
}



#pragma mark ----------------------------------------————————————————
#pragma mark  tableviewDelegate Method


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 5;
            break;
        case 2:
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
    
    UIImage *normalImage = [UIImage imageNamed:@"AccessoryView.png"];
    UIImage *mySelectedImage = [UIImage imageNamed:@"144x144.png"];
    UIButton *accessoryViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    accessoryViewButton.frame = CGRectMake(0.0f, 0.0f, 70.0f,32.0f);
    accessoryViewButton.userInteractionEnabled = YES;
    
    switch (indexPath.section) {
        case 0:
            [cell.textLabel setText:@"标签"];
            
            /////显示数据接口
            LabelsView *lablesView = [[LabelsView alloc]initWithFrame:CGRectMake(50, 15, cell.bounds.size.width -90, cell.bounds.size.height)];
            [lablesView setDataList:self.user.labelsArray];
            [lablesView setNeedsDisplay];
            [cell addSubview:lablesView];
            [lablesView release];
            
            /////accessoryViewButton
            [accessoryViewButton setImage:normalImage forState:UIControlStateNormal];
            [accessoryViewButton setImage:mySelectedImage forState:UIControlStateHighlighted];
            ////accessoryBGview 背景颜色
            UIView *accessoryBGview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
            [accessoryBGview setBackgroundColor:[UIColor clearColor]];
            [accessoryViewButton setFrame:CGRectMake(10, 0, 40, 40)];
            [accessoryBGview addSubview:accessoryViewButton];
            
            cell.accessoryView = accessoryBGview;
            [accessoryBGview release];
            
            
            break;
        case 1:
            [cell.textLabel setText:[self.dataList objectAtIndex:indexPath.row]];
            
            /////accessoryViewButton
            [accessoryViewButton setBackgroundImage:[UIImage imageNamed:@"Label_Type.png"] forState:UIControlStateNormal];
            
            switch (indexPath.row) {
                case 0:
                {
                   ///性别
                    NSString *gender;
                    if ([self.user.gender isEqualToString:@"0"])
                    {
                        gender = [NSString stringWithFormat:@"男"];
                    }else{
                        gender = [NSString stringWithFormat:@"女"];

                    }
                    [accessoryViewButton setTitle:gender forState:UIControlStateNormal];
                
                }
                    break;
                case 1:
                {
                    ///年龄

                    [accessoryViewButton setTitle:self.user.age forState:UIControlStateNormal];
                }
                    break;
                case 2:
                    //身高
                {
                    [accessoryViewButton setTitle:self.user.height forState:UIControlStateNormal];
                }
                    break;
                case 3:
                {
                    //体重
                    [accessoryViewButton setTitle:self.user.weight forState:UIControlStateNormal];
                }
                    break;
                case 4:
                {
                    //BMI
                    [accessoryViewButton setTitle:self.user.BMIValue forState:UIControlStateNormal];
                }
                    break;
                default:
                    break;
            }
            
        
            cell.accessoryView = accessoryViewButton;

            
            break;
        case 2:
            [cell.textLabel setText:@"城市"];
        
            /////accessoryViewButton
            NSString *userLocation = [NSString stringWithFormat:@"%@%@",self.user.province,self.user.city];
            
            [accessoryViewButton setTitle:userLocation forState:UIControlStateNormal];
            [accessoryViewButton setFrame:CGRectMake(0, 0, 100, 40)];
            [accessoryViewButton setBackgroundImage:[UIImage imageNamed:@"Label_Type.png"] forState:UIControlStateNormal];
            cell.accessoryView = accessoryViewButton;
            break;
            
        default:
            break;
    }
    
    
    
//
    return cell;
}

////Click the cell methos
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    UIStoryboard * iPhonestroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    
    
    //TODO
    switch (indexPath.section) {
//        case 0:
//            NSLog(@"I did click %@",@"我的健身历程");
//            [self performSegueWithIdentifier:@"WorkoutProcessSegue" sender:self];
//            
//            break;
//        case 1:
//            NSLog(@"I did click %@",@"我的健身小助手");
//                
//            [self performSegueWithIdentifier:@"WorkoutImageViewSegue" sender:self];
            
            break;
        case 0:
            NSLog(@"I did click %@",@"标签");
            ////for testing
            
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    NSLog(@"this is %@",@"性别");
                    break;
                case 1:
                    NSLog(@"this is %@",@"年龄");
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
        case 2:
            NSLog(@"I did click %@",@"城市");
            break;
            
        default:
            break;
    }
    
}

-(void)clickSettingsButton:(id)sender{
    
    Myself_SettingsViewController *vc = [[Myself_SettingsViewController alloc]initWithNibName:@"Myself_SettingsViewController" bundle:nil];
    
    [self.navigationController pushViewController :vc animated:YES];
     vc.user = self.user;
    [vc release];
    
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self.dataTableView reloadData];
    [self upgradeUI];
}




-(void)clickVatarButton:(id)sender{
    
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"照相"
                                              otherButtonTitles:@"相册",nil];
    [share showInView:self.view];
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
        
    }];
  }
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
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
#pragma mark -
#pragma mark - RKObjectLoaderDelegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Response code: %d", [response statusCode]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)requestDidStartLoad:(RKRequest *)request
{
    NSLog(@"Start load request...");
    [self showActivityWithText:@"数据加载中..."];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    
    NSLog(@"***Load objects count: %d", [objects count]);
    [self hideActivity];
    
     NSObject *object = [objects objectAtIndex:0];
    if ([object isMemberOfClass:[User class]]) {
         User *user = [objects objectAtIndex:0];
        [[UserService defaultService] setUser:user];
        [[UserService defaultService] storeUserInfoByUid:user.uid];
        self.user =[[UserService defaultService] user];
        [self upgradeUI];
    }
}



@end
