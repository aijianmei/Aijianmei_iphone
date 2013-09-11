//
//  NumberDataManager.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/20/13.
//
//

#import "NumberDataManager.h"
#import "NumberData.h"
NumberDataManager *numberDataManager;
extern NumberDataManager   *GlobalNumberDataManager()
{
    if (numberDataManager == nil) {
        numberDataManager = [[NumberDataManager alloc] init];
    }
    
    return numberDataManager;
}

@implementation NumberDataManager
@synthesize   dataList = _dataList;


@synthesize numAvg =_numAvg;
@synthesize weightAvg =_weightAvg;
@synthesize timeAvg =_timeAvg;
@synthesize caloriesAvg =_caloriesAvg;



-(void)dealloc{
    
    [_numAvg release];
    [_timeAvg release];
    [_caloriesAvg release];
    [_weightAvg release];
    [_dataList release];
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
         self.dataList =[[NSMutableArray alloc]init];
        }
    return self;
}

+(NumberDataManager *)defaultManager{
    return GlobalNumberDataManager();
}

-(void)addNumberDataWithId:(NSString*)aId
                      name:(NSString *)name
                    number:(NSString *)number
                    weight:(NSString *)weight
                      time:(NSString *)time
                  calories:(NSString*)calories{
    
    NSString *listCount = [NSString stringWithFormat:@"%d",[self.dataList count] + 1];
    
    NumberData *numberDate = [NumberData creatNumberDatasWithNumerDataId:listCount
                                                                    Name:name
                                                                  number:number
                                                                  weight:weight
                                                                    time:time
                                                                calories:calories];
    
    [_dataList addObject:numberDate];
    
    
    //重新计算一次平均值
    [self countAvgOfTheData];
}

- (NumberData *)getNumberDataById:(NSString *)numberDataId{
    
    NSLog(@"######numberDataId :%@######",numberDataId);
    if (numberDataId == nil) {
        return nil;
    }
    if ([_dataList count]==0) {
        return nil;
    }


    for (int i = 0; i <= [_dataList count]; ++i) {
        NumberData *numberData = [_dataList objectAtIndex:i];
        if ([numberData.numerDataId isEqualToString:numberDataId]) {
            return numberData;
        }
    }
    //重新计算一次平均值
    [self countAvgOfTheData];
    return nil;
}


-(void)countAvgOfTheData{
    
    self.numAvg =@"0";
    self.weightAvg =@"0";
    self.caloriesAvg =@"0";
    self.timeAvg =@"0";
    
    float numSumFloat = [[self numAvg] integerValue];
    float weightSumFloat = [[self weightAvg] integerValue];
    float timeSumFloat = [[self timeAvg] integerValue];
    float caloriesSumFloat = [[self caloriesAvg] integerValue];
    
    if ([_dataList count] ==0) {
        self.numAvg =@"0.0";
        self.weightAvg =@"0.0";
        self.timeAvg =@"0.0";
        self.caloriesAvg =@"0.0";

        return;
    }
    
    
    for (int i =0;  i < [_dataList count]; i ++) {
        
        NumberData *numberData = [_dataList objectAtIndex:i];
        
        numSumFloat =  numSumFloat + [numberData.number integerValue];
        
        weightSumFloat =  weightSumFloat + [numberData.weight integerValue];
        
        timeSumFloat =  timeSumFloat + [numberData.time integerValue];
        
        caloriesSumFloat =  caloriesSumFloat + [numberData.calories integerValue];
    }
    
    float numAvgFloat = numSumFloat/[_dataList count];
    self.numAvg =[NSString stringWithFormat:@"%.1f",numAvgFloat];
    
    float weightAvgFloat = weightSumFloat/[_dataList count];
    self.weightAvg =[NSString stringWithFormat:@"%.1f",weightAvgFloat];
    
    float timeAvgFloat = timeSumFloat/[_dataList count];
    self.timeAvg =[NSString stringWithFormat:@"%.1f",timeAvgFloat];
    
    float caloriesAvgFloat  = caloriesSumFloat/[_dataList count];
    self.caloriesAvg =[NSString stringWithFormat:@"%.1f",caloriesAvgFloat];
  
    NSLog(@"计算得出组数平均值%@",self.numAvg);
    NSLog(@"计算得出重量平均值%@",self.weightAvg);
    NSLog(@"计算得出时间平均值%@",self.timeAvg);
    NSLog(@"计算得出卡路里平均值%@",self.caloriesAvg);

}



@end
