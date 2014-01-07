//
//  StoreViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/6/14.
//
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"
#import "EGOViewCommon.h"

@interface StoreViewController : UIViewController<EGORefreshTableDelegate>

{
    //EGOHeader
    EGORefreshTableHeaderView *_refreshHeaderView;
    //EGOFoot
    EGORefreshTableFooterView *_refreshFooterView;
    //
    BOOL _reloading;


}

@end
