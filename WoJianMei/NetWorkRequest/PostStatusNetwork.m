//
//  PostStatusNetwork.m
//  WoJianMei
//
//  Created by Tom Callon  on 1/21/14.
//
//

#import "PostStatusNetwork.h"
#import "PPNetworkConstants.h"
#import "FitnessNetworkConstants.h"
#import "PostStatusNetworkConstant.h"
#import "StringUtil.h"



@implementation PostStatusNetwork



///Post Single Image Statuse
///Statuses
+(CommonNetworkOutput *)postStatusByUid:(NSString*)baseURL
                                    uId:(NSString *)uid
                                  image:(NSData *)image
                                content:(NSString*)content

{
    
    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)
    {
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        
        str = [str stringByAddQueryParameter:AUCODE
                                       value:AIJIANMEI];
        str = [str stringByAddQueryParameter:PARA_AUACT
                                       value:@"postcircleList"];
        str = [str stringByAddQueryParameter:PARA_UID
                                       value:uid];
        str = [str stringByAddQueryParameter:@"content"
                                       value:content];
        
        return str;
        
    };
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
        
        //确定返回的数据类型
        output.jsonDataDict = [dict objectForKey:RET_DATA];
        return;
    };
    
    
    NSMutableDictionary *dataDict = nil;
//    if (drawData) {
//        dataDict = [NSMutableDictionary dictionary];
//        [dataDict setObject:drawData forKey:PARA_DRAW_DATA];
//    }
    
    NSMutableDictionary *imageDict = [NSMutableDictionary dictionaryWithCapacity:1];
    
    //如果是超过两张图片,就是用一下格式
//    if (drawImage) {
//        [imageDict setObject:drawImage forKey:PARA_DRAW_IMAGE];
//    }
    if (image) {
        [imageDict setObject:image forKey:PARA_IMAGE];
    }

    
    return [PPNetworkRequest uploadRequest:baseURL
                             imageDataDict:imageDict
                              postDataDict:dataDict
                       constructURLHandler:constructURLHandler
                           responseHandler:responseHandler
                                    output:output];
    
    //  //  http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getcircleList
    //        //Router setup:
    //        RKObjectManager *objectManager = [RKObjectManager sharedManager];
    //        [objectManager.router routeClass:[PostStatusRespose class] toResourcePath:@"/ios.php" forMethod:RKRequestMethodPOST];
    //
    //        NSLog(@"Post an Image baseURL %@%@",[objectManager baseURL],@"/ios.php");
    //
    //        //Mapping setup:
    //        RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[PostStatusRespose class]];
    //        [userMapping mapKeyPathsToAttributes:
    //         @"errorCode", @"errorCode",
    //         @"uid",@"uid",
    //         nil];
    //        [objectManager.mappingProvider addObjectMapping:userMapping];
    //        [objectManager.mappingProvider setMapping:userMapping forKeyPath:@""];
    //
    //      PostStatusRespose *postStatusRespose = [[PostStatusRespose alloc]init];
    //
    //        //The post
    //        RKParams* params = [RKParams params];
    //        [params setValue:@"aijianmei" forParam:@"aucode"];
    //        [params setValue:@"postcircleList" forParam:@"auact"];
    //        [params setValue:uid forParam:@"uid"];
    //        [params setValue:content forParam:@"content"];
    //
    //        NSData *imageData = UIImagePNGRepresentation(image);
    //        if (imageData)
    //        {
    //           [params setData:imageData MIMEType:@"image/png" forParam:@"imageurl"];
    //        }
    //
    //        [objectManager postObject:postStatusRespose usingBlock:^(RKObjectLoader *loader)
    //         {
    //             loader.delegate = delegate;
    //             loader.params = params;
    //             loader.targetObject = nil;
    //             loader.onDidLoadResponse = ^(RKResponse *response) {
    //                 NSLog(@"Response did arrive");
    //                 NSLog(@"%@",response.bodyAsString);
    //             };
    //         }];
    //}
    //
    
}

///load Single Image Statuse
+ (CommonNetworkOutput *)loadStatusesById:(NSString*)baseURL
                                       Id:(NSString*)Id
                                 targetId:(NSString*)targetId
                                 gymGroup:(NSString*)gymGroup
                                    start:(NSString*)start
                                   offSet:(NSString*)offSet{
    
    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)
    {
        
        
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        
        str = [str stringByAddQueryParameter:AUCODE
                                       value:AIJIANMEI];
        str = [str stringByAddQueryParameter:PARA_AUACT
                                       value:@"getCircleList"];
        str = [str stringByAddQueryParameter:PARA_UID
                                       value:Id];
        str = [str stringByAddQueryParameter:@"targetUid"
                                       value:targetId];
        str = [str stringByAddQueryParameter:@"group"
                                       value:gymGroup];
        str = [str stringByAddQueryParameter:@"start"
                                       value:start];
        str = [str stringByAddQueryParameter:@"offSet"
                                       value:offSet];
        
        return str;
        
    };
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
        
        //确定返回的数据类型
        //        output.jsonDataDict = [dict objectForKey:RET_DATA];
        
        output.jsonDataArray = (NSArray *)dict;
        
        return;
    };
    
    return [PPNetworkRequest forTestingsendRequest:baseURL
                               constructURLHandler:constructURLHandler
                                   responseHandler:responseHandler
                                            output:output];
    
}








@end
