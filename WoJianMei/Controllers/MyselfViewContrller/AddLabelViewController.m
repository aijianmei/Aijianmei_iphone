//
//  AddLabelViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/12/13.
//
//



#import "AddLabelViewController.h"
#import "AddLabelCell.h"


@interface AddLabelViewController ()

@end

@implementation AddLabelViewController



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
    [self setNavigationRightButton:@"保存" imageName:@"top_bar_commonButton.png" action:@selector(clickBack:)];
    //    [self setNavigationRightButton:@"保存" imageName:@"top_bar_commonButton.png" action:@selector(clickSaveButton)];
    
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
    AddLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[AddLabelCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
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
