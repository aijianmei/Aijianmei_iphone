//
//  CityManagerViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/10/13.
//
//

#import "ProvinceViewController.h"
#import "CityViewController.h"
#import "ProvinceCell.h"
#import "User.h"
#import "UserService.h"

@interface ProvinceViewController ()

@end

@implementation ProvinceViewController
@synthesize pickResult =_pickResult;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
    [_pickResult release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ///设置背景
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    /// 设置导航按钮
    
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    
    [self updateUI];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self updateUI];

    
}


-(void)updateUI{
    User *user = [[UserService defaultService] user];
    [[UserService defaultService] storeUserInfoByUid:user.uid];
    NSString *location = [NSString stringWithFormat:@"%@%@",user.province,user.city];
    [self setTitle:location];
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
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ProvinceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ProvinceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [cell.textLabel setText:nil];
    
    /////
    UIImage *normalImage = [UIImage imageNamed:@"jt_1.png"];    
    UIButton *accessoryViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    accessoryViewButton.frame = CGRectMake(0.0f, 0.0f, 32.0f,32.0f);
    accessoryViewButton.userInteractionEnabled = YES;
    [accessoryViewButton setImage:normalImage forState:UIControlStateNormal];
    
    
    
    // Configure the cell...
    cell.accessoryView = accessoryViewButton;
    
    ///先选省份
    NSArray *provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    [cell.textLabel setText:[[provinces objectAtIndex:indexPath.row] objectForKey:@"state"]];
    
    [cell.textLabel setTextColor:[UIColor grayColor]];

    
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    CityViewController *vc = [[CityViewController alloc]initWithNibName:@"CityViewController" bundle:nil ];
    NSArray *area = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    NSArray *cities = [[area objectAtIndex:indexPath.row] objectForKey:@"cities"];
    vc.citiesList =cities;
    //获取已经选择的地区或者省份
    
    NSArray *provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    vc.selectedProvince = [[provinces objectAtIndex:indexPath.row] objectForKey:@"state"];
    PPDebug(@"你选择的地区:%@",vc.selectedProvince);
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
