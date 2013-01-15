//
//  SinaUsersViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/12/13.
//
//

#import "SinaUsersViewController.h"
#import "SinaUserCell.h"


#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "SinaweiboManager.h"
#import "SinaUser.h"
#import "HHNetDataCacheManager.h"



@interface SinaUsersViewController ()
{
    NSDictionary *_sina_userInfo;

}
@property(nonatomic ,retain)  NSDictionary *sina_userInfo;



- (SinaweiboManager *)sinaweiboManager;

@end

@implementation SinaUsersViewController
@synthesize sina_userInfo   =_sina_userInfo;
@synthesize  userAvatarDic =_userAvatarDic;
@synthesize sinaUserArr =_sinaUserArr;


-(void)dealloc{
    
    [_userAvatarDic release]; _userAvatarDic = nil;
    [_sina_userInfo release];_sina_userInfo = nil;
    [_sinaUserArr release]; _sinaUserArr = nil;
    [super dealloc];
    
}


-(NSMutableDictionary*)userAvatarDic
{
    if (_userAvatarDic == nil)
    {
        _userAvatarDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _userAvatarDic;
}

-(void)viewDidUnload{
    
    
    NSNotificationCenter *notifCenter = [NSNotificationCenter defaultCenter];
    [notifCenter removeObserver:self name:HHNetDataCacheNotification object:nil];
    [super viewDidUnload];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    

    [self setBackgroundImageName:@"BackGround.png"];
    [self showBackgroundImage];
    [self.navigationItem setTitle:@" 新浪好友"];
    
    ///用户头像加载方式的优化
    _shouldReloadTable = YES;

    
    _userAvatarDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSNotificationCenter *notifCenter = [NSNotificationCenter defaultCenter];
    [notifCenter addObserver:self selector:@selector(gotAvatar:) name:HHNetDataCacheNotification object:nil];

    
    
    
    [self sinaweiboManager];
    
    SinaWeibo *sinaweibo = [[self sinaweiboManager] sinaweibo];
    BOOL authValid = sinaweibo.isAuthValid;
    if (authValid) {
        
        //        friendships/friends.json

       //https://api.weibo.com/2/friendships/friends/bilateral.json
        [sinaweibo requestWithURL:@"friendships/friends/bilateral.json"
                           params:nil
                       httpMethod:@"GET"
                         delegate:self];
            
        }else {
            
            
            [sinaweibo logInInView:self.view];
            
        }
}



- (SinaweiboManager *)sinaweiboManager
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate.sinaWeiboManager;
}



- (void)sendSinaWeibo:(NSString *)text
{
    
    NSString *invitedString =[NSString stringWithFormat:@"@%@ 我正在使用爱健美客户端,里边内容很精彩，你也下载一个啦！下载连接可以在 www.aijianmei.com 找到。",text];
    
    if ([[[self sinaweiboManager] sinaweibo] isAuthValid]) {
        //发送微博
       
        
        [[self sinaweiboManager].sinaweibo requestWithURL:@"statuses/update.json"
                                             params:[NSMutableDictionary dictionaryWithObjectsAndKeys:invitedString, @"status", nil]
                                         httpMethod:@"POST"
                                           delegate:self];

        [self showActivity];
    } else {
        [[[self sinaweiboManager] sinaweibo] logInInView:self.view];
    }
}

-(void)gotAvatar:(NSNotification*)sender
{
    
//    if (_shouldReloadTable == NO) {
//        return;
//    }
    
    NSDictionary * dic = sender.object;
    NSString * url          = [dic objectForKey:HHNetDataCacheURLKey];
    NSNumber *indexNumber   = [dic objectForKey:HHNetDataCacheIndex];
    NSInteger index         = [indexNumber intValue];
    NSData *data            = [dic objectForKey:HHNetDataCacheData];
    
    if (indexNumber == nil || index == -1) {
        NSLog(@"indexNumber = nil");
        return;
    }
    
    if (index >= [_sinaUserArr count]) {
        //        NSLog(@"follow cell error ,index = %d,count = %d",index,[_userArr count]);
        return;
    }
    
    SinaUser *user = [_sinaUserArr objectAtIndex:index];
    
    //得到的是头像图片
    if ([url isEqualToString:user.profileImageUrl])
    {
        UIImage * image     = [UIImage imageWithData:data];
        user.avatarImage    = image;
        if (image != nil) {
            [_userAvatarDic setObject:image forKey:indexNumber];
        }
        else {
            [_userAvatarDic setObject:[NSNull null] forKey:indexNumber];
        }
    }
    
    //reload table
//     NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:index inSection:0];
//     NSArray     *arr        = [NSArray arrayWithObject:indexPath];
//     [self.dataTableView reloadRowsAtIndexPaths:arr withRowAnimation:NO];
    
    [self.dataTableView reloadData];
    
}

-(void)getAvatars
{
    for(int i=0;i<[_sinaUserArr count];i++)
    {
        SinaUser *user=[_sinaUserArr objectAtIndex:i];
        
        //下载头像图片
        [[HHNetDataCacheManager getInstance] getDataWithURL:user.profileImageUrl withIndex:i];
    }
}







/////微博请求的delegate 返回数据

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    ///获取用户好友和粉丝。
    if ([request.url hasSuffix:@"friendships/friends/bilateral.json"])
    {
       [_sina_userInfo release], _sina_userInfo = nil;
    }
    ///邀请好友下载app
    if ([request.url hasSuffix:@"statuses/update.json"]){
        
        PPDebug(@"邀请朋友下载app失败！%@",error);

    }
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    
    ///首先确定返回数据的类型，然后再解析数据。
    if ([request.url hasSuffix:@"friendships/friends/bilateral.json"])
    {
        [_sina_userInfo release];
        _sina_userInfo = [result retain];
        PPDebug(@"%@",[_sina_userInfo description]);
        PPDebug(@"%d",[_sina_userInfo count]);
        
        
        //获取用户粉丝列表
       NSArray *arr =[_sina_userInfo objectForKey:@"users"];
      NSMutableArray *userArr = [[NSMutableArray alloc]initWithCapacity:0];
        for (id item in arr) {
            SinaUser *user = [[SinaUser alloc]initWithJsonDictionary:item];
            [userArr addObject:user];
            [user release];
            
            
            
        ///获取数据之后再重新load 数据。
             self.dataList = userArr;
            _sinaUserArr = userArr;
            
            SinaUser *tempUser = [userArr lastObject];
            SinaUser *lastUser = [self.dataList lastObject];
            if (![tempUser.screenName isEqualToString:lastUser.screenName]) {
                self.dataList = userArr;
                [self.dataTableView reloadData];

            }
            else {
                _shouldReloadTable = NO;
            }
            
    
            ///开始加载用户头像的数据了。
            [self getAvatars];
        }
    }
    if ([request.url hasSuffix:@"statuses/update.json"]){
    
        PPDebug(@"邀请朋友下载app成功！");
        
        [self hideActivity];
    }
    
}



#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{

    
    return [SinaUserCell getCellHeight];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
        
    return @"邀请新浪好友";
}

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
    
    
    
    SinaUserCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:[SinaUserCell getCellIdentifier]];
    
    if (cell == nil) {
        cell = [[[SinaUserCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:[SinaUserCell getCellIdentifier]] autorelease];
    }

    // Configure the cell...
    [cell setDelegate:self];
    
    
    SinaUser *sinaUser  = [self.dataList objectAtIndex:indexPath.row];
    
    NSNumber *indexNum = [NSNumber numberWithInt:indexPath.row];
    if ([_userAvatarDic objectForKey:indexNum] != [NSNull null]) {
        sinaUser.avatarImage =[_userAvatarDic objectForKey:indexNum];
    
    }

 
    [cell setCellInfo:sinaUser indexPath:indexPath];


    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
}



#pragma mark - SinaUserCellDelegate
- (void)didClickInviteButton:(id)sender atIndex:(NSIndexPath*)indexPath{

    SinaUser *sinaUser  = [self.dataList objectAtIndex:indexPath.row];
    [self sendSinaWeibo:sinaUser.screenName];

    
}



#pragma mark -  SinaWeiboAuthorizeViewDelegate 

- (void)authorizeView:(SinaWeiboAuthorizeView *)authView
didRecieveAuthorizationCode:(NSString *)code{
    
    
    PPDebug(@"SinaWeiboAuthorizeView %@",code );
//////当用户重新授权成功的时候。
    SinaWeibo *sinaweibo = [[self sinaweiboManager] sinaweibo];
    BOOL authValid = sinaweibo.isAuthValid;
    if (authValid) {
        
        //        friendships/friends.json
        //https://api.weibo.com/2/friendships/friends/bilateral.json
        [sinaweibo requestWithURL:@"friendships/friends/bilateral.json"
                           params:nil
                       httpMethod:@"GET"
                         delegate:self];
        
    }else {
        
        [sinaweibo logInInView:self.view];
    }

}
- (void)authorizeView:(SinaWeiboAuthorizeView *)authView
 didFailWithErrorInfo:(NSDictionary *)errorInfo{
    
    PPDebug(@"SinaWeiboAuthorizeView %@",[errorInfo description]);

}
- (void)authorizeViewDidCancel:(SinaWeiboAuthorizeView *)authView{
    
    
    PPDebug(@"User authorizeViewDidCancel ");

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
