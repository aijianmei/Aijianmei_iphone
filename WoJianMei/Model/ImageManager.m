//
//  ImageManager.m
//  MBook
//
//  Created by  on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageManager.h"
#import "DeviceDetection.h"


static ImageManager *_defaultManager = nil;

@implementation ImageManager

+ (id)defaultManager
{
    if (_defaultManager == nil){
        _defaultManager = [[ImageManager alloc] init];
    }
    
    return _defaultManager;
}


+ (UIImage *)stretchaleImageName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    CGSize size = image.size;
    return [image stretchableImageWithLeftCapWidth:size.width/2 topCapHeight:size.height/2];
}
///////////关联页面

+(UIImage*)weiboImage{
    return [UIImage imageNamed:@"LOGO_16x16.png"];
}
+(UIImage*)qqImage{
    return [UIImage imageNamed:@"qq.png"];
}
+(UIImage*)tengxunWeiboImage{
    return [UIImage imageNamed:@"weiboicon24.png"];
}
+(UIImage*)renrenImage{
    return [UIImage imageNamed:@"renren.png"];
}
+(UIImage*)kaixinImage{
    return [UIImage imageNamed:@"48x48.png"];
}

+(UIImage*)doubanImage{
    return [UIImage imageNamed:@"douban.png"];
}
+(UIImage*)loginEmailImage{
    return [UIImage imageNamed:@"email.png"];
}

///////AVATAR
+(UIImage*)avatarbackgroundImage{
    return [UIImage imageNamed:@"touxiang_40x40@.png"];
}


- (UIImage *)allBackgroundImage
{
    if ([DeviceDetection isIPhone5]) {
        return [UIImage imageNamed:@"BackGround.png"];
    } else {
        return [UIImage imageNamed:@"BackGround.png"];
    }
    
    return nil;
}


+ (UIImage *)navigationBgImage
{
    return [UIImage imageNamed:@"topmenu_bg.png"];
}

///////AVATAR
+(UIImage*)leftSideNaviHighLightImage{
    return [UIImage imageNamed:@"leftSide_Click.png"];
}


///////AVATAR
+(UIImage*)GobalBGImage{
    return [UIImage imageNamed:@"gobal_background.png"];
}


///顶部导航栏目，头像图片；
+(UIImage*)GobalNavigationAvatarImage{
    return [UIImage imageNamed:@"Navigation_avartar_Image.png"];
}

///滑片label 的背景图片；
+(UIImage*)GobalScrollerTitleBG_Image{
    
    return [UIImage imageNamed:@"Scroller_BG.png"];
}

///顶部导航栏目,左侧列表背景图片；
+(UIImage*)GobalNavigationButtonBG{
    
    return [UIImage imageNamed:@"NavigationButtonBG.png"];
}

///顶部导航栏目,左侧列表图片；
+(UIImage*)GobalNavigationLeftSideButtonImage{
    
    return [UIImage imageNamed:@"LeftSideViewIcon.png"];
}


////用户头像背景图片
+(UIImage*)getProfile_backgroud{

    return
    [UIImage imageNamed:@"profile_backgroud.png"];

}

///顶部导航栏目,普通背景图片；
+(UIImage*)GobalNavigationCommonButtonBG{
    
    return [UIImage imageNamed:@"top_bar_commonButton.png"];

    
}

///顶部导航栏目,普通背景图片；
+(UIImage*)GobalNavigationBackButtonBG{
    
    return [UIImage imageNamed:@"top_bar_backButton.png"];
    
    
}


///文章单页喜欢按钮背景
+(UIImage*)GobalArticelLikeButtonBG{
    
    return [UIImage imageNamed:@"like_icon.png"];
    
}
///文章单页分享按钮背景
+(UIImage*)GobalArticelShareButtonBG{
    
    return [UIImage imageNamed:@"Share_article.png"];
    
}
///文章单页评论按钮背景
+(UIImage*)GobalArticelCommentButtonBG{
    
    return [UIImage imageNamed:@"comment_icon.png"];
    
}

+(UIImage *)articleBarImage{

    return [UIImage imageNamed:@"topmenu_bg.png"];

}




+(UIImage *)avatarPlacHolderImage{

    return [UIImage imageNamed:@"touxiang_40x40@2x.png"];

}


+(UIImage *)sliderPlacHolderImage{

     return [UIImage
        imageNamed:@"place_holder@2x.png"];
}












@end
