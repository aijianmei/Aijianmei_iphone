//
//  LabelManager.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/10/13.
//
//

#import <Foundation/Foundation.h>

@class Label;

@interface LabelManager : NSObject
{
    NSMutableArray* allLabel;

}
@property (nonatomic, retain) NSMutableArray* allLabel;

+ (LabelManager*)defaultlabelManager;
- (Label*)getLabelById:(NSString *)labelId;
- (void)addLabel:(Label*)label;


@end
