//
//  SecondViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import <RestKit/RestKit.h>
#import "MyselfSettingCell.h"
#import "TPKeyboardAvoidingTableView.h"



@class User;
@interface Myself_SettingsViewController: PPTableViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,RKObjectLoaderDelegate,MyselfSettingCellDelegate>

{

    UIButton *_avatarButton;
    
 
    UIImage *_avtarImage;
    
    User *_user;
    
    BOOL didSave;
        
    BOOL isChoosingAvtarImage;
    BOOL isChoosingAvtarBackground;
    NSIndexPath *BMIindexPath;

    
}
@property (nonatomic ,retain)  UIButton *avatarButton;
@property (nonatomic,retain)   User *user;
@property (nonatomic,retain) UIImage *avtarImage;

-(void)didClickBackButton:(UIButton *)button;

-(UIImage*)loadImageInDirectory:(NSString *)directoryPath;
@end
