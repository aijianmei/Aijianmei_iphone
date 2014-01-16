//
//  PostDetailHeaderView.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/10/13.
//
//

#import <UIKit/UIKit.h>
#import "PostDetailCommonHeaderView.h"


@class PostStatus;
@interface PostDetailHeaderView : PostDetailCommonHeaderView<PostDetailCommonHeaderViewProtocol>


- (void)updateView:(PostStatus*)post;

@end
