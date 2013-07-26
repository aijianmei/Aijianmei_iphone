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


@class User;
@interface Myself_SettingsViewController: PPTableViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,RKObjectLoaderDelegate,MyselfSettingCellDelegate>

{

    UIButton *_avatarButton;
    
 
    User *_user;
    
    BOOL didSave;
        
    BOOL isChoosingAvtarImage;
    BOOL isChoosingAvtarBackground;


    
}
@property (nonatomic ,retain)  UIButton *avatarButton;
@property (nonatomic,retain)   User *user;

-(void)didClickBackButton:(UIButton *)button;


@end
