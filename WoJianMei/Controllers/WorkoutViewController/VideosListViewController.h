//
//  ProductListViewController.h
//  WoJianMei
//
//  Created by Tom Callon on 7/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleCell.h"
#import "PPTableViewController.h"

@class ShowBigImageViewController;


@class WeiBoMessageManager;

@interface VideosListViewController : PPTableViewController<VideoListCellDelegate,UIAlertViewDelegate>
{
    
    int matchSelectStatus;   

    
    NSMutableArray *_mainArray;
    
    
    UIButton *_selectedButton;
    UIButton *_myFollowButton;

    

//    UIBadgeView *_myFollowCountView;

    
    ShowBigImageViewController *_showBigImageViewController;
    
    
}
@property (nonatomic ,retain) NSMutableArray *mainArray;
@property (nonatomic ,retain) IBOutlet UIButton *selectedButton;
@property (nonatomic ,retain) IBOutlet UIButton *myFollowButton;
//@property (nonatomic ,retain) UIBadgeView *myFollowCountView;
@property (nonatomic ,retain) ShowBigImageViewController *showBigImageViewController;

////////weibo
@property (nonatomic, copy)     NSString *userID;


- (IBAction)clickButtons:(id)sender;

- (void)clickUpperBodyButton:(id)sender;
- (void)clickMiddleBodyButton:(id)sender;
- (void)clickLowerBodyButton:(id)sender;
- (void)clickAllVideosButton:(id)sender;
- (void)clickMyPlanButton:(id)sender;

- (void)didDetectDoubleTap:(UITapGestureRecognizer *)tap;


@end
