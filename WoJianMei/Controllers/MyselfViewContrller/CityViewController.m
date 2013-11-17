//
//  CityViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/10/13.
//
//

#import "CityViewController.h"
#import "PickCityCell.h"
#import "MyselfViewController.h"
#import "UserManager.h"
#import "user.h"


@interface CityViewController ()

@end

@implementation CityViewController
@synthesize citiesList =_citiesList;
@synthesize selectedCity =_selectedCity;
@synthesize selectedProvince =_selectedProvince;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [_citiesList release];
    [_selectedCity release];
    [_selectedProvince release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    
    self.dataList =_citiesList;
    // 当前所在省份或者区域
    [self setTitle:self.selectedProvince];

}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataList count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PickCityCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[PickCityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [cell.textLabel setText:nil];
    
    /////
    UIImage *normalImage = [UIImage imageNamed:@"AccessoryView.png"];
    //    UIImage *mySelectedImage = [UIImage imageNamed:@"144x144.png"];
    
//    UIButton *accessoryViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    accessoryViewButton.frame = CGRectMake(0.0f, 0.0f, 32.0f,32.0f);
//    accessoryViewButton.userInteractionEnabled = YES;
//    [accessoryViewButton setImage:normalImage forState:UIControlStateNormal];
    
    
    
    // Configure the cell...
//    cell.accessoryView = accessoryViewButton;
    
    [cell.textLabel setText:[[self.dataList objectAtIndex:indexPath.row] objectForKey:@"city"]];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    
    User *user = [[UserManager defaultManager] user];

    NSString *city = [[self.dataList objectAtIndex:indexPath.row] objectForKey:@"city"];
        
//    if ([user.city isEqualToString:city]) {
//        cell.textLabel setTextColor:[UIColor greenColor];
//
//    }

   
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    UIImage *normalImage = [UIImage imageNamed:@"AccessoryView.png"];
    //    UIImage *mySelectedImage = [UIImage imageNamed:@"144x144.png"];
    
    UIButton *accessoryViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    accessoryViewButton.frame = CGRectMake(0.0f, 0.0f, 32.0f,32.0f);
    accessoryViewButton.userInteractionEnabled = YES;
    [accessoryViewButton setImage:normalImage forState:UIControlStateNormal];
    
    self.selectedCity =[[self.dataList objectAtIndex:indexPath.row ]objectForKey:@"city"];
    
    NSLog(@"所在区域 :%@%@",self.selectedProvince,self.selectedCity);
    
   
    User *user = [[UserManager defaultManager] user];
    
    [user setCity:self.selectedCity];
    [user setProvince:self.selectedProvince];
    
    [[UserManager defaultManager] setUser:user];
    [[UserManager defaultManager] storeUserInfoByUid:user.uid];
    [self.navigationController popViewControllerAnimated:YES];
    
    //TODO
    /* 数据接口:
      格式 ：数据格式为字符串
      NSString* Province + NSString* Province 省份+城市
     */
    
   
    
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
