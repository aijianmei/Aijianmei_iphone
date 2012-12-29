//
//  FitnessNetworkRequest.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/22/12.
//
//

#import <Foundation/Foundation.h>

#import "PPNetworkRequest.h"
#import "FitnessNetworkConstants.h"

typedef void (^TravelNetworkResponseBlock)(NSDictionary* jsonDictionary, NSData* data, int resultCode);

@interface FitnessNetworkRequest : NSObject



+ (CommonNetworkOutput*)queryVersion;

@end
