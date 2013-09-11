//
//  CheckWorkoutDatasViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/13/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"

@protocol ChartViewDelegate <NSObject>

-(void)upDateInfo:(UIButton *)sender;

@end



@interface ChartViewController : PPViewController<UIWebViewDelegate>

{
    UIWebView *_sevenWebView;
    UIWebView *_thirtyWebView;
    UIWebView *_yearWebView;

    

}

@property (nonatomic ,retain) IBOutlet UIWebView *sevenWebView;
@property (nonatomic ,retain) IBOutlet UIWebView *thirtyWebView;
@property (nonatomic ,retain) IBOutlet UIWebView *yearWebView;


@property (nonatomic ,retain) IBOutlet UIButton *actionButton;


@property (nonatomic,retain) IBOutlet UIButton *sevenDayButton;
@property (nonatomic,retain) IBOutlet UIButton *thirtyDayButton;
@property (nonatomic,retain) IBOutlet UIButton *yearButton;

@property (nonatomic,assign) id <ChartViewDelegate> delegate;



@end
