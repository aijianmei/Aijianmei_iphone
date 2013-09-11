//
//  NumberData.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import <Foundation/Foundation.h>

@interface NumberData : NSObject
{
    NSString *_id;
    NSString *_name;
    NSString *_number;
    NSString *_weight;
    NSString *_time;
    NSString *_calories;
}

@property (nonatomic,retain) NSString *numerDataId;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *number;
@property (nonatomic,retain) NSString *weight;
@property (nonatomic,retain) NSString *time;
@property (nonatomic,retain) NSString *calories;

+(NumberData *)creatNumberDatasWithNumerDataId:(NSString *)numberDataId
                                          Name:(NSString *)name
                                        number:(NSString *)number
                                        weight:(NSString *)weight
                                          time:(NSString *)time
                                      calories:(NSString *)calories;





@end


@interface NumberDataInfo : NSObject
{
    NSString *_uid;
    NSString *_errorCode;
    
    NSString *_coureName;
    NSString *_numAvg;
    NSString *_weightAvg;
    NSString *_timeAvg;
    NSString *_caloriesAvg;



    
    NSArray *_numberDataArray;

}
@property (nonatomic,retain) NSString *uid;
@property (nonatomic,retain) NSString *errorCode;
@property (nonatomic,retain) NSString *coureName;
@property (nonatomic,retain) NSString *numAvg;
@property (nonatomic,retain) NSString *weightAvg;
@property (nonatomic,retain) NSString *timeAvg;
@property (nonatomic,retain) NSString *caloriesAvg;

@property (nonatomic,retain) NSArray *numberDataArray;






@end
