//
//  FitnessNetworkRequest.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/22/12.
//
//

#import "FitnessNetworkRequest.h"
#import "PPNetworkConstants.h"
#import "FitnessNetworkConstants.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "PPDebug.h"
#import "DeviceDetection.h"
#import "StringUtil.h"



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
    
    NSLog(@"%@ the url of the update ",[[FitnessNetworkRequest sendRequest:
                                         URL_FITNESS_QUERY_VERSION
                                                      constructURLHandler:constructURLHandler
                                                          responseHandler:responseHandler
                                                             outputFormat:FORMAT_FITNESS_JSON
                                                                   output:output] description]);
}


//根据用户的新浪微薄id获取用户的信息
+ (CommonNetworkOutput *)fetchUserSinaWeiboId:(NSString*)baseURL
                                        snsId:(NSString*)snsId
{
    
    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)
    {
        
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        
        str = [str stringByAddQueryParameter:AUCODE
                                       value:AIJIANMEI];
        str = [str stringByAddQueryParameter:PARA_AUACT
                                       value:@"au_getuidbysnsid"];
        str = [str stringByAddQueryParameter:PARA_SNSID
                                       value:snsId];
        return str;
        
    };
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
        
        
//        output.jsonDataDict = [dict objectForKey:RET_DATA];

        output.jsonDataDict = dict;

        
        
        return;
    };
    
    return [PPNetworkRequest sendRequest:baseURL
                     constructURLHandler:constructURLHandler
                         responseHandler:responseHandler
                                  output:output];
}



+ (CommonNetworkOutput *)loginUserByEmail:(NSString*)baseURL
                                    email:(NSString*)email
                                 password:(NSString*)password
                                 usertype:(NSString*)usertype
{
    
    /*
     http://42.96.132.109/wapapi/ios.php?&aucode=aijianmei&auact=au_login&email=ronaldotomcallon@qq.com&userpassword=xxxxxxxx&usertype=local
    */
    
    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)
    {
        
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        
        str = [str stringByAddQueryParameter:AUCODE
                                       value:AIJIANMEI];
        str = [str stringByAddQueryParameter:PARA_AUACT
                                       value:@"au_login"];
        str = [str stringByAddQueryParameter:PARA_EMAIL
                                       value:email];
        str = [str stringByAddQueryParameter:PARA_PASSWORD
                                       value:password];
        str = [str stringByAddQueryParameter:PARA_REGISTER_TYPE
                                       value:usertype];
        
        return str;
        
    };
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
        
        
         //确定返回的数据类型
//         output.jsonDataDict = [dict objectForKey:RET_DATA];
      
         output.jsonDataDict = dict;

        
        
        
        return;
    };
    
    return [PPNetworkRequest sendRequest:baseURL
                     constructURLHandler:constructURLHandler
                         responseHandler:responseHandler
                                  output:output];
    
}


+ (CommonNetworkOutput*)registerUserByName:(NSString *)baseURL
                                      name:(NSString*)name
                                     email:(NSString*)email
                                  password:(NSString*)password
                                  usertype:(NSString*)usertype;
{
    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL) {
        
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        str = [str stringByAddQueryParameter:AUCODE                         value:AIJIANMEI];
        str = [str stringByAddQueryParameter:PARA_AUACT                     value:@"au_register"];
        str = [str stringByAddQueryParameter:PARA_USER_SIGNUP_USERNAME      value:name];
        str = [str stringByAddQueryParameter:PARA_USER_EMAIL                value:email];
        str = [str stringByAddQueryParameter:PARA_USER_SIGNUP_USER_PASSWROD value:password];
        str = [str stringByAddQueryParameter:PARA_USER_SIGNUP_USER_TYPE     value:usertype];
        
        return str;
    };
    
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
        
        
        
//        output.jsonDataDict = [dict objectForKey:RET_DATA];
        
          output.jsonDataArray = (NSArray *) dict;

        
        
        
        return;
    };
    
    return [PPNetworkRequest sendRequest:baseURL
                     constructURLHandler:constructURLHandler
                         responseHandler:responseHandler
                                  output:output];
    
    
}

+ (CommonNetworkOutput *)findArticleWithAucode:(NSString*)baseURL
                                        aucode:(NSString*)aucode
                                         auact:(NSString*)auact
                                      listtype:(NSString*)listtype
                                      category:(NSString*)category
                                          type:(NSString*)type
                                         start:(int)start
                                        offset:(int)offset
                                        cateid:(NSString*)cateid
                                           uid:(NSString*)uid{
    
    /*
    http://42.96.132.109/wapapi/ios.php?&aucode=aijianmei&auact=au_getinformationlist&listtype=2&category=home&type=new&start=0&offset=5&uid=265
     */
    
    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)
    {
        
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        
        str = [str stringByAddQueryParameter:AUCODE
                                       value:AIJIANMEI];
        str = [str stringByAddQueryParameter:PARA_AUACT
                                       value:@"au_getinformationlist"];
        str = [str stringByAddQueryParameter:PARA_LISTTYPE
                                       value:listtype];
        str = [str stringByAddQueryParameter:PARA_CATEGORY
                                       value:category];
        str = [str stringByAddQueryParameter:PARA_TYPE
                                       value:type];
        str = [str stringByAddQueryParameter:PARA_START
                                       value:[NSString stringWithFormat:@"%i",start]];
        str = [str stringByAddQueryParameter:PARA_OFFSET
                                       value:[NSString stringWithFormat:@"%i",offset]];
        str = [str stringByAddQueryParameter:PARA_UID
                                       value:uid];
        
        
        return str;
        
    };
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
        
        
        //确定返回的数据类型
        //         output.jsonDataDict = [dict objectForKey:RET_DATA];
        
        output.jsonDataArray = (NSArray *) dict;
        
        
        
        
        return;
    };
    
    return [PPNetworkRequest sendRequest:baseURL
                     constructURLHandler:constructURLHandler
                         responseHandler:responseHandler
                                  output:output];
    

    
    



}


+ (CommonNetworkOutput *)findArticleInfoWithAucode:(NSString*)baseURL
                                            aucode:(NSString*)aucode
                                             auact:(NSString*)auact
                                         articleId:(NSString*)_id
                                           channel:(NSString*)channel
                                       channelType:(NSString*)channelType
                                               uid:(NSString*)uid{
    
    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)
    {
        
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        
        str = [str stringByAddQueryParameter:AUCODE
                                       value:AIJIANMEI];
        str = [str stringByAddQueryParameter:PARA_AUACT
                                       value:@"au_getinformationdetail"];
        str = [str stringByAddQueryParameter:PARA_ARTICLE_ID
                                       value:_id];
        str = [str stringByAddQueryParameter:PARA_ARTICLE_CHANNLE
                                       value:channel];
        str = [str stringByAddQueryParameter:PARA_ARTICLE_CHANNLE_TYPE
                                       value:channelType];
        str = [str stringByAddQueryParameter:PARA_UID
                                       value:uid];
    
        return str;
        
    };
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
        
        
        //确定返回的数据类型
        //         output.jsonDataDict = [dict objectForKey:RET_DATA];
        
        output.jsonDataArray = (NSArray *) dict;
        
        
        
        
        return;
    };
    
    return [PPNetworkRequest sendRequest:baseURL
                     constructURLHandler:constructURLHandler
                         responseHandler:responseHandler
                                  output:output];


}
+ (CommonNetworkOutput *)postLikeByContentId:(NSString *)baseURL
                                   contentId:(NSString *)contentId
                                      userId:(NSString *)uid
                                 channeltype:(NSString *)channeltype{

    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)
    {
        
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        
        str = [str stringByAddQueryParameter:AUCODE
                                       value:AIJIANMEI];
        str = [str stringByAddQueryParameter:PARA_AUACT
                                       value:@"au_sendlike"];
        str = [str stringByAddQueryParameter:PARA_ARTICLE_ID
                                       value:contentId];
        str = [str stringByAddQueryParameter:PARA_UID
                                       value:uid];
        str = [str stringByAddQueryParameter:PARA_ARTICLE_CHANNLE_TYPE
                                       value:channeltype];
     
        
        return str;
        
    };
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
    
        //确定返回的数据类型
        // output.jsonDataDict = [dict objectForKey:RET_DATA];
        
        output.jsonDataArray = (NSArray *) dict;
        
        
        
        
        return;
    };
    
    return [PPNetworkRequest sendRequest:baseURL
                     constructURLHandler:constructURLHandler
                         responseHandler:responseHandler
                                  output:output];
}

+ (CommonNetworkOutput *)postCommentWithUid:(NSString*)baseURL
                                        uid:(NSString*)uid
                            targetContentId:(NSString*)targetContentId
                                    comment:(NSString *)comment
                                channelType:(NSString *)channelType{

    
    
   //  http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_sendcomment&uid=498&id=111&commentcontent=要好好睡才行&channeltype=1
    
    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)
    {
        
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        
        str = [str stringByAddQueryParameter:AUCODE
                                       value:AIJIANMEI];
        str = [str stringByAddQueryParameter:PARA_AUACT
                                       value:@"au_sendcomment"];
        str = [str stringByAddQueryParameter:PARA_UID
                                       value:uid];
        str = [str stringByAddQueryParameter:PARA_ARTICLE_ID
                                       value:targetContentId];
        str = [str stringByAddQueryParameter:PARA_ARTICLE_COMMENT_CONTENT
                                       value:comment];
        str = [str stringByAddQueryParameter:@"channeltype"
                                       value:channelType];
        
        return str;
        
    };
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
        
        //确定返回的数据类型
        // output.jsonDataDict = [dict objectForKey:RET_DATA];
        
        output.jsonDataArray = (NSArray *) dict;
        
        
        
        return;
    };
    
    return [PPNetworkRequest sendRequest:baseURL
                     constructURLHandler:constructURLHandler
                         responseHandler:responseHandler
                                  output:output];


}



//  http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getcommentbyid&id=117&channeltype=1
+ (CommonNetworkOutput *)loadCommentById:(NSString*)baseURL
                                      Id:(NSString*)Id
                             channelType:(NSString*)channleType{


    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)
    {
        
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        
        str = [str stringByAddQueryParameter:AUCODE
                                       value:AIJIANMEI];
        str = [str stringByAddQueryParameter:PARA_AUACT
                                       value:@"getcommentbyid"];
        str = [str stringByAddQueryParameter:PARA_ARTICLE_ID
                                       value:Id];
        str = [str stringByAddQueryParameter:@"channeltype"
                                       value:channleType];
        
        return str;
        
    };
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
        
        //确定返回的数据类型
        // output.jsonDataDict = [dict objectForKey:RET_DATA];
        
        output.jsonDataArray = (NSArray *) dict;
        
        
        
        return;
    };
    
    return [PPNetworkRequest sendRequest:baseURL
                     constructURLHandler:constructURLHandler
                         responseHandler:responseHandler
                                  output:output];


}


+ (CommonNetworkOutput *)fetchUserInfoByUid:(NSString *)baseURL
                                        uid:(NSString *)uid{
    
    //   http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_getuserinfobyuid&uid=435
    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL)
    {
        
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        
        str = [str stringByAddQueryParameter:AUCODE
                                       value:AIJIANMEI];
        str = [str stringByAddQueryParameter:PARA_AUACT
                                       value:@"au_getuserinfobyuid"];
        str = [str stringByAddQueryParameter:PARA_UID
                                       value:uid];
     
        return str;
        
    };
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
        
        //确定返回的数据类型
        // output.jsonDataDict = [dict objectForKey:RET_DATA];
        
        output.jsonDataArray = (NSArray *) dict;
        
        
        
        return;
    };
    
    return [PPNetworkRequest sendRequest:baseURL
                     constructURLHandler:constructURLHandler
                         responseHandler:responseHandler
                                  output:output];



}

+ (CommonNetworkOutput*)uploadUserImage:(NSString*)baseURL
                                 userId:(NSString*)userId
                              imageData:(NSData*)imageData
                              imageType:(NSString*)imageType{

    CommonNetworkOutput* output = [[[CommonNetworkOutput alloc] init] autorelease];
    
    ConstructURLBlock constructURLHandler = ^NSString *(NSString *baseURL) {
        
        // set input parameters
        NSString* str = [NSString stringWithString:baseURL];
        str = [str stringByAddQueryParameter:PARA_USERID value:userId];
        
        
        return str;
    };
    
    
    PPNetworkResponseBlock responseHandler = ^(NSDictionary *dict, CommonNetworkOutput *output) {
        output.jsonDataDict = [dict objectForKey:RET_DATA];
        return;
    };
    
    return [PPNetworkRequest uploadRequest:baseURL
                                uploadData:imageData
                       constructURLHandler:constructURLHandler
                           responseHandler:responseHandler
                                    output:output];


}











@end
