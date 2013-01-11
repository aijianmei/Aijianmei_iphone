//
//  UserService.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/22/12.
//
//

#import "UserService.h"
#import "CommonService.h"
#import "FitnessNetworkConstants.h"
#import "FitnessNetworkRequest.h"
#import "JSON.h"


@implementation UserService


static UserService* _defaultUserService = nil;


+ (UserService*)defaultService{

    
        if (_defaultUserService == nil) {
            _defaultUserService = [[UserService alloc] init];
        }
        return _defaultUserService;
    }


- (void)queryVersion:(id<UserServiceDelegate>)delegate{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CommonNetworkOutput *output = [FitnessNetworkRequest queryVersion];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (output.resultCode == ERROR_SUCCESS) {
                NSDictionary* jsonDict = [output.textData JSONValue];
                NSString *app_version = (NSString*)[jsonDict objectForKey:PARA_TRAVEL_APP_VERSION];
                NSString *app_data_version = (NSString*)[jsonDict objectForKey:PARA_TRAVEL_APP_DATA_VERSION];
                
                NSString *app_update_title = (NSString *)[jsonDict objectForKey:PARA_TRAVEL_APP_UPDATE_TITLE];
                NSString *app_update_content = (NSString *)[jsonDict objectForKey:PARA_TRAVEL_APP_UPDATE_CONTENT];
                
                if (delegate && [delegate respondsToSelector:@selector(queryVersionFinish:dataVersion:title:content:)]) {
                    [delegate queryVersionFinish:app_version dataVersion:app_data_version title:app_update_title content:app_update_content];
                }
            }
        });
    });
}





@end
