//
//  Label.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/10/13.
//
//

#import "Label.h"

#define LabelId  @"LabelId"
#define LabelName @"LabelName"


@implementation Label

@synthesize labelId;
@synthesize labelName;

- (void)dealloc
{
    [labelName release];
    [labelId release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.labelId = [[NSString alloc] init];
        self.labelName = [[NSString alloc] init];
    }
    return self;
}

- (id) initWithId:(NSString*)idvalue
      labelName:(NSString*)name
         
{
    self = [super init];
    if (self) {
        self.labelId = idvalue;
        self.labelName = name;
    }
    return self;
}
- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:labelId forKey:LabelId];
    [coder encodeObject:labelName forKey:LabelName];
   
    
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        self.labelId = [coder decodeObjectForKey:LabelId];
        self.labelName = [coder decodeObjectForKey:LabelName];
    }
    return self;
    
}



@end
