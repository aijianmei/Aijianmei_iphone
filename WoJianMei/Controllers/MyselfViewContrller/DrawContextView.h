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
    NSMutableArray *_dataList1;
    NSMutableArray *_dataList2;
    NSMutableArray *_dataList3;

}

- (void)addToList1:(UIButton*)button;
- (void)addToList2:(UIButton*)button;
- (void)addToList3:(UIButton*)button;

@end
