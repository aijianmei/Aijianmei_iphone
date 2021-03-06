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
#import <RestKit/RestKit.h>

@interface WorkOutProcessViewController : PPViewController<RKObjectLoaderDelegate>
{
    DrawContextView *_drawView;
}

@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic,retain) NSMutableArray *amountList;
@property (nonatomic,retain) NSMutableArray *intensityList;
@property (nonatomic,retain) NSMutableArray *timeList;


@property (nonatomic ,retain) NSString *moreNote;

//显示第几组数据
@property (nonatomic,assign) int dataIndex;

@end
