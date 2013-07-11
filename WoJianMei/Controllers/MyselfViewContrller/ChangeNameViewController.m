//
//  ChangeNameViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/9/13.
//
//

#import "ChangeNameViewController.h"
#import "UserService.h"
#import "User.h"

@interface ChangeNameViewController ()

@end

@implementation ChangeNameViewController
@synthesize nameTextField =_nameTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)dealloc{
    [_nameTextField release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    [self setNavigationLeftButton:@"返回" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];
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
    [accessoryViewButton addTarget:self action:@selector(clickDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    User *user =  [[UserService defaultService]user];
    
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(5.0f, 12.0f, 250.0f,32.0f)];
    _nameTextField.delegate = self;
    [_nameTextField setTextAlignment:NSTextAlignmentLeft];
    [cell.contentView addSubview:_nameTextField];
    [_nameTextField setText:user.name];
    [_nameTextField becomeFirstResponder];
    
    
    // Configure the cell...
    cell.accessoryView = accessoryViewButton;
    
    return cell;
}

-(void)clickDeleteButton:(UIButton*)sender{
    [_nameTextField setText:@""];
}


#pragma mark - 
#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

    User *user =[[UserService defaultService] user];
    user.name = textField.text;
    [[UserService defaultService] setUser:user];
    
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
