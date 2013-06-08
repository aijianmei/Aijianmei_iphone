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
@synthesize motto =_motto;
@synthesize avatarImage=_avatarImage;
@synthesize avatarBackGroundImage =_avatarBackGroundImage;
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
        self.avatarBackGroundImage = [aDecoder decodeObjectForKey:@"avatarBackGroundImage"];
        self.name =[aDecoder decodeObjectForKey:@"name"];
        self.motto =[aDecoder decodeObjectForKey:@"motto"];
        self.description = [aDecoder decodeObjectForKey:@"description"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.motto forKey:@"motto"];

    
    [aCoder encodeObject:self.description forKey:@"description"];
    [aCoder encodeObject:self.avatarImage forKey:@"avatarImage"];
    [aCoder encodeObject:self.avatarBackGroundImage forKey:@"avatarBackGroundImage"];

    [aCoder encodeObject:self.gender forKey:@"gender"];
    
}


-(void)dealloc{
    
    [_name release];
    [_motto release];
    [_description release];
    [_avatarImage release];
    [_avatarBackGroundImage release];
    [_gender release];
    [super dealloc];
}

@end
