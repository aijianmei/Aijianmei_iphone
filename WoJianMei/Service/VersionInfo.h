//
//  Version.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/15/13.
//
//

#import <Foundation/Foundation.h>

@interface VersionInfo : NSObject
{
}
@property (nonatomic, retain) NSString *version;
@property (nonatomic, retain) NSString *downloadurl;
@property (nonatomic, retain) NSString *updateTitle;
@property (nonatomic, retain) NSString *updateContent;

@end
