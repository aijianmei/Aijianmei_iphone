//
//  WorkDataService.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/26/13.
//
//

#import "WorkoutDataService.h"


@implementation WorkoutDataService



+(WorkoutDataService *)sharedService;

{
    static WorkoutDataService *_sharedService = nil;
    @synchronized(self)
    {
        if (_sharedService == nil) {
            _sharedService = [[WorkoutDataService alloc] init];
        }
    }
    return _sharedService;
}

- (id)init
{
    if (self ==nil) {
        self = [super init];
    }
    return self;
}


-(void)postWorkoutDataWithUserId:(NSString *)uid                    delegate:(id<RKObjectLoaderDelegate>)delegate{


}




@end
