//
//  User.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/8/13.
//
//

#import "User.h"


#define Name           @"name"
#define AvatarImage    @"avatarImage"
#define AvatarBackGroundImage @"avatarBackGroundImage"
#define Description    @"description"
#define Gender         @"gender"
#define Uid            @"uid"
#define SinaUserId     @"sinaUserId"
#define QQUserId       @"qqUserId"
#define UserType       @"userType"
#define ProfileImageUrl @"profileImageUrl"
//#define LoginStatus    @"loginStatus"
#define Email          @"email"
#define PassWord       @"password"
#define LabelsArray    @"labelsArray"
#define Age            @"age"
#define Height         @"height"
#define Weight         @"weight"
#define BmiValue       @"BMIValue"
#define City           @"city"
#define Province       @"Province"





@implementation User
@synthesize name =_name;
@synthesize avatarBackGroundImage =_avatarBackGroundImage;
@synthesize description=_description;

@synthesize gender =_gender;
@synthesize uid = _uid;
@synthesize sinaUserId = _sinaUserId;
@synthesize qqUserId = _qqUserId;
@synthesize userType = _userType;

@synthesize profileImageUrl =_profileImageUrl;
//@synthesize loginStatus =_loginStatus;
@synthesize email = _email;
@synthesize password =_password;
@synthesize labelsArray =_labelsArray;

@synthesize age=_age;
@synthesize height =_height;
@synthesize weight =_weight;
@synthesize BMIValue =_BMIValue;
@synthesize city =_city;
@synthesize province =_province;



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
        self.avatarBackGroundImage = [aDecoder decodeObjectForKey:AvatarBackGroundImage];
        self.name =[aDecoder decodeObjectForKey:Name];
        self.description = [aDecoder decodeObjectForKey:Description];
        self.gender = [aDecoder decodeObjectForKey:Gender];
        self.sinaUserId = [aDecoder decodeObjectForKey:SinaUserId];
        self.qqUserId = [aDecoder decodeObjectForKey:QQUserId];
        self.email =[aDecoder decodeObjectForKey:Email];
        self.password = [aDecoder decodeObjectForKey:PassWord];
        
        
        self.uid = [aDecoder decodeObjectForKey:Uid];
        self.userType =[aDecoder decodeObjectForKey:UserType];
        self.profileImageUrl =[aDecoder decodeObjectForKey:ProfileImageUrl];
//        self.loginStatus = [aDecoder decodeObjectForKey:LoginStatus];
        self.labelsArray =[aDecoder decodeObjectForKey:LabelsArray];
        
        self.age =[aDecoder decodeObjectForKey:Age];
        self.height =[aDecoder decodeObjectForKey:Height];
        self.weight =[aDecoder decodeObjectForKey:Weight];
        self.BMIValue =[aDecoder decodeObjectForKey:BmiValue];
        self.city =[aDecoder decodeObjectForKey:City];
        self.province =[aDecoder decodeObjectForKey:Province];

    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.avatarBackGroundImage forKey:AvatarBackGroundImage];
    [aCoder encodeObject:self.name forKey:Name];
    [aCoder encodeObject:self.description forKey:Description];
    
    
    [aCoder encodeObject:self.gender forKey:Gender];
    [aCoder encodeObject:self.sinaUserId forKey:SinaUserId];
    [aCoder encodeObject:self.qqUserId forKey:QQUserId];
    [aCoder encodeObject:self.email forKey:Email];
    [aCoder encodeObject:self.password forKey:PassWord];

    
    
    [aCoder encodeObject:self.uid forKey:Uid];
    [aCoder encodeObject:self.userType forKey:UserType];
    [aCoder encodeObject:self.profileImageUrl forKey:ProfileImageUrl];
//    [aCoder encodeObject:self.loginStatus forKey:LoginStatus];
    [aCoder encodeObject:self.labelsArray forKey:LabelsArray];
    
    
    
    [aCoder encodeObject:self.age forKey:Age];
    [aCoder encodeObject:self.height forKey:Height];
    [aCoder encodeObject:self.weight forKey:Weight];
    [aCoder encodeObject:self.BMIValue forKey:BmiValue];
    [aCoder encodeObject:self.city forKey:City];
    [aCoder encodeObject:self.province forKey:Province];

}


-(void)dealloc{
    
    [_avatarBackGroundImage release];
    [_name release];
    [_description release];
    
    [_gender release];
    [_sinaUserId release];
    [_qqUserId release];
    [_email release];
    [_password release];

    [_uid release];
    [_userType release];
    [_profileImageUrl release];
    /////////
    [_labelsArray release];
    
    [_age release];
    [_height release];
    [_weight release];
    [_BMIValue release];
    [_city release];
    [_province release];

    [super dealloc];
}

//- (BOOL)isLogin
//{
//    return [self.loginStatus boolValue];
//}

@end
