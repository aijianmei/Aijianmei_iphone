//
//  BBSHomeViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "PPTableViewController.h"
#import "HomeMainMenuPanel.h"
#import "PostService.h"



@class PBBBSPost;

@interface BBSHomeViewController : PPTableViewController<HomeCommonViewDelegate,HomeMainMenuPanelDelegate,HomeMenuViewDelegate,PostStatusServiceDelegate>
{
    
    BOOL _reloading;
    BOOL  shouldLoad;
    NSInteger _start;

}



@property(nonatomic, retain)HomeMainMenuPanel *homeMainMenuPanel;
@property (nonatomic, retain) UIView *myHeaderView;


@end
