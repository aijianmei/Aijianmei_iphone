//
//  MyselfViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/12.
//
//

#import "MyselfViewController.h"
#import "MyselfTableViewCell.h"

#import "ImageManager.h"
#import "SettingsViewController.h"


#import "ShareToSinaController.h"
#import "ShareToQQWeiboController.h"

#import "ShareToQQViewController.h"

#import "SinaweiboManager.h"
#import "TencentWeiboManager.h"


#import "AppDelegate.h"


typedef enum SOCIAL_NET_WORK {
    SINA_WEIBO_ACCOUNT = 0,
    TENGXUN_QQ_ACOUNT = 1,
//    RENREN_ACOUNT = 2,
    TENGXUN_WEIBO_ACCOUNT,
//    DOUBAN_ACOUNT = 4,
//    YOUR_EMAIL_ACOUNT=5
    
}SOCIAL_NET_WORK;



enum ALERT_VIEW_TYPE {
    CHOOSE_IMAGE =0,
    
};

    
    
    
@interface MyselfViewController ()


@end

@implementation MyselfViewController
@synthesize sinaModeSwitch = _sinaModeSwitch;
@synthesize tenCentQQModeSwitch =_tenCentQQModeSwitch;
@synthesize tenCentWeiboModeSwitch =_tenCentWeiboModeSwitch;



@synthesize avatarImage;
@synthesize headerVImageButton=_headerVImageButton;
@synthesize myFooterView;
@synthesize myHeaderView;
@synthesize userNameLabel=_userNameLabel;




-(void)dealloc{
    
    
    [super dealloc];
    
    [_sinaModeSwitch release];
    [_tenCentWeiboModeSwitch release];
    [_tenCentQQModeSwitch release];
    
    [_headerVImageButton release];
    [_footerVImageV release];
    [_avatarImage  release];
    [myHeaderView release];
    [myFooterView release];
    [_userNameLabel release];
}


-(void)setUp{

    ///settings Button
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"设定" style:UIBarButtonItemStyleBordered target:self action:@selector(clickSettingsButton:)];
    NSArray *array = [[NSArray alloc]initWithObjects:rightBarButton, nil];
    [rightBarButton release];
    [self.navigationItem setRightBarButtonItems:array];
    [array release];
    
    
//   Get the sinaweibomanger
    sinaweiboManager = [self sinaweiboManager];
    tencentWeiboManager =[TencentWeiboManager defaultManager];
    NSString *STRING = [tencentWeiboManager.tengxunWeibo.accessTokenSecret description];
    NSLog(@"WHAT IS IT %@",STRING);

}


   
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setUp];

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
//    self.dataList = [NSArray arrayWithObjects:@"新浪微博",@"QQ账号",@"人人网账号",@"腾讯微博账号",@"豆瓣网账号",@"我的邮箱账号",@"", nil];
    self.dataList = [NSArray arrayWithObjects:@"新浪微博",@"QQ登陆",@"腾讯微博账号", nil];
    

    UIView *headerView =[[UIView alloc]init];
    UIView *footerView =[[UIView alloc]init];
       
    [headerView setFrame: CGRectMake(0, 0, 100, 200)];
    [footerView setFrame: CGRectMake(0, 0, 100, 100)];

    self.myHeaderView = headerView;
    self.myFooterView = footerView;

    [headerView release];
    [footerView release];
    
    // set up the table's header view based on our UIView 'myHeaderView' outlet
	CGRect newFrame = CGRectMake(0.0, 0.0,self.dataTableView.bounds.size.width, 100);
    
	self.myHeaderView.backgroundColor = [UIColor clearColor];
	self.myHeaderView.frame = newFrame;
    
    
    
    [self.dataTableView setTableHeaderView: self.myHeaderView];

    ////在heade上添加头像图片
    
    
    
    UIButton *button = [[UIButton alloc]init];
    self.headerVImageButton =  button;
    [button release];
    
    [self.headerVImageButton addTarget:self action:@selector(clickVatarButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.headerVImageButton setFrame:CGRectMake(20, 16, 70, 70)];
    [self.headerVImageButton setBackgroundColor:[UIColor redColor]];
    [self.headerVImageButton setImage:[ImageManager avatarbackgroundImage] forState:UIControlStateNormal];
    [self.myHeaderView addSubview:_headerVImageButton];
   
	
    [self.dataTableView setTableHeaderView:self.myHeaderView];
    
    
    
    
	// set up the table's footer view based on our UIView 'myFooterView' outlet
	newFrame = CGRectMake(0.0, 0.0, self.dataTableView.bounds.size.width, self.myFooterView.frame.size.height);
	self.myFooterView.backgroundColor = [UIColor clearColor];
	self.myFooterView.frame = newFrame;
    
    ////在heade上添加头像图片
    self.footerVImageV = [[UIImageView alloc]initWithImage:avatarImage];
    [self.myFooterView   addSubview:_footerVImageV];

	self.dataTableView.tableFooterView = self.myFooterView;	// note this will override UITableView's 'sectionFooterHeight' property
    
    
    [self setBackgroundImageName:@"Default@2x.png"];
    [self showBackgroundImage];
    

        
}
-(void)clickSettingsButton:(id)sender{
   
    SettingsViewController *settingsVC = [[SettingsViewController alloc]init];
    [self.navigationController pushViewController :settingsVC animated:YES];
    [settingsVC release];
}





-(void)switchsinaModeSwitch:(id)sender{
    
    self.sinaModeSwitch = (UISwitch *)sender;
    
    if ( [self.sinaModeSwitch isOn]) {
        NSLog(@"Sina switch is on  ");
    
        sinaweiboManager = [self sinaweiboManager];
        
        if ([sinaweiboManager.sinaweibo isLoggedIn]) {
            return;
        }
        [sinaweiboManager.sinaweibo logIn];
    
    }else
    {
        UIAlertView *alerView  = [[UIAlertView alloc]initWithTitle:@"授权" message:@"是否解除与新浪微博的绑定？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alerView show];
        [alerView release];
        [alerView setTag:SINA_WEIBO_ACCOUNT];
    }
}

-(void)switchTencentQQModeSwitch:(id)sender{
    
    self.tenCentQQModeSwitch = (UISwitch *)sender;
    
    if ( [self.tenCentQQModeSwitch isOn]) {
                
        PPDebug(@" tencent qq  on ");
        
        [self loginQQAccount];

    }else
    {
        UIAlertView *alerView  = [[UIAlertView alloc]initWithTitle:@"授权" message:@"是否解除与新浪微博的绑定？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alerView show];
        [alerView release];
        [alerView setTag:TENGXUN_QQ_ACOUNT];
        
        PPDebug(@" tencent qq  off ");
    }
}

-(void)switchTencentWeiboModeSwitch:(id)sender{
    
    self.tenCentWeiboModeSwitch = (UISwitch *)sender;
    
    if ( [self.tenCentWeiboModeSwitch isOn]) {
        
        if (tencentWeiboManager.tengxunWeibo.accessTokenKey && tencentWeiboManager.tengxunWeibo.accessTokenSecret) {
            
            [self.tenCentWeiboModeSwitch setOn:YES animated:YES];
            
            return;
        }
        
        else{
        [self showActivityWithText:@"请稍后"];
        [self loginTengxunWeiboAccount];
            
        }
    }else
    {
        
        UIAlertView *alerView  = [[UIAlertView alloc]initWithTitle:@"解除绑定" message:@"是否解除与腾讯微博的绑定？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alerView show];
        [alerView release];
        [alerView setTag:TENGXUN_WEIBO_ACCOUNT];
        
    }
}






-(void)viewDidUnload{

    [super viewDidUnload];
    self.headerVImageButton =nil;
    
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    [self.dataTableView reloadData];
    [self setUp];
    
    
    UIViewController *nv =[self.navigationController topViewController];
    [nv.navigationItem setTitle:@"我健美"];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(clickSettingsButton:)];
    [nv.navigationItem setLeftBarButtonItem:nil];
    [nv.navigationItem setRightBarButtonItem:rightBarButton];
    
    [self hideActivity];
    
}


-(void)clickVatarButton:(id)sender{
   
}

- (SinaweiboManager *)sinaweiboManager
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.sinaWeiboManager.sinaweibo setDelegate:self];
    return appDelegate.sinaWeiboManager;
}

#pragma mark -
#pragma mark - UIAlertViewDelegate

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

////根据alerview 的类型来确定。
    switch (alertView.tag) {
        case SINA_WEIBO_ACCOUNT:
            
        {
            if (buttonIndex==0) {
                PPDebug(@"SINA_WEIBO_ACCOUNT Cancle logout");
                [self.sinaModeSwitch setOn:YES animated:YES];
                return;
            } 
            
            [sinaweiboManager.sinaweibo logOut];
            [self.sinaModeSwitch setOn:NO animated:YES];

        }
            break;
            
            case TENGXUN_QQ_ACOUNT:
        {
            if (buttonIndex==0) {
                PPDebug(@"TENGXUN_QQ_ACOUNT Cancle logout");
                [self.tenCentQQModeSwitch setOn:YES animated:YES];
                return;
            }
            
            [sinaweiboManager.sinaweibo logOut];
            
            
            [self.sinaModeSwitch setOn:NO animated:YES];
            
        }
            break;
            
        case TENGXUN_WEIBO_ACCOUNT:
        {
          
            if (buttonIndex==0) {
                PPDebug(@"TENGXUN_WEIBO_ACCOUNT Cancle logout");
                [self.tenCentWeiboModeSwitch setOn:YES animated:YES];
                return;
            }
            
            [tencentWeiboManager removeAuthData];
            [self.tenCentWeiboModeSwitch setOn:NO animated:YES];
        }
        default:
            break;
    }

}




#pragma mark ----------------------------------------————————————————
#pragma mark  tableviewDelegate Method

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
{
    return @"绑定账号";
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
     
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

     NSString *CellIdentifier = [MyselfTableViewCell getCellIdentifier];

    MyselfTableViewCell *cell = (MyselfTableViewCell *)[self.dataTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if (cell) {
        cell = [[[MyselfTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.textLabel.text = [self.dataList objectAtIndex:indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        cell.textLabel.textColor=[UIColor colorWithRed:0x46/255.0 green:0x46/255.0 blue:0x46/255.0 alpha:1.0];
        
//        UIImage* image = [UIImage imageNamed:@"szicon_a.png"];
//        UIImageView* cellAccessoryView = [[UIImageView alloc] initWithImage:image];
//        cell.accessoryView = cellAccessoryView;
//        [cellAccessoryView release];
        
              
//        cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
//        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0x2F/255.0 green:0x76/255.0 blue:0xB9/255.0 alpha:1.0];
        
    

    }
    
    
//      cell.delegate = self;
//      cell.indexPath = indexPath;
//    if (indexPath.section==0) {
//        switch ([indexPath row]) {
//            case 0:
//                cell.imageView.image =[UIImage imageNamed:@"music-tab.png"];
//                cell.textLabel.text =[_dataList objectAtIndex:indexPath.row];
//                break;
//            case 1:
//                cell.textLabel.text =[_dataList objectAtIndex:indexPath.row];
//                cell.imageView.image =[UIImage imageNamed:@"artist-tab.png"];
//                break;
//                default:
//                break;
//        }
//    }
//    if (indexPath.section==1) {
//        switch ([indexPath row]) {
//            case 0:
//                cell.imageView.image =[UIImage imageNamed:@"music-tab.png"];
//                cell.textLabel.text =[_dataList objectAtIndex:indexPath.row];
//                break;
//            case 1:
//                cell.textLabel.text =[_dataList objectAtIndex:indexPath.row];
//                cell.imageView.image =[UIImage imageNamed:@"artist-tab.png"];
//                break;
//            default:
//                break;
//        }
//    }
    if (indexPath.section==0) {
        switch ([indexPath row]) {
            case SINA_WEIBO_ACCOUNT:
                cell.imageView.image =[ImageManager weiboImage];
                cell.textLabel.text =@"新浪微博";
    
                self.sinaModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                 [self.sinaModeSwitch addTarget: self action: @selector(switchsinaModeSwitch:) forControlEvents:UIControlEventValueChanged];
                
                if ([sinaweiboManager.sinaweibo isLoggedIn]) {
                    [self.sinaModeSwitch setOn:YES animated:NO];
                }else
                    
                {
                    [self.sinaModeSwitch setOn:NO animated:NO];
                }
                cell.accessoryView = self.sinaModeSwitch;
            
                break;
            case TENGXUN_QQ_ACOUNT:
                cell.textLabel.text =@"QQ账号";
                [cell.detailTextLabel setText: @"未绑定"];
                cell.imageView.image =[ImageManager qqImage];
                self.tenCentQQModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [self.tenCentQQModeSwitch addTarget: self action: @selector(switchTencentQQModeSwitch:) forControlEvents:UIControlEventValueChanged];
                
                if ([sinaweiboManager.sinaweibo isLoggedIn]) {
                    
                    [self.tenCentQQModeSwitch setOn:YES animated:NO];
       
                }else
                    
                {
                    [self.tenCentQQModeSwitch setOn:NO animated:NO];
                }
                
                cell.accessoryView = self.tenCentQQModeSwitch;
                
                break;
//            case RENREN_ACOUNT:
//                cell.textLabel.text =@"人人账号";
//                cell.detailTextLabel.text =@"未绑定";
//                cell.imageView.image =[ImageManager renrenImage];
//                break;
            case TENGXUN_WEIBO_ACCOUNT:
                cell.textLabel.text =@"腾讯微博账号";
                cell.detailTextLabel.text =@"未绑定";
                cell.imageView.image =[ImageManager tengxunWeiboImage];
                
                self.tenCentWeiboModeSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
                [self.tenCentWeiboModeSwitch addTarget: self action: @selector(switchTencentWeiboModeSwitch:) forControlEvents:UIControlEventValueChanged];
                
                
                if (tencentWeiboManager.tengxunWeibo.accessTokenKey && tencentWeiboManager.tengxunWeibo.accessTokenSecret) {
                    
                    [self.tenCentWeiboModeSwitch setOn:YES animated:NO];
                    
                
                }else
                    
                {
                    
                    [self.tenCentWeiboModeSwitch setOn:NO animated:NO];
                    
                }
                
                cell.accessoryView = self.tenCentWeiboModeSwitch;
                
                

                break;
//            case DOUBAN_ACOUNT:
//                cell.textLabel.text =@"豆瓣账号";
//                cell.detailTextLabel.text =@"未绑定";
//                cell.imageView.image =[ImageManager doubanImage];
//                break;
//            case YOUR_EMAIL_ACOUNT:
//                cell.textLabel.text =@"你的邮箱";
//                cell.detailTextLabel.text =@"未绑定";
//                cell.imageView.image =[ImageManager loginEmailImage];
//                break;
            default:
                break;
        }
    }
    
    
//    [cell  setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

#pragma mark-
-(void)loginSinaAccount
{
    [self showActivityWithText:@"请稍后"];
    sinaweiboManager = [self sinaweiboManager];
    
    if ([sinaweiboManager.sinaweibo isLoggedIn]) {
        NSLog(@"Current weibo account is avaiable");
        return;
    }
    
    if (![sinaweiboManager.sinaweibo isAuthValid]) {
        [sinaweiboManager.sinaweibo logIn];
        NSLog(@"The sina weibo authou is not avaiable");
    }
}

-(void)loginQQAccount{
    [self showActivityWithText:@"请稍后"];
    ShareToQQViewController *vc = [[ShareToQQViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
}

-(void)loginRenrenAccount{
    
       
}

-(void)loginTengxunWeiboAccount{
    
    [self showActivityWithText:@"请稍后"];
    ShareToQQWeiboController *vc  = [[ShareToQQWeiboController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

-(void)loginDoubanAccount{
    
}

-(void)loginYouremailAccount{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        switch (indexPath.row) {
            case SINA_WEIBO_ACCOUNT:
//                [self loginSinaAccount];
                break;
            case TENGXUN_QQ_ACOUNT:
//                [self loginQQAccount];
                break;
//            case RENREN_ACOUNT:
//                [self loginRenrenAccount];
//                break;
            case TENGXUN_WEIBO_ACCOUNT:
//                [self loginTengxunWeiboAccount];
                break;
//            case DOUBAN_ACOUNT:
//                [self loginDoubanAccount];
//                break;
//            case YOUR_EMAIL_ACOUNT:
//                [self loginYouremailAccount];
//                break;
            default:
                break;
        }
    }
}



#pragma mark -
#pragma SinaWeiboDelegate methods
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    PPDebug(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [sinaweiboManager storeAuthData];
    [self.dataTableView reloadData];
    
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    PPDebug(@"sinaweiboDidLogOut");
    [sinaweiboManager removeAuthData];
    [self.dataTableView reloadData];

}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    PPDebug(@"sinaweiboLogInDidCancel");
    [self.dataTableView reloadData];

}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    PPDebug(@"sinaweibo logInDidFailWithError %@", error);
    [self.dataTableView reloadData];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    PPDebug(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [sinaweiboManager removeAuthData];
    [self.dataTableView reloadData];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
