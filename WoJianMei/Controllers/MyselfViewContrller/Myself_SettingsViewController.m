//
//  SecondViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Myself_SettingsViewController.h"
#import "User.h"
#import "UserService.h"
#import "UserManager.h"
#import "Citypicker.h"
#import "ChangeNameViewController.h"
#import "ChangeDescriptionViewController.h"
#import "ChangeGenderViewController.h"
#import "ProvinceViewController.h"
#import "ChangeLabelsViewController.h"
#import "MyselfSettingCell.h"
#import "UIImageView+WebCache.h"
#import "Result.h"
#import "BaiduMobStat.h"
#import "UIImage+Scale.h"
#import "UserInfoPickerViewController.h"
#import "PPNetworkRequest.h"


#define USER @"user"



@interface Myself_SettingsViewController ()


#pragma Image Picker Related
// this is just for copy
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
- (void)selectPhoto;
- (void)takePhoto;

@end


@implementation Myself_SettingsViewController
@synthesize avatarButton =_avatarButton;
@synthesize user= _user;
@synthesize avtarImage =_avtarImage;



-(void)dealloc{

    [_avtarImage release];
    [_user release];
    [_avatarButton release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        self.dataList = [NSArray arrayWithObjects:@"性别",@"年龄",@"身高(cm)",@"体重(KG)",@"BMI", nil];
        
        isChoosingAvtarImage =NO;
        isChoosingAvtarBackground = NO;
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void)didClickBackButton:(UIButton *)button{
    
    if (didSave == NO) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"保存修改" message:@"您当前修改数据没有保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        [av show];
    }
}


//从网络下载图片
-(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}


-(void)clickSaveButton:(id)sender{

    if (self.avtarImage) {
        [[UserService defaultService] uploadUserAvatar:self.avtarImage
                                           resultBlock:^(int resultCode, NSString *imageRemoteURL)
        
        {
            [self hideActivity];
            
            if (resultCode == ERROR_SUCCESS && [imageRemoteURL length] > 0){
                
//                [_pbUserBuilder setAvatar:imageRemoteURL];
                
//                  [self updateAvatar:self.avtarImage];
                   [self updateUI];
            }
            else{
                
//                [[CommonMessageCenter defaultCenter] postMessageWithText:NSLS(@"kUpdateAvatarFail") delayTime:1.5];
            }
        }];

        
        

    }else{
        [[UserService defaultService] uploadUserAvatar:self.avtarImage
                                           resultBlock:^(int resultCode, NSString *imageRemoteURL)
         {
            [self hideActivity];
            if (resultCode == ERROR_SUCCESS && [imageRemoteURL length] > 0){
                                                   
            //                [_pbUserBuilder setAvatar:imageRemoteURL];
                                                   
           //                  [self updateAvatar:self.avtarImage];
                    [self updateUI];
        }
            else{
                                                   
            //                [[CommonMessageCenter defaultCenter] postMessageWithText:NSLS(@"kUpdateAvatarFail") delayTime:1.5];
                }
             
         }];
   
    }
    
    //数据加载中的时候，按钮是禁止的再被点击的;
   //    [self.navigationItem.rightBarButtonItem setEnabled:NO];
}


#pragma mark --
#pragma Image Picker Related

// this is just for copy
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image != nil)
    
    {
        if (isChoosingAvtarImage)
        {
           
           UIImage *cropImage=  [image crop:CGRectMake(0, 0, 640, 640)];
           UIImage *reSizeImage= [cropImage scaleToSize:CGSizeMake(100, 100)];
            
            NSData *imageData = UIImageJPEGRepresentation(reSizeImage, 1.0);
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *path = [paths objectAtIndex:0];
            NSString *tmpPathToFile = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/avtar.png", path]];
            if([imageData writeToFile:tmpPathToFile atomically:YES]){
                //Write was successful.
                self.avtarImage = reSizeImage;
                
                
            }
        }
    }
    
    [[UserService defaultService] setUser:self.user];
    User *user = [[UserService defaultService] user];
    [user setAvatarImage:self.avtarImage];
    [[UserService defaultService] storeUserInfoByUid:user.uid];
    [[UserService defaultService] setUser:user];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
    
    [self loadDatas];
    [dataTableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectPhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] &&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self.navigationController presentViewController:picker animated:YES completion:nil];
        [picker release];
        
    }
    
}

- (void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        picker.delegate = self; 
        [self.navigationController presentViewController:picker
                                                animated:YES
                                              completion:nil];
        [picker release];
    }

}



-(void)loadDatas{
            
        NSString *uid = [[[UserManager defaultManager] user] uid];
        User *user =  [[UserService defaultService] getUserInfoByUid:uid];
    

        //本地数据存在的时候直接读取本地数据;
        if (user) {
            User *user = [[UserService defaultService] getUserInfoByUid:uid];
            
       //判断用户的数据是否完整
            if (!user.height && !user.weight && !user.age) {
                
                UserInfoPickerViewController *vc = [[UserInfoPickerViewController alloc]initWithNibName:@"UserInfoPickerViewController" bundle:nil];
                [self.navigationController presentViewController:vc animated:YES completion:^{}];
                [vc release];
            }

            [[UserService defaultService] setUser:user];
            [self setUser:user];
            [self updateUI];
            
        }else{
            //本地数据不存在，用户第一次登陆的时候，就往服务器拉数据
            [[UserService defaultService] fecthUserInfoWithUid:uid
                                                viewController:self];
            
        }
}



-(void)updateUI{
    [self.dataTableView reloadData];
}


#pragma mark -
#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:YES];
    
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"MyselfSettingView"];

}



-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"MyselfSettingView"];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    [self loadDatas];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    ///设置背景
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    /// 设置导航按钮
    [self setNavigationRightButton:@"" imageName:@"Save.png" action:@selector(clickSaveButton:)];
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];

	// Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"编辑个人资料", @"Settings");
    
    didSave =NO;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark --actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
            //change the avatar
        case 0:
        {
            isChoosingAvtarImage =YES;
            isChoosingAvtarBackground =NO;
        }
            break;
            //change the avatar
        case 1:
        {
            isChoosingAvtarBackground =YES;
            isChoosingAvtarImage =NO;

        }
            break;

        default:
            break;
    }
    
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



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==0) {
        NSLog(@"0");
        
    }else {
        NSLog(@"1");


    }
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0 && indexPath.row ==0)
    {
        return 80;
    }
    
    return 55;
}



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
            return 3;
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
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyselfSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MyselfSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.indexPath = indexPath;
    
    
    
    [cell.imageView  setImage:nil];
    [cell.textLabel setText:nil];
    [cell.detailLabelView setText:nil];
    [cell.detailImageView setImage:nil];
    [cell.textField setText:nil];
    [cell.textField setHidden:NO];
    [cell.lessButton setHidden:NO];
    [cell.moreButton setHidden:NO];
    cell.newdelegate =self;



     cell.accessoryView = nil;

    
    /////
    UIImage *normalImage = [UIImage imageNamed:@"jt_1.png"];
    
    UIButton *accessoryViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    accessoryViewButton.frame = CGRectMake(0.0f, 0.0f, 32.0f,32.0f);
    accessoryViewButton.userInteractionEnabled = YES;
    [accessoryViewButton setImage:normalImage forState:UIControlStateNormal];
       
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
        {
            NSArray *array = [NSArray arrayWithObjects:@"更换头像",
//                              @"更换背景",
                              @"更改用户名",@"更改个性签名",nil];
            [cell.textLabel setText:[array objectAtIndex:indexPath.row]];
            
            ////设置头像
            if (indexPath.row ==0) {
            
                
                if (self.avtarImage) {
                    [cell.detailImageView setImage:self.avtarImage];
                }else{
                    [cell.detailImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];
                }

                
                [cell.detailImageView setFrame:CGRectMake(180, 7.50f, 65.0f,65.0f)];

            }
            //更改用户名
            if (indexPath.row ==1) {
                if (!self.user.name) {
                    [cell.detailLabelView  setText:@"设置用户名"];
                }
                
                [cell.detailLabelView  setText:self.user.name];

            }
            //更改个性签名
            if (indexPath.row ==2) {
                
                if (!self.user.description) {
                    [cell.detailLabelView  setText:@"设置个性签名"];
                }
                
                [cell.detailLabelView  setText:self.user.description];
            }
        
            cell.accessoryView = accessoryViewButton;
            [cell.textField setHidden:YES];
            [cell.lessButton setHidden:YES];
            [cell.moreButton setHidden:YES];


            

    }
        break;
        case 1:
        {
            [cell.textLabel setText:[self.dataList objectAtIndex:indexPath.row]];
            
            switch (indexPath.row) {
                    //sex
                case 0:
                {
                    
                    NSString *gender =nil;
                    if ([self.user.gender isEqualToString:@"0"])
                    {
                        gender = [NSString stringWithFormat:@"女"];
                    }
                    if ([self.user.gender isEqualToString:@"1"])
                    {
                        gender = [NSString stringWithFormat:@"男"];
                        
                    }
                    if ([self.user.gender isEqualToString:@"?"])
                    {
                        gender = [NSString stringWithFormat:@"?"];
                        
                    }

                [cell.detailLabelView setText:gender];
                cell.accessoryView = accessoryViewButton;

                [cell.textField  setHidden:YES];
                [cell.lessButton setHidden:YES];
                [cell.moreButton setHidden:YES];
                }
                    break;
                    //age
                case 1:
                {
                [cell.textField setText:self.user.age];
                [cell.textField setTag:1];
                    
                [cell.moreButton setTag:1];
                [cell.lessButton setTag:2];
                
                }
                    break;
                    //height
                case 2:
                {
                [cell.textField setText:self.user.height];
                [cell.textField setTag:2];
                [cell.moreButton setTag:3];
                [cell.lessButton setTag:4];

                }
                    break;
                    //weight
                case 3:
                {
                [cell.textField setText:self.user.weight];
                [cell.textField setTag:3];
                [cell.moreButton setTag:5];
                [cell.lessButton setTag:6];
                
                }
                    break;
                    //BMI
                case 4:
                {
                    
                self.user.BMIValue =[self reCaluclateBMIValueByWeight:self.user.weight
                                                               height:self.user.height];
                    
                    
                    [cell.detailLabelView setText:self.user.BMIValue];
                    [cell.textField setHidden:YES];
                    [cell.lessButton setHidden:YES];
                    [cell.moreButton setHidden:YES];
                    BMIindexPath =cell.indexPath;

                }
                    break;
                default:
                    break;
            }

        }
            break;
        case 2:
        {
            [cell.textLabel setText:@"城市"];
             NSString *userLocation = [NSString stringWithFormat:@"%@%@",self.user.province,self.user.city];
            [cell.detailLabelView setText:userLocation];
            cell.accessoryView = accessoryViewButton;
            [cell.textField setHidden:YES];
            [cell.lessButton setHidden:YES];
            [cell.moreButton setHidden:YES];

        }
            
            break;
        default:
            break;
    }

    [cell.textLabel setTextColor:[UIColor grayColor]];

    return cell;
}


//读取本地保存的图片
-(UIImage*)loadImageInDirectory:(NSString *)directoryPath{
    NSData *imageData =[NSData dataWithContentsOfFile:directoryPath];
    UIImage *result =[UIImage imageWithData:imageData];
    return result;
}




-(void)clickChangeAvatarButton{
    
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"照相"
                                              otherButtonTitles:@"相册",nil];
    
    [share setTag:0];
    [share showInView:self.view];
    [share release];
    
}
-(void)clickChangeAvatarBackgroundButton{
    
    UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:@"照相"
                                              otherButtonTitles:@"相册",nil];
    [share setTag:1];
    [share showInView:self.view];
    [share release];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.    
    switch (indexPath.section)
    {
        case 0:
        {
            //Change avatar image
            if (indexPath.row ==0) {
            [self clickChangeAvatarButton];
            }
            //Change avatar background
//            else if(indexPath.row ==1){
//            [self clickChangeAvatarBackgroundButton];
//            }
            //Change name
            else if(indexPath.row ==1){
            ChangeNameViewController *vc = [[ChangeNameViewController alloc]initWithNibName:@"ChangeNameViewController" bundle:nil];
           [self.navigationController pushViewController:vc animated:YES];
           [vc release];
            }
            //Change description
            else if(indexPath.row ==2){
                ChangeDescriptionViewController *vc = [[ChangeDescriptionViewController alloc]initWithNibName:@"ChangeDescriptionViewController" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
                
            }
        
        }
            break;
        case 1:
        {
            //Change gender
            if (indexPath.row==0) {
                ChangeGenderViewController *vc = [[ChangeGenderViewController alloc]initWithNibName:@"ChangeGenderViewController" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
            }
            //Change age
            else if (indexPath.row==1) {
                
                [self.dataTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];

            }
            //Change Height
            else if (indexPath.row==2) {
                
                [self.dataTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];

            }
            //Change Weight
            else if (indexPath.row==3) {
                [self.dataTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];

        }
            break;
         //Change area and city
        }
        case 2:
        {
            ProvinceViewController *vc = [[ProvinceViewController alloc]initWithNibName:@"ProvinceViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
            
        }
            break;
            
        default:
            break;
    }
     
     
}

- (void)didClickAddMoreButton:(id)sender atIndex:(NSIndexPath*)indexPath;
{
    NSArray *array = [NSArray arrayWithObjects:BMIindexPath, nil];
    [self.dataTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void)didClickLessButton:(id)sender atIndex:(NSIndexPath*)indexPath
{
    NSArray *array = [NSArray arrayWithObjects:BMIindexPath, nil];
    [self.dataTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
    
}

-(void)didUpdateDatasByKeyboradInput:(id)sender atIndex:(NSIndexPath *)indexPath{

    NSArray *array = [NSArray arrayWithObjects:BMIindexPath, nil];
    [self.dataTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}




- (NSString *)reCaluclateBMIValueByWeight:(NSString *)aWeight height: (NSString *)aHeight{
    
    //重新计算BMI
    int weight = [self.user.weight integerValue];
    int height = [self.user.height integerValue];
    float BMI =weight /(height * height * 0.01 *0.01);
    
    NSString *bmi = [NSString stringWithFormat:@"%.1f",BMI];
    PPDebug(@"what the bmi: %@",bmi);
    return bmi;
}

#pragma --mark
#pragma --UIScrollViewDelegate Method
//当UIScrollView 变化的时候要隐藏键盘,方便用户使用;
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    TPKeyboardAvoidingTableView *tableView =  (TPKeyboardAvoidingTableView *)scrollView;
    [tableView  hideKeyboard];
    
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{  // called on finger up as we are moving
    
    TPKeyboardAvoidingTableView *tableView =  (TPKeyboardAvoidingTableView *)scrollView;
    [tableView  hideKeyboard];
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{     // called when scroll view grinds to a halt
    
    TPKeyboardAvoidingTableView *tableView =  (TPKeyboardAvoidingTableView *)scrollView;
    [tableView  hideKeyboard];
        
}




#pragma mark -
#pragma mark - RKObjectLoaderDelegate

- (void)didLoadUserInfoSucceeded:(int)errorCode;
{
    
            User *user = [[UserManager defaultManager] user];
    
            NSString *bmi = [self reCaluclateBMIValueByWeight:user.weight
                                                       height:user.height];
            
    
            //设置为当前用户
            [[UserService defaultService] setUser:user];
            
            [user setBMIValue:bmi];
            
            
            
            
            NSDictionary *sinaUserInfo =[[UserService defaultService] getSinaUserInfoWithUid:[SinaWeiboManager sharedManager].sinaweibo.userID];
            NSString *profileImageUrl = [sinaUserInfo objectForKey:@"profileImageUrl"];
            
            
            if ([user.profileImageUrl length] == 0 && profileImageUrl) {
                [self.user setProfileImageUrl:profileImageUrl];
            }
            
            if ([user.city length] == 0 ) {
                [self.user setCity:@"您的所在地"];
            }
            
            if ([user.description length]) {
                [self.user setDescription:@"您的心情短语！"];
            }
            
            self.user = user;
            //保存用户
            [[UserService defaultService] storeUserInfoByUid:user.uid];
            
            
            [self updateUI];
            
            [self.navigationItem.rightBarButtonItem setEnabled:YES];
            [self.navigationItem.leftBarButtonItem setEnabled:YES];
            [self popupHappyMessage:@"保存成功" title:nil];
}


@end
