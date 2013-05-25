//
//  WorkOutProcessViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 5/25/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "DrawContextView.h"

@interface WorkOutProcessViewController : PPViewController
{
    DrawContextView *drawView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@end
