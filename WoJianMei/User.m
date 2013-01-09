//
//  User.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/8/13.
//
//

#import "User.h"

@implementation User
@synthesize name =_name;
@synthesize avatarImage=_avatarImage;
@synthesize description=_description;
@synthesize gender =_gender;




-(id)init{
    
    self = [super init];
    if (self) {
        //customrize
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.avatarImage = [aDecoder decodeObjectForKey:@"avatarImage"];
        self.name =[aDecoder decodeObjectForKey:@"name"];
        self.description = [aDecoder decodeObjectForKey:@"description"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.avatarImage forKey:@"avatarImage"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    
}


-(void)dealloc{
    [_name release];
    [_description release];
    [_avatarImage release];
    [_gender release];
    [super dealloc];
}

@end
