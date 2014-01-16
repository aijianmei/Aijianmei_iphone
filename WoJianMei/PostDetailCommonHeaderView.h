//
//  PostDetailCommonHeaderView.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/10/13.
//
//

#import <UIKit/UIKit.h>


@class PostStatus;


//Delegate Method
@protocol PostDetailCommonHeaderViewDelegate <NSObject>
@end


//Protocol
@protocol PostDetailCommonHeaderViewProtocol <NSObject>
+ (id)createView:(id<PostDetailCommonHeaderViewDelegate>)delegate;
+ (NSString *)getViewIdentifier;
+ (CGFloat)getViewHeight;
- (void)updateView:(PostStatus *)post;
@end





@interface PostDetailCommonHeaderView : UIView
{
    
    UILabel     *_titleLabel;
    UITextView *_contentView;
    UIImageView *_imageView;
    UILabel *_nameLable;
    UILabel *_genderLabel;
    UILabel *_fitnessLabel;
    UILabel *_postTimeLabel;
    UILabel *_visitLabel;
    UILabel *_joinLabel;
}

@property(nonatomic, retain) IBOutlet UILabel *titleLabel;
@property(nonatomic, retain) IBOutlet UITextView *contentView;
@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic, retain) IBOutlet UILabel *nameLable;
@property(nonatomic, retain) IBOutlet UILabel *genderLabel;
@property(nonatomic, retain) IBOutlet UILabel *fitnessLabel;
@property(nonatomic, retain) IBOutlet UILabel *postTimeLabel;
@property(nonatomic, retain) IBOutlet UILabel *visitLabel;
@property(nonatomic, retain) IBOutlet UILabel *joinLabel;



@property(nonatomic, assign)id delegate;



@end


