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

+(UIImage*)avatarbackgroundImage;

- (UIImage *)allBackgroundImage;
+ (UIImage *)navigationBgImage;


+(UIImage*)leftSideNaviHighLightImage;
+(UIImage*)GobalBGImage;

///顶部导航栏目，头像图片；
+(UIImage*)GobalNavigationAvatarImage;

///滑片label 的背景图片；
+(UIImage*)GobalScrollerTitleBG_Image;


///顶部导航栏目,左侧列表背景图片；
+(UIImage*)GobalNavigationButtonBG;

///顶部导航栏目,左侧列表图片；
+(UIImage*)GobalNavigationLeftSideButtonImage;

////用户头像背景图片
+(UIImage*)getProfile_backgroud;


///顶部导航栏目,普通背景图片；
+(UIImage*)GobalNavigationCommonButtonBG;


///顶部导航栏目,返回按钮图片;
+(UIImage*)GobalNavigationBackButtonBG;


///文章单页喜欢按钮
+(UIImage*)GobalArticelLikeButtonBG;
///文章单页分享按钮背景
+(UIImage*)GobalArticelShareButtonBG;
///文章单页评论按钮背景
+(UIImage*)GobalArticelCommentButtonBG;

+(UIImage *)articleBarImage;

+(UIImage *)avatarPlacHolderImage;



//Slider placeHolderImage
+(UIImage *)sliderPlacHolderImage;





@end
