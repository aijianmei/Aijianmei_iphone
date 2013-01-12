//
//  SinaUsersViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/12/13.
//
//

#import "SinaUsersViewController.h"

@interface SinaUsersViewController ()

@end

@implementation SinaUsersViewController

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
	// Do any additional setup after loading the view.
}
#pragma mark - Table view data source
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
        {
            return  @"寻找好友";
        }
            break;
        case 1:
        {
            return  @"推荐好友";
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    switch (section) {
        case 0:
        {
            return 2;
            
        }
            break;
        case 1:
        {
            return 1;
            
        }
            break;
            
        default:
            break;
    }
    return 1;
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SinaUser";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    
    // Configure the cell...
    
    // set backgroudView
    UIImageView *imageView = nil;
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row==0) {
                
                [cell.textLabel setText:@"爱健美站内搜索"];
                imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_cell_background.png"]];
                
                
            }else{
                
                [cell.textLabel setText:@"新浪微博上"];
                imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottom_cell_background.png"]];
            }
        }
            break;
        case 1:
        {
            [cell.textLabel setText:@"热门健身爱好者"];
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"singleCellBackgroud.png"]];
            
            
        }
            break;
            
            
        default:
            break;
    }
    
    [imageView release];
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row ==0) {
                ////section 0  row 0
                
                
                
                
            }else{
                ////section 1  row 0
                
                [self performSegueWithIdentifier:@"SinaUsers" sender:self];
                
                
            }
        }
            break;
            
        case 1:
        {
            ////section 1  row 0
            
            
        }
            break;
            
        default:
            break;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
