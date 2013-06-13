//
//  AJM_CommonViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 6/13/13.
//
//

#import "PPViewController.h"


@class AppDelegate;

@interface AJM_CommonViewController : PPViewController
{
    AppDelegate *_appDelegate;

}

- (void)initMoreUI;
- (void)leftButtonClickHandler:(id)sender;
- (void)rightButtonClickHandler:(id)sender;


@end
