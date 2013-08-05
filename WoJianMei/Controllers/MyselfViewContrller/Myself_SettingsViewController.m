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
#import "Citypicker.h"
#import "ChangeNameViewController.h"
#import "ChangeDescriptionViewController.h"
#import "ChangeGenderViewController.h"
#import "ProvinceViewController.h"
#import "ChangeLabelsViewController.h"
#import "AFPickerView.h"
#import "MyselfSettingCell.h"
#import "UIImageView+WebCache.h"
#import "Result.h"
#import "BaiduMobStat.h"
#import "CorpImageView.h"
#import "UIImage+Scale.h"


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
        
        self.user = [[UserService defaultService]user];
  
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
    
    
    didSave =YES;

//    if ([self.user.profileImageUrl hasPrefix:@"http://tp4.sinaimg.cn/"]) {
//        
//        [[UserService defaultService] postObject:nil withImage:nil delegate:self];
//        [self showActivityWithText:@"加载中..."];
//        
//        //数据加载中的时候，按钮是禁止的再被点击的;
//        [self.navigationItem.rightBarButtonItem setEnabled:NO];
//        
//        return;
//
//        
//    }
    
    
    if (self.user.profileImageUrl) {
    //把保存再文件夹里边的图片取出来，然后上传到服务器上面;
        self.avtarImage = [self loadImageInDirectory:self.user.profileImageUrl];
      
    }

//    UIImage *image = [self getImageFromURL:self.user.profileImageUrl];
    
    
    
    if (self.avtarImage) {
        [[UserService defaultService] postObject:nil withImage:self.avtarImage delegate:self];
        [self showActivityWithText:@"加载中..."];

    }else{
        [[UserService defaultService] postObject:nil withImage:nil delegate:self];
        [self showActivityWithText:@"加载中..."];
    
    }
    //数据加载中的时候，按钮是禁止的再被点击的;
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
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
                self.avtarImage = cropImage;
                self.user.profileImageUrl = tmpPathToFile;
            
            }
        }
    }
    
    
    
    
    
    User *user =[[UserService defaultService] user];
    [[UserService defaultService] setUser:user];
    [[UserService defaultService] storeUserInfoByUid:user.uid];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        CorpImageView *cropImageView =[[CorpImageView alloc]initWithNibName:@"CorpImageView" bundle:nil];
//        cropImageView.imgView.image =image;
//        [self.navigationController presentModalViewController:cropImageView animated:YES];
//        [cropImageView release];
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
        [self.navigationController presentViewController:picker animated:YES completion:nil];
        [picker release];
    }

}




#pragma mark -
#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:YES];
    [self loadDatas];
    [self updateUI];
    [[BaiduMobStat defaultStat] pageviewStartWithName:@"MyselfSettingView"];
}



-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [[BaiduMobStat defaultStat] pageviewEndWithName:@"MyselfSettingView"];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    ///设置背景
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    /// 设置导航按钮
    [self setNavigationRightButton:@"保存" imageName:@"top_bar_commonButton.png" action:@selector(clickSaveButton:)];
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];

	// Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"编辑个人资料", @"Settings");
    
    didSave =NO;
}


-(void)loadDatas{
    self.user = [[UserService defaultService] user];
}

-(void)updateUI{
    [self loadDatas];
    [dataTableView reloadData];
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




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
//        case 1:
//            return 1;
//            break;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyselfSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[MyselfSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell.imageView  setImage:nil];
    [cell.textLabel setText:nil];
    [cell.detailLabelView setText:nil];
    [cell.detailImageView setImage:nil];
    [cell.textField setText:nil];
    [cell.textField setHidden:NO];
    [cell.lessButton setHidden:NO];
    [cell.moreButton setHidden:NO];
    cell.newdelegate =self;

    
    CGSize size = CGSizeMake(320, 770);
    [tableView setContentSize:size];
  

     cell.accessoryView = nil;

    
    /////
    UIImage *normalImage = [UIImage imageNamed:@"AccessoryView.png"];
    
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
            
                [cell.detailImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl] placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"]];

                 UIImage *image = [self loadImageInDirectory:self.user.profileImageUrl];
                if (image) {
                    [cell.detailImageView setImage:image];
                }

                [cell.detailImageView setFrame:CGRectMake(180, 7.50f, 65.0f,65.0f)];

            }
            ///设置背景
//            if (indexPath.row ==1) {
//                                
//                
//                [cell.detailImageView setImageWithURL:[NSURL URLWithString:self.user.avatarBackGroundImage] placeholderImage:[UIImage imageNamed:@"profile_backgroud.png"]];
//               
//                [cell.detailImageView setFrame:CGRectMake(150, 2, 120, 50)];
//                
//            }
            
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
//        case 1:
//        {
//            [cell.textLabel setText:@"标签"];
//            [cell.detailLabelView setText:@"修改标签"];
//             cell.accessoryView = accessoryViewButton;
//            [cell.textField setHidden:YES];
//            [cell.lessButton setHidden:YES];
//            [cell.moreButton setHidden:YES];
//
//        }
//            break;
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
                [cell.detailLabelView setText:self.user.BMIValue];
                    [cell.textField setHidden:YES];
                    [cell.lessButton setHidden:YES];
                    [cell.moreButton setHidden:YES];
                    
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
//        case 1:
//        {
//            //change Label
//            ChangeLabelsViewController *vc = [[ChangeLabelsViewController alloc]initWithNibName:@"ChangeLabelsViewController" bundle:nil];
//            [self.navigationController pushViewController:vc animated:YES];
//            [vc release];
//        }
//            break;
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
    [self.dataTableView reloadData];
}

- (void)didClickLessButton:(id)sender atIndex:(NSIndexPath*)indexPath{
    [self.dataTableView reloadData];
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

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects;
{
    [self hideActivity];
    if ([objectLoader wasSentToResourcePath:@"/imgtest.php"])
    
    {
        PPDebug(@"%@",[objects objectAtIndex:0]);
        if ([[objects objectAtIndex:0] isMemberOfClass:[User class]]) {
            User *user = [objects objectAtIndex:0];
            NSLog(@"******%@******",user.uid);
            NSLog(@"******%@******",user.profileImageUrl);
            
            //取出用户
            User *newUser  =[[UserService defaultService] user];
            
            NSString *bmi = [self reCaluclateBMIValueByWeight:newUser.weight height:newUser.height];
            
            //修改用户
            [newUser setProfileImageUrl:user.profileImageUrl];
            [newUser setBMIValue:bmi];
        
            //保存用户
            [[UserService defaultService] storeUserInfoByUid:newUser.uid];
    
            [self updateUI];
            [self.navigationItem.rightBarButtonItem setEnabled:YES];
        }
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
}


@end
