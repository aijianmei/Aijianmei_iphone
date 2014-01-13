//
//  PostService.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/6/13.
//
//

#import <Foundation/Foundation.h>
#import "PostStatus.h"
#import "PPViewController.h"
#import "CommonService.h"


@protocol PostStatusServiceDelegate <NSObject>
-(void)didLoadStatusesSucceeded:(int)errorCode didLoadObjects:(NSArray *)objects;
@optional



@end

@interface PostService : CommonService
{
    PostStatus *_postStatus;
    
}
@property (nonatomic,retain) PostStatus *postStatus;

+(PostService*)sharedService;

//分享图片内容
-(void)postStatusWithUid:(NSString *)uid
                   image:(UIImage *)image
                 content:(NSString*)content
          viewController:(PPViewController<PostStatusServiceDelegate>* )viewController;
//获取分享
-(void)loadStatusWithUid:(NSString*)uid
               targetUid:(NSString*)targetUid
                gymGroup:(NSString*)gymGroup
                   start:(NSString*)start
                  offSet:(NSString*)offSet
          viewController:(PPViewController<PostStatusServiceDelegate>* )viewController;
//点击喜欢
-(void)postLikeWithUid:(int)uid
              StatusId:(int)StatusId
        viewController:(PPViewController<PostStatusServiceDelegate>* )viewController;




















@end
