//
//  PostDetailHeaderView.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/10/13.
//
//

#import "PostDetailHeaderView.h"
#import "PPDebug.h"
#import "DeviceDetection.h"




@implementation PostDetailHeaderView

+ (id)createView:(id<PostDetailCommonHeaderViewDelegate>)delegate
{
    NSString* identifier = [PostDetailHeaderView getViewIdentifier];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create %@ but cannot find view object from Nib", identifier);
        return nil;
    }
    PostDetailHeaderView<PostDetailCommonHeaderViewProtocol> *view = [topLevelObjects objectAtIndex:0];
    view.delegate = delegate;
    [view updateView];
    return view;
}

+ (NSString *)getViewIdentifier
{
    if ([DeviceDetection isIPhone5]) {
        //        return @"HomeMainMenuPanel_ip5";
    }
    return @"PostDetailHeaderView";
}

+ (CGFloat)getViewHeight
{
    return  578.0f;
}



- (void)updateView{
    
    PPDebug(@"Try to update the view ");
    [self setFrame:CGRectMake(0, 0, 320, 578)];
}




@end
