//
//  NumberDataManager.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/13.
//
//

#import <Foundation/Foundation.h>

@class NumberData;

@interface NumberDataManager : NSObject
{
   
    NSMutableArray *_dataList;
    
    NSString *_numAvg;
    NSString *_weightAvg;
    NSString *_timeAvg;
    NSString *_caloriesAvg;

}
@property (nonatomic,retain) NSMutableArray *dataList;


@property (nonatomic,retain) NSString *numAvg;
@property (nonatomic,retain) NSString *weightAvg;
@property (nonatomic,retain) NSString *timeAvg;
@property (nonatomic,retain) NSString *caloriesAvg;



+(NumberDataManager *)defaultManager;
-(void)addNumberDataWithId:(NSString*)aId
                      name:(NSString *)name
                    number:(NSString *)number
                    weight:(NSString *)weight
                      time:(NSString *)time
                  calories:(NSString*)calories;
- (NumberData *)getNumberDataById:(NSString *)numberDataId;
-(void)countAvgOfTheData;
-(void)countCalorisOfTheData;

@end
