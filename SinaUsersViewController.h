//
//  SinaUsersViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/12/13.
//
//

#import "PPTableViewController.h"
#import "SinaweiboManager.h"
#import "SinaUserCell.h"
#import "SinaWeiboAuthorizeView.h"




@class SinaUser;

@interface SinaUsersViewController : PPTableViewController<UITableViewDataSource,UITableViewDelegate,SinaWeiboRequestDelegate,SinaUserCellDelegate,SinaWeiboAuthorizeViewDelegate>{



    NSMutableDictionary *_userAvatarDic;
    
    SinaUser *_user;

    
    BOOL _shouldReloadTable;



}
@property (nonatomic,retain) NSMutableDictionary *userAvatarDic;
@property (nonatomic,retain) SinaUser *user;



@end
