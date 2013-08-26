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

}
@property (nonatomic,retain) NSMutableArray *dataList;

+(NumberDataManager *)defaultManager;
-(void)addNumberDataWithId:(NSString*)aId
                      name:(NSString *)name
                    number:(NSString *)number
                    weight:(NSString *)weight
                      time:(NSString *)time
                  calories:(NSString*)calories;
- (NumberData *)getNumberDataById:(NSString *)numberDataId;


@end
