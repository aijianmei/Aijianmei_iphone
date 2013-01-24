//
//  ComposeViewCellInfo.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/21/13.
//
//

#import <Foundation/Foundation.h>

@interface ComposeViewCellInfo : NSObject
{

    NSString        *_avatarImageName;
    NSString                   *_name;
    NSString      *_connectButtonName;
}

@property (nonatomic,retain)  NSString    *avatarImageName;
@property (nonatomic,retain)  NSString               *name;
@property (nonatomic,retain)  NSString       *connectButtonName;


@end
