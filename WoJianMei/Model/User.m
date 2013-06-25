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
@synthesize uid = _uid;
@synthesize sinaUserId = _sinaUserId;
@synthesize qqUserId = _qqUserId;
@synthesize userType = _userType;
@synthesize email = _email;

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
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.userType = [aDecoder decodeObjectForKey:@"userType"];
        self.sinaUserId = [aDecoder decodeObjectForKey:@"sinaUserId"];
        self.qqUserId = [aDecoder decodeObjectForKey:@"qqUserId"];
        self.profileImageUrl = [aDecoder decodeObjectForKey:@"profileImageUrl"];
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
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.userType forKey:@"userType"];
    [aCoder encodeObject:self.sinaUserId forKey:@"sinaUserId"];
    [aCoder encodeObject:self.qqUserId forKey:@"qqUserId"];
    [aCoder encodeObject:self.profileImageUrl forKey:@"profileImageUrl"];
}


-(void)dealloc{
    
    [_name release];
    [_motto release];
    [_description release];
    [_avatarImage release];
    [_avatarBackGroundImage release];
    [_gender release];
    [_email release];
    [_password release];
    [_sinaUserId release];
    [_qqUserId release];
    [_uid release];
    [super dealloc];
}

- (BOOL)isLogin
{
    return [self.loginStatus boolValue];
}

@end
