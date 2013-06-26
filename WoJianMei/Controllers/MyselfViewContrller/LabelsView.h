//
//  LabelsView.h
//  WoJianMei
//
//  Created by Tom Callon  on 6/26/13.
//
//

#import <UIKit/UIKit.h>

@interface LabelsView : UIView

{
    UIScrollView *_buttonScrollView;
    NSArray *_dataList;

}

@property (nonatomic,retain) UIScrollView *buttonScrollView;
@property (nonatomic,retain) NSArray *dataList;

-(void)setNeedsDisplay;
-(id)loadDataList;

@end
