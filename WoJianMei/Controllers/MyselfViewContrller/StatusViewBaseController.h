//
//  StatusViewBaseController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/7/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "StatusCell.h"
#import <RestKit/RestKit.h>
#import "ImageBrowser.h"



@interface StatusViewBaseController : PPTableViewController<StatusCellDelegate,RKObjectLoaderDelegate,ImageBrowserDelegate>{
    
    UINib               *statusCellNib;
    NSMutableDictionary *_avatarDictionary;
    NSMutableDictionary *_imageDictionary;
    NSNotificationCenter *defaultNotifCenter;
    ImageBrowser        *_browserView;

    BOOL                shouldShowIndicator;
    BOOL                shouldLoad;
    BOOL _reloading;
    
    
    NSIndexPath * likeIndexPath;



}
@property (nonatomic, retain)   UINib                   *statusCellNib;
@property (nonatomic, retain)   NSMutableDictionary     *avatarDictionary;
@property (nonatomic, retain)   NSMutableDictionary     *imageDictionary;

@property (assign, nonatomic) NSInteger start;
@property (nonatomic, retain)   ImageBrowser            *browserView;
- (void)reloadTableViewDataSource;
-(void)getImages;


@end