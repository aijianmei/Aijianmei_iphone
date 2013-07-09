//
//  ChangeNameViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/9/13.
//
//

#import "ChangeNameViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
    [self setNavigationRightButton:@"保存" imageName:@"top_bar_commonButton.png" action:@selector(clickSaveButton)];

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell.imageView  setImage:nil];
    [cell.textLabel setText:nil];
    cell.accessoryView = nil;
    
    /////
    UIImage *normalImage = [UIImage imageNamed:@"AccessoryView.png"];
    //    UIImage *mySelectedImage = [UIImage imageNamed:@"144x144.png"];
    
    UIButton *accessoryViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    accessoryViewButton.frame = CGRectMake(0.0f, 0.0f, 32.0f,32.0f);
    accessoryViewButton.userInteractionEnabled = YES;
    [accessoryViewButton setImage:normalImage forState:UIControlStateNormal];
    
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(5.0f, 12.0f, 250.0f,32.0f)];
    textField.backgroundColor =[UIColor redColor];
    [textField setTextAlignment:NSTextAlignmentLeft];
    [cell.contentView addSubview:textField];
    [textField setText:@"唐亮"];
    [textField release];
    
    
    // Configure the cell...
    cell.accessoryView = accessoryViewButton;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */



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
