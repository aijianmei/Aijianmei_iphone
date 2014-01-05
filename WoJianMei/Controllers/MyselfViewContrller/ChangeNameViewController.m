//
//  ChangeNameViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/9/13.
//
//

#import "ChangeNameViewController.h"
#import "UserManager.h"
#import "User.h"
#import "ChangeNameCell.h"

@interface ChangeNameViewController ()

@end

@implementation ChangeNameViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)dealloc{

    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
     [self setNavigationRightButton:@"" imageName:@"Save.png" action:@selector(clickBack:)];
//    [self setNavigationRightButton:@"保存" imageName:@"top_bar_commonButton.png" action:@selector(clickSaveButton)];
    
    [currentTextField setClearsOnBeginEditing:NO];
    
    
    //停顿一会儿之后显示键盘
    float duration =0.4;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                  target:self
                                                selector:@selector(showKeyBoard)
                                                userInfo:nil
                                                 repeats:NO];
    

}


#pragma mark -
#pragma mark - ShowKeyBoard Method

-(void)showKeyBoard{
    [currentTextField becomeFirstResponder];
    [self.timer invalidate];
}


-(void)clickSaveButton{

    PPDebug(@"Did click save button!");
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ChangeNameCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ChangeNameCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [cell.imageView  setImage:nil];
    [cell.textLabel setText:nil];
    cell.accessoryView = nil;
    
    /////
    UIImage *normalImage = [UIImage imageNamed:@"Name_delete.png"];
    
    UIButton *accessoryViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    accessoryViewButton.frame = CGRectMake(0.0f, 0.0f, 32.0f,32.0f);
    accessoryViewButton.userInteractionEnabled = YES;
    [accessoryViewButton setImage:normalImage forState:UIControlStateNormal];
    [accessoryViewButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    User *user =  [[UserManager defaultManager] user];
    [cell.nameTextField setText:user.name];
    currentTextField = cell.nameTextField;
    // Configure the cell...
    cell.accessoryView = accessoryViewButton;
    
    return cell;
}

-(void)clickDeleteButton:(UIButton*)sender{
    [currentTextField setText:nil];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
