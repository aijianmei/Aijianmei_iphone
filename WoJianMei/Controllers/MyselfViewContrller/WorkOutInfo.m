//
//  WorkOutInfo.m
//  WoJianMei
//
//  Created by Tom Callon  on 6/4/13.
//
//

#import "WorkOutInfo.h"




#define DATE    @"date"
#define IMAGE   @"image"
#define NOTE    @"note"
#define DATAS   @"datas"


@implementation WorkOutInfo

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
//        NSDate          *_date;
//        UIImage        *_image;
//        NSString        *_note;
//        NSMutableArray *_datas;

        self.date = [aDecoder   decodeObjectForKey:DATE];
        self.image =[aDecoder  decodeObjectForKey:IMAGE];
        self.note =[aDecoder    decodeObjectForKey:NOTE];
        self.datas = [aDecoder decodeObjectForKey:DATAS];
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder{
    

    [aCoder encodeObject:self.date   forKey:DATE];
    [aCoder encodeObject:self.image forKey:IMAGE];
    [aCoder encodeObject:self.note   forKey:NOTE];
    [aCoder encodeObject:self.datas forKey:DATAS];
  
    
}


-(void)dealloc{
    
    [_date  release];
    [_image release];
    [_note  release];
    [_datas release];

    [super dealloc];
}


@end
