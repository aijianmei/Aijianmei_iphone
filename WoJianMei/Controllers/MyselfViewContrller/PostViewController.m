//
//  PostViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/6/13.
//
//

#import "PostViewController.h"
#import "UIImage+Scale.h"
#import "UIImageUtil.h"
#import "PostService.h"
#import "PostViewCell.h"
#import "UserService.h"
#import "User.h"
#import "PostStatus.h"
#import "UserService.h"
#import "User.h"

@interface PostViewController ()


@end

@implementation PostViewController
@synthesize postImage =_postImage;
@synthesize delegate =_delegate;
@synthesize postText =_postText;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc{
    [_postText release];
    [_postImage release];
    [super dealloc];
}

-(UIImage*)readArticleListFromDiskWithFileName:(NSString *)fileName
{
    /* /var/mobile/Applications/A2CE33CB-8713-44DC-A196-9017CAE9CC72/Documents/CurrentIndex-1
    */
    NSString *path = [NSString stringWithFormat:@"/var/mobile/Applications/A2CE33CB-8713-44DC-A196-9017CAE9CC72/Documents/%@",fileName];
    NSData *data=[NSData dataWithContentsOfFile:path options:0 error:NULL];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}


-(void)setup{
    
    //320
    //2592-----1936
    //1936-----2592

    // 1:1.3    1.3 :1
    
    PPDebug(@"*****%f,%f****",
            self.postImage.size.width,
            self.postImage.size.height);
    
    UIImage *reSizeImage = nil;
    
    if (self.postImage.size.width  < self.postImage.size.height) {
    reSizeImage= [self.postImage scaleToSize:CGSizeMake(320, 320 * 1.32)];
    }else{
    reSizeImage= [self.postImage scaleToSize:CGSizeMake(320, 320/1.32)];
    }
    
    
    NSData *imageData = UIImageJPEGRepresentation(reSizeImage, 1.0);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *tmpPathToFile = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/currentPost.png", path]];
    
    if([imageData writeToFile:tmpPathToFile atomically:YES])
    {
        //Write was successful.
        PPDebug(@"*******Save Image Successfully! %@",path);
      UIImage *image = [self readArticleListFromDiskWithFileName:@"currentPost.png"];
      [self setPostImage:image];
    }
}


-(void)clickSendStatusButton:(id)sender{
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{

    PostStatus *post = [[PostService sharedService] postStatus];
        
      User *user = [[UserService defaultService] user];
        

    PPDebug(@"*****用户:%@****",user.uid);
    PPDebug(@"*****内容:%@****",post.content);

        if (!self.postImage) {
            return ;
        }
        
    [[PostService sharedService] postStatusWithUid:user.uid
                                                 image:self.postImage
                                               content:post.content
                                              delegate:self.delegate];
    }];
    
}

- (void)clickBack:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    
       [self.navigationController.navigationItem.leftBarButtonItem setEnabled:YES
        
        
        ];
    }];
}

-(void)initUI{
    [self setNavigationRightButton:@"发送" imageName:@"top_bar_commonButton.png" action:@selector(clickSendStatusButton:)];
    [self setNavigationLeftButton:@"取消" imageName:@"top_bar_commonButton.png"  action:@selector(clickBack:)];
    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
    [self initUI];
}
#pragma mark --
#pragma mark  tableviewDelegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
            
        }
            break;
        case 2:
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
    static NSString *CellIdentifier = @"PostViewCell";
    PostViewCell *cell = (PostViewCell*)[self.dataTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell  = [[[PostViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [cell setNameTextField:nil];
    [cell.nameTextField setHidden:YES];

    
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row ==0) {
                [cell.nameTextField setText:@"请填写你要发送内容！！！"];
            }
            
        }
            break;
        case 1:
        {
            if (indexPath.row ==0) {
                [cell.textLabel setText:@"man"];
                [cell.imageView setImage:self.postImage];
                
            
            }
        }
            break;
        case 2:
        {
            if (indexPath.row ==0) {
                [cell.textLabel setText:@"分享到..."];
                UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"114X114.png"]];
                [cell.accessoryView addSubview:imageView];
                [imageView release];
            }

        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
        {
            return 80;
        }
            break;
            
        case 1:
        {
            return 60;
        }
            break;
        case 2:
        {
            return 60;
        }
            break;
            
        default:
            break;
    }
    return  60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
