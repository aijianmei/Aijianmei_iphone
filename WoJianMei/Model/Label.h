//
//  Label.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/10/13.
//
//

#import <Foundation/Foundation.h>

@interface Label : NSObject<NSCoding>
{

    NSString* labelId;
    NSString* labelName;
    
}
@property (nonatomic, retain) NSString* labelId;
@property (nonatomic, retain) NSString* labelName;

- (id) initWithId:(NSString*)idvalue
      labelName:(NSString*)name;

@end
