//
//  BBSHomeViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "PPTableViewController.h"
#import "HomeMainMenuPanel.h"


@class PBBBSPost;

@interface BBSHomeViewController : PPTableViewController<HomeCommonViewDelegate,HomeMainMenuPanelDelegate,HomeMenuViewDelegate>
{

}



@property(nonatomic, retain)HomeMainMenuPanel *homeMainMenuPanel;
@property (nonatomic, retain) UIView *myHeaderView;


@end
