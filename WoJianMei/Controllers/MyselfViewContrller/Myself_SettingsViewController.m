//
//  SecondViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Myself_SettingsViewController.h"
#import "User.h"
#import "Citypicker.h"
#import "NumberPickViewController.h"


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
        
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


-(void)storeUserInfo{
    
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:USER];
    
}

-(void)didClickBackButton:(UIButton *)button{
    
    if (didSave == NO) {
     
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"保存修改" message:@"您当前修改数据没有保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        
        [av show];
    }
}


-(void)save{
    
    [self storeUserInfo];
     didSave =YES;

}

#pragma Image Picker Related

// this is just for copy
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image != nil){
        
        self.user.avatarImage = image;
        [self.avatarButton setImage:self.user.avatarImage forState:UIControlStateNormal];
        [self storeUserInfo];
    }
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
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

    
     ////////add a section now 
       
//             cell.detailTextLabel.text = NSLocalizedString(@"更换头像", @"iamtheinternet");
//
//              self.avatarButton =[[UIButton alloc]initWithFrame:CGRectMake(17, 6, 40, 40)];
//             
//             
//             [self.avatarButton setBackgroundColor:[UIColor clearColor]];
//             [self.avatarButton setImage:self.user.avatarImage forState:UIControlStateNormal];
    
             
             
//             UIActionSheet *share = [[UIActionSheet alloc] initWithTitle:nil
//                                                                delegate:self
//                                                       cancelButtonTitle:@"取消"
//                                                  destructiveButtonTitle:@"照相"
//                                                       otherButtonTitles:@"相册",nil];
//             [share showInView:self.view];
//             [share release];
//    
        
                    
                  
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
                  
            
            UIButton *maleButton  = [UIButton buttonWithType:UIButtonTypeCustom];
            [maleButton setFrame:CGRectMake(210, 10, 25, 25)];
            [maleButton setImage:[UIImage imageNamed:@"gender_on.png"]
                                forState:UIControlEventTouchUpInside];
            [maleButton setImage:[UIImage imageNamed:@"gender_off.png"]
                                forState:UIControlStateNormal];

//            [cell addSubview:maleButton];
    
            UILabel *maleLabel =[[UILabel alloc]initWithFrame:CGRectMake(180, 10, 30, 30)];
            [maleLabel setText:@"男"];
            [maleLabel setBackgroundColor:[UIColor clearColor]];
                  
//            [cell addSubview:maleLabel];
            [maleLabel release];
            
            
    
            
//			cell.textLabel.text = NSLocalizedString(@"广东省广州市", @"Brightness");
//            
//            
//            cell.detailTextLabel.text  = @"更换地区";
//			
//            Citypicker *cp  = [[Citypicker alloc]init];
//            [self.navigationController pushViewController:cp animated:YES];
//            [cp release];
            
        
		
                        
//
//            NumberPickViewController *cp  = [[NumberPickViewController alloc]init];
//            [self.navigationController pushViewController:cp animated:YES];
//            [cp release];
		
            
//            //TODO
//            NumberPickViewController *cp  = [[NumberPickViewController alloc]init];
//            [self.navigationController pushViewController:cp animated:YES];
//            [cp release];
//        
        

    
    
      
//		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
//			cell.textLabel.text = NSLocalizedString(@"", @"Twitter");
//            [staticContentCell setCellStyle:UITableViewCellStyleValue1];
//            [staticContentCell setCellHeight:100];
//            
//            UITextView *moodTextView = [[UITextView alloc]initWithFrame:CGRectMake(20,0, 280,100)];
//            [moodTextView setBackgroundColor:[UIColor clearColor]];
//            [moodTextView setText:@"今天我很开心哦。我和女朋友去健身啦！"];
//            [moodTextView setFont:[UIFont fontWithName:nil size:30]];
//            [cell addSubview:moodTextView];
//            [moodTextView release];
        
    
}

            

#pragma mark --actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

        switch (buttonIndex) {
            case 0:
            {
                NSLog(@"Button index :%d",buttonIndex);
                [self takePhoto];
            }
                break;
            case 1:
            {
                NSLog(@"Button index :%d",buttonIndex);
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    // Configure the cell...
    
    switch (indexPath.section) {
        case 0:
        {
            PPDebug(@"");
            NSArray *array = [NSArray arrayWithObjects:@"更换头像",@"更换背景",@"更改用户名",@"更改个性签名",nil];

            [cell.detailTextLabel setText:[array objectAtIndex:indexPath.row]];
            ////
            if (indexPath.row ==0 ||indexPath.row ==1) {
                [cell.imageView setImage:[UIImage imageNamed:@"touxiang_40x40"]];

            }
            
            
            break;
        }
        case 1:
            PPDebug(@"");
            [cell.textLabel setText:@"标签"];

            break;
        case 2:
            PPDebug(@"");
            [cell.textLabel setText:[self.dataList objectAtIndex:indexPath.row]];
            break;
        case 3:
            PPDebug(@"");
            
            [cell.textLabel setText:@"城市"];
            
            break;
            
        default:
            break;
    }


    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
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
