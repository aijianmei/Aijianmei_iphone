//
//  NumberDataCellHeader.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import <UIKit/UIKit.h>



@protocol NumberDataCellHeaderDelegate <NSObject>


- (void)didClickHeaderButton:(UIButton *)button atIndex:(int)buttonIndex;

@end



@interface NumberDataCellHeader : UIView

{
    UIButton *_nameButton;
    UIButton *_numberButton;
    UIButton *_weightButton;
    UIButton *_timeButton;
    UIButton *_caloriesButton;
    
    id <NumberDataCellHeaderDelegate> _delegate;
}



@property (retain, nonatomic) IBOutlet UIButton *nameButton;
@property (retain, nonatomic) IBOutlet UIButton *numberButton;
@property (retain, nonatomic) IBOutlet UIButton *weightButton;
@property (retain, nonatomic) IBOutlet UIButton *timeButton;
@property (retain, nonatomic) IBOutlet UIButton *caloriesButton;
@property (nonatomic, assign)    id <NumberDataCellHeaderDelegate> delegate;






+ (NumberDataCellHeader *)createHeaderWithName:(NSString *)name
                                        weight:(NSString *)weight
                                        number:(NSString *)number
                                          time:(NSString *)time
                                      calories:(NSString *)calories
                                      delegate:(id<NumberDataCellHeaderDelegate>)delegate;



@end
