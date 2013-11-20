//
//  WorkoutFirstTypeViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/26/13.
//
//

#import "WorkoutFirstTypeViewController.h"
#import "WorkoutDataService.h"
#import "WorkoutCatalog.h"
#import "WorkoutDetailViewController.h"
#import "UserService.h"



@interface WorkoutFirstTypeViewController ()

@end

@implementation WorkoutFirstTypeViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
//    //设置应用程序的状态栏到指定的方向
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
//    
//    //view旋转
//    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
//    
    
    
    
    
    //获取用户的运动项目列表，其中里边有用户的个性化列表
    User *user = [[UserService defaultService] user];
    [[WorkoutDataService sharedService] loadWorkoutCatalogListWithUid:user.uid delegate:self];
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
//    //隐藏navigationController
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    //隐藏状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewWillDisappear:(BOOL)animated
{
//    //显示状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
//    //显示navigationController
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell.detailTextLabel setText:nil];
    
    
    UIImage *normalImage = [UIImage imageNamed:@"jt_1.png"];    
    UIButton *accessoryViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    accessoryViewButton.frame = CGRectMake(0.0f, 0.0f, 32.0f,32.0f);
    accessoryViewButton.userInteractionEnabled = YES;
    [accessoryViewButton setImage:normalImage forState:UIControlStateNormal];
    [cell.accessoryView setBackgroundColor:[UIColor clearColor]];
    cell.accessoryView = accessoryViewButton;

    
    // Configure the cell...
    WorkoutCatalog *workoutCatalog = [self.dataList objectAtIndex:indexPath.row];
    [cell.textLabel setText:workoutCatalog.part];
    if (indexPath.row ==0) {
    [cell.detailTextLabel setText:@"您的个性化锻炼计划!爱健美，记录你曾经选择过的锻炼计划！"];
    }

    [cell.textLabel setTextColor:[UIColor grayColor]];

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     WorkoutDetailViewController *detailViewController = [[WorkoutDetailViewController alloc] initWithNibName:@"WorkoutDetailViewController" bundle:nil];
    detailViewController.workoutArray = [[self.dataList objectAtIndex:indexPath.row] workouts];
    
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     
}


#pragma mark -
#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(NSString *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects count: %d", [objects count]);
    [self hideActivity];
    
    if ([objects count]==0) {
        return;
    }
    
     WorkoutCatalog *workoutCatalog =  [objects objectAtIndex:0];
     Workout *workout =  [workoutCatalog.workouts objectAtIndex:0];
    
    PPDebug(@"####%@#####",workout._id);
    PPDebug(@"####%@#####",workout.name);
    self.dataList = objects;
    [self.dataTableView reloadData];
    
    
}












@end
