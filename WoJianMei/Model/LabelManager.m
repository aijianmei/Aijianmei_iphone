//
//  LabelManager.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/10/13.
//
//

#import "LabelManager.h"
#import "Label.h"


LabelManager* labelManager;
LabelManager* GlobalGetLabelManager()
{
    if (labelManager == nil){
        labelManager = [[LabelManager alloc] init];
    }
    
    return labelManager;
}


@implementation LabelManager
@synthesize allLabel;

- (id)init
{
    self = [super init];
    allLabel = [[NSMutableArray alloc] init];
    return self;
}

+ (LabelManager*)defaultlabelManager
{
    return GlobalGetLabelManager();
}

- (Label*)getLabelById:(NSString *)labelId;
{
    for (Label* label in self.allLabel) {
        if ([label.labelId isEqualToString:labelId]) {
            return label;
        }
        NSLog(@"%@",label.labelName);
    }
    return nil;
}

- (void)addLabel:(Label*)label
{
    [self.allLabel addObject:label];
}

- (void)dealloc
{
    [allLabel release];
    [super dealloc];
}




@end
