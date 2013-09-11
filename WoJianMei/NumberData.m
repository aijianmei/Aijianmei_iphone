//
//  NumberData.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import "NumberData.h"

@implementation NumberData
@synthesize numerDataId = _id;
@synthesize name =_name;
@synthesize number =_number;
@synthesize weight =_weight;
@synthesize time =_time;
@synthesize calories =_calories;

+(NumberData *)creatNumberDatasWithNumerDataId:(NSString *)numberDataId
                                          Name:(NSString *)name
                                        number:(NSString *)number
                                        weight:(NSString *)weight
                                          time:(NSString *)time
                                      calories:(NSString *)calories
{
    
    NumberData *numberData = [[[NumberData alloc] init] autorelease];
    [numberData setNumerDataId:numberDataId];
    [numberData setName:name];
    [numberData setWeight:weight];
    [numberData setNumber:number];
    [numberData setTime:time];
    [numberData setCalories:calories];
    
    return numberData;
}




-(void)dealloc{
    
    [_id release];
    [_name release];
    [_number release];
    [_weight release];
    [_time release];
    [_calories release];
    [super dealloc];
}


@end


@implementation NumberDataInfo
@synthesize uid =_uid;
@synthesize errorCode =_errorCode;
@synthesize coureName =_coureName;
@synthesize numAvg =_numAvg;
@synthesize weightAvg =_weightAvg;
@synthesize timeAvg =_timeAvg;
@synthesize caloriesAvg =_caloriesAvg;



@synthesize numberDataArray =_numberDataArray;




-(void)dealloc{
    
    [_uid release];
    [_errorCode release];
    
    
    [_coureName release];
    [_numAvg release];
    [_weightAvg release];
    [_timeAvg release];
    [_caloriesAvg release];
    
    
    [_numberDataArray release];
    
    [super dealloc];
}










@end
