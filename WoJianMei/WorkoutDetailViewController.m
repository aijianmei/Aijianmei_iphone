//
//  WorkoutDetailViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/27/13.
//
//

#import "WorkoutDetailViewController.h"
#import "WorkoutCatalog.h"
#import "WorkoutMainViewController.h"
#import "UserService.h"
#import "User.h"
#import "WorkoutDataService.h"
#import "Result.h"


@interface WorkoutDetailViewController ()

@end

@implementation WorkoutDetailViewController
@synthesize workoutArray =_workoutArray;
@synthesize delegate =_delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{

    [_workoutArray release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];

    
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    
    
    //设置应用程序的状态栏到指定的方向
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
    
//    //view旋转
//    [self.view setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    
    self.dataList = self.workoutArray;
    
    
}



-(void)viewWillAppear:(BOOL)animated
{
    //隐藏navigationController
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    //隐藏状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewWillDisappear:(BOOL)animated
{
    //显示状态栏
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
//    //显示navigationController
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    Workout *workout = [self.dataList objectAtIndex:indexPath.row];
    [cell.textLabel setText:workout.name];
    [cell.textLabel setTextColor:[UIColor grayColor]];

    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    Workout *chosenWorkout = [self.dataList objectAtIndex:indexPath.row];
    [self popupMessage:chosenWorkout.name
                 title:@"你选择了:"];
    
    _choosenWorkout = chosenWorkout;
    User *user =  [[UserService defaultService] user];
    [[WorkoutDataService sharedService] postWorkoutCatalogListWithUserId:user.uid
                                                                actionId:chosenWorkout._id       delegate:self];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - RKObjectLoaderDelegate

- (void)objectLoader:(NSString *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects count: %d", [objects count]);
    [self hideActivity];
    
    NSObject *object = [objects objectAtIndex:0];
    if([object isMemberOfClass:[Result class]]) {
        
        WorkoutMainViewController *vc = [[self.navigationController viewControllers] objectAtIndex:1];
        self.delegate = vc;

        if ([self.delegate respondsToSelector:@selector(loadWorkoutCatalogMenueWithWorkout:)]){
            //下载用户的个性化锻炼目录
            [self.delegate loadWorkoutCatalogMenueWithWorkout:_choosenWorkout];
        }
        
        [self.navigationController popToViewController:vc animated:YES];
    }
}

@end
