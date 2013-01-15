//
//  SecondViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMStaticContentTableViewController.h"


@class User;
@interface Myself_SettingsViewController: JMStaticContentTableViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

{

    UIButton *_avatarButton;
    
 
    User *_user;
    
    BOOL didSave;
    
}
@property (nonatomic ,retain)  UIButton *avatarButton;
@property (nonatomic,retain)   User *user;


@end
