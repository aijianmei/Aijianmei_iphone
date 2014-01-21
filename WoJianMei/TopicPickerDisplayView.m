//
//  TopicPickerDisplayView.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/21/14.
//
//

#import "TopicPickerDisplayView.h"
#import "DeviceDetection.h"
#import "PPDebug.h"
#import "ImageManager.h"




@implementation TopicPickerDisplayView

+ (id)createView:(id<TopicPickerCommonViewProtocol>)delegate
{
    NSString* identifier = [TopicPickerDisplayView getViewIdentifier];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create %@ but cannot find view object from Nib", identifier);
        return nil;
    }
    TopicPickerDisplayView<TopicPickerCommonViewProtocol> *view = [topLevelObjects objectAtIndex:0];
    view.delegate = delegate;
    [view updateView];
    return view;
}

+ (NSString *)getViewIdentifier
{
    if ([DeviceDetection isIPhone5]) {
        return @"TopicPickerDisplayView";
    }
    return @"TopicPickerDisplayView";
}



- (void)updateView{
    
    [self.statusImageView setImage:[ImageManager sliderPlacHolderImage]];
}

@end
