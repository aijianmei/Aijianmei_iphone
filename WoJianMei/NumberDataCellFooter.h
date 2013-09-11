//
//  NumberDataCellFooter.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import <UIKit/UIKit.h>



@protocol NumberDataCellFooterDelegate <NSObject>

- (void)didClickFooterAddButton:(UIButton *)button atIndex:(int)buttonIndex;
- (void)didClickFooterDeleteButton:(UIButton *)button atIndex:(int)buttonIndex;

@end



@interface NumberDataCellFooter : UIView
{

    UIButton *_averageButton;
    UIButton *_numberButton;
    UIButton *_weightButton;
    UIButton *_timeButton;
    UIButton *_caloriesButton;
    
    UIButton *_addButton;
    UIButton *_deleteButton;


    
    
    
    
    id <NumberDataCellFooterDelegate> _delegate;


}


@property (retain, nonatomic) IBOutlet UIButton *averageButton;
@property (retain, nonatomic) IBOutlet UIButton *numberButton;
@property (retain, nonatomic) IBOutlet UIButton *weightButton;
@property (retain, nonatomic) IBOutlet UIButton *timeButton;
@property (retain, nonatomic) IBOutlet UIButton *caloriesButton;


@property (retain, nonatomic) IBOutlet UIButton *addButton;
@property (retain, nonatomic) IBOutlet UIButton *deleteButton;



@property (nonatomic, assign)    id <NumberDataCellFooterDelegate> delegate;


+ (NumberDataCellFooter *)createFooterWithAverage:(NSString *)average
                                           weight:(NSString *)weight
                                           number:(NSString *)number
                                             time:(NSString *)time
                                         calories:(NSString *)calories
                                         delegate:(id<NumberDataCellFooterDelegate>)delegate;


@end
