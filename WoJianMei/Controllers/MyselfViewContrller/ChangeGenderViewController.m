//
//  ChangeGenderViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/9/13.
//
//

#import "ChangeGenderViewController.h"
#import "UserService.h"
#import "User.h"

@interface ChangeGenderViewController ()

@end

@implementation ChangeGenderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    [self setNavigationRightButton:@"保存" imageName:@"top_bar_commonButton.png" action:@selector(clickSaveButton:)];
    
    User *user = [[UserService defaultService]user];
    [self setTitle:user.gender];

}

-(void)clickSaveButton:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    /////
    UIImage *selected_Image = [UIImage imageNamed:@"gender_on.png"];
    
    UIButton *accessoryViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    accessoryViewButton.frame = CGRectMake(0.0f, 0.0f, 32.0f,32.0f);
    accessoryViewButton.userInteractionEnabled = YES;
    [accessoryViewButton setImage:selected_Image forState:UIControlStateNormal];
    cell.accessoryView = nil;

    
    User *user = [[UserService defaultService]user];

    // Configure the cell...
    switch (indexPath.row) {
        case 0:
        {
               
            [cell.textLabel setText:@"男"];
            
            if ([user.gender isEqualToString:@"男"]) {
                cell.accessoryView = accessoryViewButton;
            }
        }
            break;
        case 1:
        {
            [cell.textLabel setText:@"女"];
            
            if ([user.gender isEqualToString:@"女"]) {
                /////
                cell.accessoryView = accessoryViewButton;
            }


        }
            break;
            
        default:
            break;
    }
    
    [cell.textLabel setTextColor:[UIColor grayColor]];
    
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    switch (indexPath.row) {
        case 0:
        {
            User *user = [[UserService defaultService]user];
            [user setGender:@"男"];
        }
            break;
        case 1:
        {
            User *user = [[UserService defaultService]user];
            [user setGender:@"女"];
            
        }
            break;
            
        default:
            break;
    }
    [dataTableView reloadData];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
