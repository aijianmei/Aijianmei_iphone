//
//  SideMenuViewController.m
//  MFSideMenuDemo
//
//  Created by Michael Frederick on 3/19/12.

#import "SideMenuViewController.h"
#import "MFSideMenu.h"
#import "DemoViewController.h"

@implementation SideMenuViewController
@synthesize sectionTitlesArray =_sectionTitlesArray;
@synthesize headerView =_headerView;


-(void)dealloc{
    [super dealloc];
    [_sectionTitlesArray release];
    [_headerView release];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    
///3 buttons 
    
    UIButton *typeButton  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [typeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_whitebtn2.png"] forState:UIControlEventTouchUpOutside];
    
    
    UIButton *aimButton  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [aimButton setBackgroundImage:[UIImage imageNamed:@"tabbar_whitebtn2.png"] forState:UIControlEventTouchUpOutside];
    
    
    UIButton *bodyPartButton  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [bodyPartButton setBackgroundImage:[UIImage imageNamed:@"tabbar_whitebtn2.png"] forState:UIControlEventTouchUpOutside];
    
    
    
    
    [typeButton setFrame:CGRectMake(20, 5, 70, 40)];
    [aimButton setFrame:CGRectMake(100,5,70, 40)];
    [bodyPartButton setFrame:CGRectMake(180,5,70, 40)];

    
    

    [typeButton setTitle:@"健身类型" forState:UIControlStateNormal];
    [aimButton setTitle:@"健身目的" forState:UIControlStateNormal];
    [bodyPartButton setTitle:@"健身部位" forState:UIControlStateNormal];


    
    
    [view addSubview:typeButton];
    [view addSubview:aimButton];
    [view addSubview:bodyPartButton];
    
    self.headerView = view;
    [view release];
    [self.tableView setTableHeaderView:self.headerView];
    
    
}


#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %d", section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Item %d", indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    DemoViewController *demoController = [[[DemoViewController alloc] initWithNibName:@"DemoViewController" bundle:nil] autorelease];
//    demoController.title = [NSString stringWithFormat:@"Demo Controller #%d-%d", indexPath.section, indexPath.row];
//    
//    NSArray *controllers = [NSArray arrayWithObject:demoController];
//  [MFSideMenuManager sharedManager].navigationController.viewControllers = controllers;
 [MFSideMenuManager sharedManager].navigationController.menuState = MFSideMenuStateHidden;
    
    
    
}

@end
