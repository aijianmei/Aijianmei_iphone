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
    DrawContextView *_drawView;
}

@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic,retain) NSMutableArray *amountList;
@property (nonatomic,retain) NSMutableArray *intensityList;
@property (nonatomic,retain) NSMutableArray *timeList;

//显示第几组数据
@property (nonatomic,assign) int dataIndex;

@end
