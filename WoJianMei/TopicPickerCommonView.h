//
//  TopicPickerCommonView.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/21/14.
//
//

#import <UIKit/UIKit.h>




@protocol TopicPickerCommonViewDelegate <NSObject>

@end


@protocol TopicPickerCommonViewProtocol <NSObject>
+ (id)createView:(id<TopicPickerCommonViewDelegate>)delegate;
+ (NSString *)getViewIdentifier;
- (void)updateView;
@end


@interface TopicPickerCommonView : UIView
{
    UIImageView *_statusImageView;
}
@property(nonatomic, assign)id delegate;
@property (nonatomic,retain) IBOutlet UIImageView *statusImageView;

@end








