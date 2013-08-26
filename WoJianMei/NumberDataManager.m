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
    
    NSString *listCount = [NSString stringWithFormat:@"%d",[self.dataList count]];
    
    NumberData *numberDate = [NumberData creatNumberDatasWithNumerDataId:listCount
                                                                    Name:name
                                                                  number:number
                                                                  weight:weight
                                                                    time:time
                                                                calories:calories];
    
    [self.dataList addObject:numberDate];
    
}

- (NumberData *)getNumberDataById:(NSString *)numberDataId{
    
    NSLog(@"######numberDataId :%@######",numberDataId);
    if (numberDataId == nil) {
        return nil;
    }
    

    
    for (int i = 0; i < [_dataList count]; ++i) {
        NumberData *numberData = [_dataList objectAtIndex:i];
        
        
        if ([numberData.numerDataId isEqualToString:numberDataId]) {
            return numberData;
        }
    }
    return nil;
}




@end
