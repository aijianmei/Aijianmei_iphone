//
//  BBSPostDetailController.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/9/13.
//
//

#import "PPTableViewController.h"
#import "PostDetailCommonHeaderView.h"
#import "PostService.h"



@class PBBBSPost;


@interface BBSPostDetailController : PPTableViewController<PostDetailCommonHeaderViewDelegate,PostStatusServiceDelegate>{
    BOOL _reloading;
    BOOL  shouldLoad;
    NSInteger _start;
}
@end
