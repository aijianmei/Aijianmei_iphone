//
//  FitnessNetworkRequest.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/22/12.
//
//

#import "FitnessNetworkRequest.h"
#import "FitnessNetworkConstants.h"

#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "PPDebug.h"





@implementation FitnessNetworkRequest

+ (CommonNetworkOutput*)sendRequest:(NSString*)baseURL
                constructURLHandler:(ConstructURLBlock)constructURLHandler
                    responseHandler:(FitnessNetworkResponseBlock)responseHandler
                       outputFormat:(int)outputFormat
                             output:(CommonNetworkOutput*)output
{
    NSURL* url = nil;
    if (constructURLHandler != NULL)
        url = [NSURL URLWithString:[constructURLHandler(baseURL) stringByURLEncode]];
    else
        url = [NSURL URLWithString:baseURL];
    
    if (url == nil){
        output.resultCode = ERROR_CLIENT_URL_NULL;
        return output;
    }
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setAllowCompressedResponse:YES];
    [request setTimeOutSeconds:NETWORK_TIMEOUT];
    
    
#ifdef DEBUG
    int startTime = time(0);
    PPDebug(@"[SEND] URL=%@", [url description]);
#endif
    
    [request startSynchronous];
    //    BOOL *dataWasCompressed = [request isResponseCompressed]; // Was the response gzip compressed?
    //    NSData *compressedResponse = [request rawResponseData]; // Compressed data
    //    NSData *uncompressedData = [request responseData]; // Uncompressed data
    
    NSError *error = [request error];
    int statusCode = [request responseStatusCode];
    
#ifdef DEBUG
    PPDebug(@"[RECV] : status=%d, error=%@", [request responseStatusCode], [error description]);
#endif
    
    if (error != nil){
        output.resultCode = ERROR_NETWORK;
    }
    else if (statusCode != 200){
        output.resultCode = statusCode;
    }
    else{
        
#ifdef DEBUG
        int endTime = time(0);
        PPDebug(@"[RECV] data (len=%d bytes, latency=%d seconds, raw=%d bytes, real=%d bytes)",
                [[request responseData] length], (endTime - startTime),
                [[request rawResponseData] length], [[request responseData] length]);
#endif
        
        if (outputFormat == FORMAT_FITNESS_PB){
            responseHandler(nil, [request responseData], output.resultCode);
            output.responseData = [request responseData];
        }
        else{
            NSString *text = [request responseString];
            NSDictionary *jsonDictionary = nil;
            output.textData = text;
            if ([text length] > 0){
                jsonDictionary = [text JSONValue];
            }
#ifdef DEBUG
            PPDebug(@"[RECV] JSON string data : %@", text);
#endif
            
            responseHandler(jsonDictionary, nil, output.resultCode);
        }
        
        return output;
    }
    
    return output;
}



////更新版本
+ (CommonNetworkOutput*)queryVersion
{
    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)  {
        NSString* str = [NSString stringWithString:baseURL];
        return str;
    };
    
    FitnessNetworkResponseBlock responseHandler = ^(NSDictionary* jsonDictionary, NSData* data, int resultCode) {
        return;
    };
    
    return [FitnessNetworkRequest sendRequest:URL_FITNESS_QUERY_VERSION
                         constructURLHandler:constructURLHandler
                             responseHandler:responseHandler
                                outputFormat:FORMAT_FITNESS_JSON
                                      output:output];
    
    NSLog(@"%@ the url of the update ",[[FitnessNetworkRequest sendRequest:URL_FITNESS_QUERY_VERSION
                                                      constructURLHandler:constructURLHandler
                                                          responseHandler:responseHandler
                                                             outputFormat:FORMAT_FITNESS_JSON
                                                                   output:output] description]);
}


+ (CommonNetworkOutput*)login{
    
//    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
//    
//    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)  {
//        NSString* str = [NSString stringWithString:baseURL];
//        return str;
//    };
//    
//    FitnessNetworkResponseBlock responseHandler = ^(NSDictionary* jsonDictionary, NSData* data, int resultCode) {
//        return;
//    };
//    
//    return [FitnessNetworkRequest sendRequest:URL_FITNESS_QUERY_VERSION
//                          constructURLHandler:constructURLHandler
//                              responseHandler:responseHandler
//                                 outputFormat:FORMAT_FITNESS_JSON
//                                       output:output];
//    
//    NSLog(@"%@ the url of the update ",[[FitnessNetworkRequest sendRequest:URL_FITNESS_QUERY_VERSION
//                                                       constructURLHandler:constructURLHandler
//                                                           responseHandler:responseHandler
//                                                              outputFormat:FORMAT_FITNESS_JSON
//                                                                    output:output] description]);
//
//

}


































@end
