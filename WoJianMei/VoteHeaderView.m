//
//  VoteHeaderView.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/10/13.
//
//

#import "VoteHeaderView.h"
#import "DeviceDetection.h"
#import "PPDebug.h"



@implementation VoteHeaderView

+ (id)createView:(id<VoteHeaderCommonViewDelegate>)delegate
{
    NSString* identifier = [VoteHeaderView getViewIdentifier];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create %@ but cannot find view object from Nib", identifier);
        return nil;
    }
    VoteHeaderView<VoteHeaderCommonViewProtocol> *view = [topLevelObjects objectAtIndex:0];
    view.delegate = delegate;
    [view updateView];
    return view;
}

+ (NSString *)getViewIdentifier
{
    if ([DeviceDetection isIPhone5]) {
        //        return @"HomeMainMenuPanel_ip5";
    }
    return @"VoteHeaderView";
}



- (void)updateView{
   
    PPDebug(@"Try to update the view ");
}


@end
