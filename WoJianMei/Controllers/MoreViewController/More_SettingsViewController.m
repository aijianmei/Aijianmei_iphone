//
//  SecondViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 7/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "More_SettingsViewController.h"
#import "AppDelegate.h"


@interface More_SettingsViewController ()

@property (nonatomic, retain) UISwitch *sinaModeSwitch;
@property (nonatomic, retain) UISwitch *tencentWeiboModeSwitch;
@property (nonatomic, retain) UISwitch *tencentQQModeSwich;
@property (nonatomic, retain) UISwitch *renrenModeSwitch;

@end


@implementation More_SettingsViewController
@synthesize sinaModeSwitch = _sinaModeSwitch;
@synthesize tencentWeiboModeSwitch = _tencentWeiboModeSwitch;
@synthesize tencentQQModeSwich = _tencentQQModeSwich;
@synthesize renrenModeSwitch = _renrenModeSwitch;





- (id) init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (!self) return nil;
    
	self.title = NSLocalizedString(@"Settings", @"Settings");
    
	return self;
}

-(void)dealloc{
    
    [_sinaModeSwitch release];
    [_tencentQQModeSwich release];
    [_tencentWeiboModeSwitch release];
    [_renrenModeSwitch release];
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
// 
//    switch (buttonIndex) {
//        case 0:
//        {
//            NSLog(@"取消");
//        
//        }
//            break;
//        case 1:
//        {
//            
//            if ([alertView.message hasSuffix:@"新浪微博吗？"]) {
//                
//                NSLog(@"logout  : [%@]",alertView.message);
//                
//
//            } else if ([alertView.message 
//                
//                
//            }else if ([alertView.message hasSuffix:@"QQ吗？"]) {
//                
//            }
//            }else
//                
//            {
//                
//                NSLog(@"logout the renren");
//                
//            }
//
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
    
                        
}


-(void)showAlertViewWithMessage :(NSString *)message{

    UIAlertView *al = [[UIAlertView alloc]initWithTitle:@"退出绑定" message:message  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [al show];
    [al release];
    
    
}









#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"设置", @"Settings");
    self.sinaModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    self.tencentQQModeSwich = [[UISwitch alloc] initWithFrame:CGRectZero];
    self.tencentWeiboModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    self.renrenModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];

    
    [self initSocialNetWorkAccountSection];
    [self changePasswords];

    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.sinaModeSwitch = nil;
    self.tencentWeiboModeSwitch = nil;
    self.tencentQQModeSwich = nil;
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self.tableView reloadData];
}



#pragma mark - Social_NetWork_Account
-(void)initSocialNetWorkAccountSection{
    
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex)
     
     {
         [section setTitle:@"绑定账号"];
         
         //// add a row at the section one
         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
             staticContentCell.cellStyle = UITableViewCellStyleValue1;
             staticContentCell.reuseIdentifier = @"DetailTextCell";
             cell.textLabel.text = NSLocalizedString(@"新浪微博", @"Wi-Fi");
             cell.detailTextLabel.text  =NSLocalizedString(@"未绑定", @"Airplane Mode");
             cell.detailTextLabel.textColor = [UIColor redColor];
             
//             if ([self isSinaWeiboLoggedIn]) {
//                 cell.detailTextLabel.textColor = [UIColor greenColor];
//                 cell.detailTextLabel.text  =NSLocalizedString(@"已绑定", @"Airplane Mode");
//             }

             cell.imageView.image = [UIImage imageNamed:@"AirplaneMode"];
             
         }whenSelected:^(NSIndexPath *indexPath){
             ///TODO
          
//             if ([self isSinaWeiboLoggedIn]) {
//                 [self showAlertViewWithMessage:@"你确定要解除绑定新浪微博吗？"];
//
//             }else{
//                 
//                 [self loginSinaweibo];
//             }
           }];
         
         //// add a row at the section one
         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
             staticContentCell.cellStyle = UITableViewCellStyleValue1;
             staticContentCell.reuseIdentifier = @"DetailTextCell";
             cell.imageView.image = [UIImage imageNamed:@"AirplaneMode"];
             cell.textLabel.text = @"腾讯微博";
             cell.detailTextLabel.text = @"未绑定";
             cell.detailTextLabel.textColor = [UIColor redColor];
             
             
                 cell.detailTextLabel.text = @"已绑定";
                 [cell.detailTextLabel setTextColor:[UIColor greenColor]];
            
             
            
         } whenSelected:^(NSIndexPath *indexPath) {
            
                 
                 [self showAlertViewWithMessage:@"你确定要退出绑定腾讯微博吗？"];
                 
                              
            
             
         }];
         
         //// add a row at the section one
         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
             staticContentCell.cellStyle = UITableViewCellStyleValue1;
             staticContentCell.reuseIdentifier = @"DetailTextCell";
             cell.textLabel.text = NSLocalizedString(@"QQ账号", @"Notifications");
             cell.detailTextLabel.text = @"未绑定";
             [cell.detailTextLabel setTextColor:[UIColor redColor]];
//             
//             if ([[tencentQQManager tencentOAuth] isLogIn]) {
                 cell.detailTextLabel.text = @"已绑定";
                 [cell.detailTextLabel setTextColor:[UIColor greenColor]];
//             }
             cell.imageView.image = [UIImage imageNamed:@"Notifications"];
         } whenSelected:^(NSIndexPath *indexPath) {
             
             if ([[[self tencentOAuthManager] tencentOAuth] isLogIn]) {
                 [self showAlertViewWithMessage:@"你确定要解除绑定QQ吗？"];
                 
                 
             }else{
                 
                 [self  loginTencentQQ];
                 
            }
         }];
         
         //// add a row at the section one
         [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
             staticContentCell.cellStyle = UITableViewCellStyleValue1;
             staticContentCell.reuseIdentifier = @"DetailTextCell";
             
             cell.textLabel.text = @"人人网";
             cell.imageView.image = [UIImage imageNamed:@"Notifications"];
             cell.detailTextLabel.text = @"未绑定";
             [cell.detailTextLabel setTextColor:[UIColor redColor]];

//             if ( [self isSinaWeiboLoggedIn]) {
//                 cell.detailTextLabel.text = @"已绑定";
//                 [cell.detailTextLabel setTextColor:[UIColor greenColor]];
//             }
             
    
         } whenSelected:^(NSIndexPath *indexPath) {
             //TODO
             
             
             
         }];
     }];
}




#pragma mark - changePasswords

-(void)changePasswords{
    
    ///////Section 2
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"修改密码", @"Sounds");
			cell.imageView.image = [UIImage imageNamed:@"Sounds"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
        //		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
        //			cell.textLabel.text = NSLocalizedString(@"Brightness", @"Brightness");
        //			cell.imageView.image = [UIImage imageNamed:@"Brightness"];
        //		} whenSelected:^(NSIndexPath *indexPath) {
        //			//TODO
        //		}];
        //
        //		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
        //			cell.textLabel.text = NSLocalizedString(@"Wallpaper", @"Wallpaper");
        //		} whenSelected:^(NSIndexPath *indexPath) {
        //			//TODO
        //		}];
        
        
	}];
    
}



#pragma mark - toDoMethods

-(void)toDoMethods{

	[self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            cell.textLabel.text = NSLocalizedString(@"General", @"General");
			cell.imageView.image = [UIImage imageNamed:@"General"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"iCloud", @"iCloud");
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Mail, Contacts, Calendars", @"Mail, Contacts, Calendars");
			cell.imageView.image = [UIImage imageNamed:@"Mail"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Twitter", @"Twitter");
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Phone", @"Phone");
			cell.imageView.image = [UIImage imageNamed:@"Phone"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"FaceTime", @"FaceTime");
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Safari", @"Safari");
			cell.imageView.image = [UIImage imageNamed:@"Safari"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Messages", @"Messages");
			cell.imageView.image = [UIImage imageNamed:@"Messages"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Music", @"Music");
			cell.imageView.image = [UIImage imageNamed:@"Music"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Video", @"Video");
			cell.imageView.image = [UIImage imageNamed:@"Video"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Photos", @"Photos");
			cell.imageView.image = [UIImage imageNamed:@"Photos"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Notes", @"Notes");
			cell.imageView.image = [UIImage imageNamed:@"Notes"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
			cell.textLabel.text = NSLocalizedString(@"Store", @"Store");
			cell.imageView.image = [UIImage imageNamed:@"AppStore"];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
	}];
    
    
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
