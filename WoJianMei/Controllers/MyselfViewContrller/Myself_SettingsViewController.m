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


#define USER @"user"



@interface Myself_SettingsViewController ()


#pragma Image Picker Related
// this is just for copy
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
- (void)selectPhoto;
- (void)takePhoto;

@property (nonatomic, retain) UISwitch *airplaneModeSwitch;
@end


@implementation Myself_SettingsViewController
@synthesize airplaneModeSwitch = _airplaneModeSwitch;
@synthesize avatarButton =_avatarButton;
@synthesize user= _user;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
        self.dataList = [NSArray arrayWithObjects:@"性别",@"年龄",@"身高",@"体重",@"BMI", nil];
        
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


-(void)save{
    
     didSave =YES;

}

#pragma Image Picker Related
// this is just for copy
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image != nil){
        
        if (isChoosingAvtarImage)
        {
            self.user.avatarImage = image;
        }
        if (isChoosingAvtarBackground)
        {
            self.user.avatarBackGroundImage = image;
        }
        
      [[UserService defaultService] setUser:_user];
 
    }
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    [dataTableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)selectPhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] &&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self.navigationController presentModalViewController:picker animated:YES];
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
        [self.navigationController presentModalViewController:picker animated:YES];
        [picker release];
    }
    
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    ///设置背景
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    /// 设置导航按钮
    [self setNavigationRightButton:@"保存" imageName:@"top_bar_commonButton.png" action:@selector(save)];
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];

	// Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"编辑个人资料", @"Settings");
    
    didSave =NO;


                  
            UIButton *femaleButton  = [UIButton buttonWithType:UIButtonTypeCustom];
            [femaleButton setFrame:CGRectMake(120, 10, 25, 25)];
            [femaleButton setImage:[UIImage imageNamed:@"gender_on.png"]
                          forState:UIControlStateSelected];
            [femaleButton setImage:[UIImage imageNamed:@"gender_off.png"]
                                forState:UIControlStateNormal];

                  
//            [cell addSubview:femaleButton];
    
            UILabel *femaleLabel =[[UILabel alloc]initWithFrame:CGRectMake(90, 10, 30, 30)];
            [femaleLabel setText:@"女"];
            [femaleLabel setBackgroundColor:[UIColor clearColor]];
//            [cell addSubview:femaleLabel];
            [femaleLabel release];
                              
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
    self.airplaneModeSwitch = nil;
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==0) {
     
        NSLog(@"0");
    }else {
        NSLog(@"1");

    
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 5;
            break;
        case 3:
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

     cell.accessoryView = nil;
    
    /////
    UIImage *normalImage = [UIImage imageNamed:@"AccessoryView.png"];
//    UIImage *mySelectedImage = [UIImage imageNamed:@"144x144.png"];
    
    UIButton *accessoryViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    accessoryViewButton.frame = CGRectMake(0.0f, 0.0f, 32.0f,32.0f);
    accessoryViewButton.userInteractionEnabled = YES;
    [accessoryViewButton setImage:normalImage forState:UIControlStateNormal];
       
    // Configure the cell...
    switch (indexPath.section) {
        case 0:
        {
            NSArray *array = [NSArray arrayWithObjects:@"更换头像",@"更换背景",@"更改用户名",@"更改个性签名",nil];
            [cell.textLabel setText:[array objectAtIndex:indexPath.row]];
            
            ////设置头像
            if (indexPath.row ==0) {
                [cell.detailImageView setImage:self.user.avatarImage];
                if (!self.user.avatarImage) {
                    [cell.detailImageView setImage:[UIImage imageNamed:@"touxiang_40x40"]];
                }
                

            }
            ///设置背景
            if (indexPath.row ==1) {
                if (!self.user.avatarBackGroundImage) {
                    [cell.detailImageView setImage:[UIImage imageNamed:@"touxiang_40x40"]];
                }

                [cell.detailImageView setImage:self.user.avatarBackGroundImage];
                [cell.detailImageView setFrame:CGRectMake(150, 2, 120, 50)];
                


            }
            
            //更改用户名
            if (indexPath.row ==2) {
                if (!self.user.name) {
                    [cell.detailLabelView  setText:@"设置用户名"];
                }
                
                [cell.detailLabelView  setText:self.user.name];

            }
            //更改个性签名
            if (indexPath.row ==3) {
                if (!self.user.description) {
                    [cell.detailLabelView  setText:@"设置个性签名"];
                }
                
                [cell.detailLabelView  setText:self.user.description];
  
            }
            
            break;

        }
        case 1:
        {
            [cell.textLabel setText:@"标签"];
            [cell.detailLabelView setText:@"修改标签"];

        }
            break;
        case 2:
        {
            [cell.textLabel setText:[self.dataList objectAtIndex:indexPath.row]];
            
            switch (indexPath.row) {
                    //sex
                case 0:
                {
                [cell.detailLabelView setText:self.user.gender];

                }
                    break;
                    //age
                case 1:
                {
                [cell.detailLabelView setText:self.user.age];

                }
                    break;
                    //height
                case 2:
                {
                [cell.detailLabelView setText:self.user.height];

                }
                    break;
                    //weight
                case 3:
                {
                [cell.detailLabelView setText:self.user.weigth];

                }
                    break;
                    //BMI
                case 4:
                {
                [cell.detailLabelView setText:self.user.BMIValue];
                    
                }
                    break;

                    
                default:
                    break;
            }

        }
            break;
        case 3:
        {
            [cell.textLabel setText:@"城市"];
            [cell.detailLabelView setText:self.user.city];
        }
            
            break;
        default:
            break;
    }

    cell.accessoryView = accessoryViewButton;
    [cell.textLabel setTextColor:[UIColor grayColor]];

    return cell;
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
            else if(indexPath.row ==1){
            [self clickChangeAvatarBackgroundButton];
            }
            //Change name
            else if(indexPath.row ==2){
            ChangeNameViewController *vc = [[ChangeNameViewController alloc]initWithNibName:@"ChangeNameViewController" bundle:nil];
           [self.navigationController pushViewController:vc animated:YES];
           [vc release];
            }
            //Change description
            else if(indexPath.row ==3){
                ChangeDescriptionViewController *vc = [[ChangeDescriptionViewController alloc]initWithNibName:@"ChangeDescriptionViewController" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
                
            }
        
        }
            break;
        case 1:
        {
            //change Label
            ChangeLabelsViewController *vc = [[ChangeLabelsViewController alloc]initWithNibName:@"ChangeLabelsViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            [vc release];
        }
            break;
        case 2:
        {
            //Change gender
            if (indexPath.row==0) {
                ChangeGenderViewController *vc = [[ChangeGenderViewController alloc]initWithNibName:@"ChangeGenderViewController" bundle:nil];
                [self.navigationController pushViewController:vc animated:YES];
                [vc release];
            }
            //Change age
            else if (indexPath.row==1) {
                
                if (defaultPickerView == nil) {
                    defaultPickerView = [[AFPickerView alloc] initWithFrame:CGRectMake(0,200,320,216) backgroundImage:@"PickerBG.png" shadowImage:@"PickerShadow.png" glassImage:@"PickerGlass.png" title:@"AFPicker"];
                    defaultPickerView.dataSource = self;
                    defaultPickerView.delegate = self;
                    [self.view addSubview:defaultPickerView];
                }
                [defaultPickerView showPicker];
                [defaultPickerView reloadData];
                
                [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
                
        
                

            }
            //Change Height
            else if (indexPath.row==2) {
                
                if (defaultPickerView == nil) {
                    defaultPickerView = [[AFPickerView alloc] initWithFrame:CGRectMake(0,200,320,216) backgroundImage:@"PickerBG.png" shadowImage:@"PickerShadow.png" glassImage:@"PickerGlass.png" title:@"AFPicker"];
                    defaultPickerView.dataSource = self;
                    defaultPickerView.delegate = self;
                    [self.view addSubview:defaultPickerView];
                }
                [defaultPickerView showPicker];
                [defaultPickerView reloadData];
                  [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
               
            }
            //Change Weight
            else if (indexPath.row==3) {
                if (defaultPickerView == nil) {
                    defaultPickerView = [[AFPickerView alloc] initWithFrame:CGRectMake(0,200,320,216) backgroundImage:@"PickerBG.png" shadowImage:@"PickerShadow.png" glassImage:@"PickerGlass.png" title:@"AFPicker"];
                    defaultPickerView.dataSource = self;
                    defaultPickerView.delegate = self;
                    [self.view addSubview:defaultPickerView];
                }
                [defaultPickerView showPicker];
                [defaultPickerView reloadData];
                  [tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
               
            }
        }
            break;
         //Change area and city
        case 3:
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

#pragma mark - AFPickerViewDataSource
- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView {
    
    return 15;
}


- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row {
    return [NSString stringWithFormat:@"%i", row + 1];
}


#pragma mark - AFPickerViewDelegate

- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row {
    
    
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

@end
