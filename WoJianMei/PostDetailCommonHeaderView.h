//
//  PostDetailCommonHeaderView.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/10/13.
//
//

#import <UIKit/UIKit.h>


//Delegate Method
@protocol PostDetailCommonHeaderViewDelegate <NSObject>
@end


//Protocol
@protocol PostDetailCommonHeaderViewProtocol <NSObject>
+ (id)createView:(id<PostDetailCommonHeaderViewDelegate>)delegate;
+ (NSString *)getViewIdentifier;
+ (CGFloat)getViewHeight;
- (void)updateView;
@end





@interface PostDetailCommonHeaderView : UIView
{
    
}
@property(nonatomic, assign)id delegate;



@end


