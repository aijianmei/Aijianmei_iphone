//
//  WorkDataService.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/26/13.
//
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


@interface WorkoutDataService : NSObject<RKObjectLoaderDelegate>



+(WorkoutDataService *)sharedService;

@end
