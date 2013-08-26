//
//  NumberDataCellFooter.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import <UIKit/UIKit.h>



@protocol NumberDataCellFooterDelegate <NSObject>

@end



@interface NumberDataCellFooter : UIView
{

    UIButton *_averageButton;
    UIButton *_numberButton;
    UIButton *_weightButton;
    UIButton *_timeButton;
    UIButton *_caloriesButton;

}


@property (retain, nonatomic) IBOutlet UIButton *averageButton;
@property (retain, nonatomic) IBOutlet UIButton *numberButton;
@property (retain, nonatomic) IBOutlet UIButton *weightButton;
@property (retain, nonatomic) IBOutlet UIButton *timeButton;
@property (retain, nonatomic) IBOutlet UIButton *caloriesButton;



+ (NumberDataCellFooter *)createFooterWithAverage:(NSString *)average
                                           weight:(NSString *)weight
                                           number:(NSString *)number
                                             time:(NSString *)time
                                         calories:(NSString *)calories
                                         delegate:(id<NumberDataCellFooterDelegate>)delegate;


@end
