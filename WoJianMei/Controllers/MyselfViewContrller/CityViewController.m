//
//  CityViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/10/13.
//
//

#import "CityViewController.h"

@interface CityViewController ()

@end

@implementation CityViewController
@synthesize citiesList =_citiesList;


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
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    self.dataList =_citiesList;

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
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
    
    ///先出去省份
    [cell.textLabel setText:[[self.dataList objectAtIndex:indexPath.row] objectForKey:@"city"]];
    
        
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
    

    // Configure the cell...
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
