//
//  ImageManager.h
//  MBook
//
//  Created by  on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageManager : NSObject
{
    
}


+ (id)defaultManager;

+ (UIImage *)bookBgImage;
+ (UIImage *)bookselfButtonPress;
+ (UIImage *)bookselfButton;
+ (UIImage *)catalogButton;
+ (UIImage *)catalogButtonPress;
+ (UIImage *)musicButton;
+ (UIImage *)videoButton;





+(UIImage*)weiboImage;
+(UIImage*)qqImage;
+(UIImage*)renrenImage;
+(UIImage*)kaixinImage;
+(UIImage*)tengxunWeiboImage;
+(UIImage*)doubanImage;
+(UIImage*)loginEmailImage;




+(UIImage*)avatarbackgroundImage;

- (UIImage *)allBackgroundImage;
- (UIImage *)navigationBgImage;



+(UIImage*)leftSideNaviHighLightImage;
+(UIImage*)GobalBGImage;

///顶部导航栏目，头像图片；
+(UIImage*)GobalNavigationAvatarImage;





@end
