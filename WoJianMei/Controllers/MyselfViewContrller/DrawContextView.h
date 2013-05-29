//
//  DrawContextView.h
//  WoJianMei
//
//  Created by Kaibin on 13-5-25.
//
//

#import <UIKit/UIKit.h>

@interface DrawContextView : UIView
{
    //二维数组，第一维是天数，第二维是数据
    NSMutableArray *_amountList;
    NSMutableArray *_timeList;
    NSMutableArray *_intensityList;
}

@property (nonatomic, assign) int dayIndex;

- (void)addAmount:(UIButton*)button dayIndex:(int)dayIndex;
- (void)addTime:(UIButton*)button dayIndex:(int)dayIndex;
- (void)addIntensity:(UIButton*)button dayIndex:(int)dayIndex;


@end
