//
//  VoteHeaderCommonView.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/10/13.
//
//

#import <UIKit/UIKit.h>




@protocol VoteHeaderCommonViewDelegate <NSObject>

@end

@protocol VoteHeaderCommonViewProtocol <NSObject>
+ (id)createView:(id<VoteHeaderCommonViewDelegate>)delegate;
+ (NSString *)getViewIdentifier;
- (void)updateView;
@end


@interface VoteHeaderCommonView : UIView
{
    
}
@property(nonatomic, assign)id delegate;

@end
