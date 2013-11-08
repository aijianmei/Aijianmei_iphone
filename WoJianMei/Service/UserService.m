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
#import "User.h"
#import "Result.h"
#import "SinaResult.h"
#import "VersionInfo.h"
#import "UIDevice+IdentifierAddition.h"
#import "UserManager.h"
#import "UIImageExt.h"
#import "BlockUtils.h"



@implementation UserService


static UserService* _defaultUserService = nil;

- (void)dealloc
{
    [_user release];
    [super dealloc];
}

+ (UserService*)defaultService
{
    if (_defaultUserService == nil) {
            _defaultUserService = [[UserService alloc] init];
//        [_defaultUserService getUserInfoByUid:@"0"];
    }
    return _defaultUserService;
}




- (void)loginUserWithEmail:(NSString*)email
                  password:(NSString*)password
                  usertype:(NSString*)usertype
            viewController:(PPViewController<UserServiceDelegate>*)viewController;
{
    
    //http://42.96.132.109/wapapi/ios.php?&aucode=aijianmei&auact=au_login&email=ronaldotomcallon@qq.com&userpassword=xxxxxxxxx&usertype=local
    
    [viewController showProgressHUDActivityWithText:@"登陆中..."];
    
    //A new working Queue
    dispatch_async(workingQueue, ^{
        
        CommonNetworkOutput* output = nil;
        output = [FitnessNetworkRequest loginUserByEmail:SERVER_URL
                                                   email:email
                                                password:password
                                                usertype:usertype];
        
        //Back to the Main Queue
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSDictionary    *dictionary ;
            NSString        *uid;
            [viewController hideProgressHUDActivity];
            
            
            if (output.resultCode == ERROR_SUCCESS) {
                
                 dictionary = output.jsonDataDict;
                 uid= [dictionary objectForKey:@"uid"];
                
                [viewController dismissViewControllerAnimated:YES completion:^{}];
                
            }
            
            else if (output.resultCode == ERROR_NETWORK) {
                [viewController popupUnhappyMessage:NSLS(@"kSystemFailure") title:nil];
                
                
            }
            else if (output.resultCode == ERROR_EMAIL_VERIFIED) {
                // @"对不起，用户注册无法完成，请联系我们的技术支持以便解决问题"
                [viewController popupUnhappyMessage:NSLS(@"用户名或密码错误") title:nil];
                
            }
            
            else {
                // @"对不起，注册失败，请稍候再试"
                //                [viewController popupUnhappyMessage:NSLS(@"kGeneralFailure") title:nil];
                
            }
            
            if ([viewController respondsToSelector:@selector(didUserLogined:uid:)]){
                
                [viewController didUserLogined:output.resultCode
                                           uid:uid];
            }
            
            
            
        });
    });
}


- (void)registerUser:(NSString*)email
            password:(NSString*)password
      viewController:(PPViewController<UserServiceDelegate>*)viewController
{
//    NSString* deviceToken = [[UserManager defaultManager] deviceToken];
//    NSString* deviceId = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
    
//    NSString* deviceToken = nil;
//    NSString* deviceId = nil;
//    
//    [viewController showActivityWithText:NSLS(@"kRegisteringUser")];
//    dispatch_async(workingQueue, ^{
//        
//        CommonNetworkOutput* output = nil;
//        output = [FitnessNetworkRequest registerUserByEmail:SERVER_URL
//                                                   email:email
//                                                password:password
//                                             deviceToken:deviceToken
//                                                deviceId:deviceId];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [viewController hideActivity];
//            if (output.resultCode == ERROR_SUCCESS) {
//                // save return User ID locally
//                NSString* userId = [output.jsonDataDict objectForKey:PARA_USERID];
//                NSString* nickName = [UserManager nickNameByEmail:email];
//                
//                // save data
//                [[UserManager defaultManager] saveUserId:userId
//                                                   email:email
//                                                password:password
//                                                nickName:nickName
//                                               avatarURL:nil];
//                
//                int coinBalance = [[output.jsonDataDict objectForKey:PARA_ACCOUNT_BALANCE] intValue];
//                [[AccountManager defaultManager] updateBalance:coinBalance currency:PBGameCurrencyCoin];
//                
//                if ([viewController respondsToSelector:@selector(didUserRegistered:)]){
//                    [viewController didUserRegistered:output.resultCode];
//                }
//            }
//            else if (output.resultCode == ERROR_NETWORK) {
//                [viewController popupUnhappyMessage:NSLS(@"kSystemFailure") title:nil];
//            }
//            else if (output.resultCode == ERROR_USERID_NOT_FOUND) {
//                // @"对不起，用户注册无法完成，请联系我们的技术支持以便解决问题"
//                [viewController popupUnhappyMessage:NSLS(@"kUnknownRegisterFailure") title:nil];
//            }
//            else if (output.resultCode == ERROR_EMAIL_EXIST) {
//                // @"对不起，该电子邮件已经被注册"
//                [viewController popupUnhappyMessage:NSLS(@"kEmailUsed") title:nil];
////                InputDialog *dialog = [InputDialog dialogWith:NSLS(@"kUserLogin") delegate:viewController];
////                [dialog.targetTextField setPlaceholder:NSLS(@"kEnterPassword")];
////                [dialog showInView:viewController.view];
//            }
//            else if (output.resultCode == ERROR_EMAIL_NOT_VALID) {
//                // @"对不起，该电子邮件格式不正确，请重新输入"
//                [viewController popupUnhappyMessage:NSLS(@"kEmailNotValid") title:nil];
//            }
//            else {
//                // @"对不起，注册失败，请稍候再试"
//                [viewController popupUnhappyMessage:NSLS(@"kGeneralFailure") title:nil];
//            }
//        });
//    });    
}


- (void)userRegisterByToken:(NSString*)token
{
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        //        CommonNetworkOutput *output = [FootballNetworkRequest getRegisterUserId:1 token:token];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
    
            //            if (output.textData != nil) {
            //                [UserManager createUser:output.textData];
            //                PPDebug(@"<UserService>)userRegisterByToken: Created User <%@>",output.textData);
            //            }
            //            else {
            //                PPDebug(@"<UserService>)userRegisterByToken:　Get User ID faild");
            //            }
            
//        });
//    });
}





//更新版本的接口
- (void)initVersionMap
{
//    //获取在AppDelegate中生成的第一个RKObjectManager对象
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    //将json映射到class
//    RKObjectMapping *articleMapping =[RKObjectMapping mappingForClass:[VersionInfo class]];
//    [articleMapping mapKeyPathsToAttributes:
//     @"version", @"version",
//     @"downloadurl",@"downloadurl",
//     @"app_update_title",@"updateTitle",
//     @"app_update_content",@"updateContent",nil];
//    [objectManager.mappingProvider setMapping:articleMapping forKeyPath:@""];
}


//用户版本更新
//- (void)queryVersionWithDelegate:(id<RKObjectLoaderDelegate>)delegate
//{
//    [self initVersionMap];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    // http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_getversion
//        
//        NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
//        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
//        [queryParams setObject:@"au_getversion" forKey:@"auact"];
//        
//    
//        RKObjectManager *objectManager = [RKObjectManager sharedManager];
//        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/ios.php" queryParameters:queryParams];
//        
//        NSLog(@"url: %@", [url absoluteString]);
//        NSLog(@"resourcePath: %@", [url resourcePath]);
//        NSLog(@"query: %@", [url query]);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
//        });
//    });
//}



//用户反馈
//- (void)postFeedbackWithUid:(NSString*)uid
//                    content:(NSString*)content
//                   delegate:(id<RKObjectLoaderDelegate>)delegate
//{
    
//    [self initResultMap];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
      //  http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_sendsuggestion&uid=1&content=ohmygod
        
//        NSMutableDictionary *queryParams = [[NSMutableDictionary alloc] init];
//        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
//        [queryParams setObject:@"au_sendsuggestion" forKey:@"auact"];
//        [queryParams setObject:uid forKey:@"uid"];
//        [queryParams setObject:content forKey:@"content"];
//        
//        
//        
//        RKObjectManager *objectManager = [RKObjectManager sharedManager];
//        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/ios.php" queryParameters:queryParams];
//        
//        NSLog(@"url: %@", [url absoluteString]);
//        NSLog(@"resourcePath: %@", [url resourcePath]);
//        NSLog(@"query: %@", [url query]);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
//        });
//    });
//}








// 用户登录，只是使用邮箱密码马上可以登录
//- (void)loginUserWithEmail:(NSString*)email
//                        password:(NSString*)password
//                        usertype:(NSString*)usertype

//                  delegate:(id<RKObjectLoaderDelegate>)delegate
//{
    
//    [self initResultMap];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSMutableDictionary *queryParams = [[[NSMutableDictionary alloc] init] autorelease];
//        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
//        [queryParams setObject:@"au_login" forKey:@"auact"];
//        [queryParams setObject:email forKey:@"email"];
//        [queryParams setObject:password forKey:@"userpassword"];
//        [queryParams setObject:usertype forKey:@"usertype"];
//
//        
//        RKObjectManager *objectManager = [RKObjectManager sharedManager];
//        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/ios.php" queryParameters:queryParams];
//        
//        NSLog(@"url: %@", [url absoluteString]);
//        NSLog(@"resourcePath: %@", [url resourcePath]);
//        NSLog(@"query: %@", [url query]);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
////            [objectManager loadObjectsAtResourcePath:@"" usingBlock:^(RKObjectLoader *loader)
////            {
////                loader.delegate = delegate;
////                loader.targetObject = nil;
////                loader.method = RKRequestMethodPOST;
////                loader.onDidLoadResponse = ^(RKResponse *response) {
////                    NSLog(@"Response did arrive");
////                    NSLog(@"%@",response.bodyAsString);
////                    
////                    loader.params =queryParams;
////                    
////                };
////            }];
//
//            
//
//            
//            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
//        });
//    });
//}





// 用户登录，只是使用邮箱密码马上可以登录
- (void)fecthUserInfoWithUid:(NSString*)uid
              viewController:(PPViewController<UserServiceDelegate>*)viewController;
{
    
    [viewController showActivityWithText:@"..."];
     //http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_getuserinfobyuid&uid=435

    //A new working Queue
    dispatch_async(workingQueue, ^{
        
        CommonNetworkOutput* output = nil;
        output = [FitnessNetworkRequest fetchUserInfoByUid:SERVER_URL
                                                       uid:uid];
        
        //Back to the Main Queue
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [viewController hideActivity];
             NSDictionary *dictionary;
            
            if (output.resultCode == ERROR_SUCCESS) {
                
                dictionary=output.jsonDataDict;
                [[UserManager  defaultManager] saveUserId:[dictionary objectForKey:PARA_USER_UID]
                                                    email:[dictionary objectForKey:PARA_USER_EMAIL]
                                                   height:[dictionary objectForKey:PARA_USER_HEIGHT]
                                                 password:[dictionary objectForKey:PARA_USER_PASSWORD]
                                                 nickName:[dictionary objectForKey:PARA_USER_NAME]
                                                avatarURL:[dictionary objectForKey:PARA_USER_PROFILE_IMAGE_URL]
                                                     city:[dictionary objectForKey:PARA_USER_CITY]
                                              loginStatus:[dictionary objectForKey:PARA_USER_LOGIN_STATUS]
                                               sinaUserId:[dictionary objectForKey:PARA_USER_SINA_USER_ID]
                                                 qqUserId:[dictionary objectForKey:PARA_USER_QQ_USER_ID]
                                                 userType:[dictionary objectForKey:PARA_USER_TYPE]
                                              labelsArray:[dictionary objectForKey:PARA_USER_LABELS_ARRAY]
                                                   gender:[dictionary objectForKey:PARA_USER_GENDER]
                                                 BMIValue:[dictionary objectForKey:PARA_USER_BMI_VALUE]
                                                 province:[dictionary objectForKey:PARA_USER_PROVINCE]
                                                      age:[dictionary objectForKey:PARA_USER_AGE]
                                              description:[dictionary objectForKey:PARA_USER_DESCRIPTION]
                                                   weight:[dictionary objectForKey:PARA_USER_Weight]
                                 avatarBackgroundImageURL:[dictionary objectForKey:PARA_USER_BACKGROUND_IMAGE_URL]];
                

                
                
            }
            
            else if (output.resultCode == ERROR_NETWORK) {
                [viewController popupUnhappyMessage:NSLS(@"kSystemFailure") title:nil];
                
                
            }
            else if (output.resultCode == ERROR_EMAIL_VERIFIED) {
                // @"对不起，用户注册无法完成，请联系我们的技术支持以便解决问题"
                [viewController popupUnhappyMessage:NSLS(@"用户名或密码错误") title:nil];
                
            }
            
            else {
                // @"对不起，注册失败，请稍候再试"
                //                [viewController popupUnhappyMessage:NSLS(@"kGeneralFailure") title:nil];
                
            }
            
            if ([viewController respondsToSelector:@selector(didLoadUserInfoSucceeded:)]){
                
                [viewController didLoadUserInfoSucceeded:output.resultCode];
            }});});
    
    
}




- (void)fechUserIdBySnsId:(NSString*)snsID
           viewController:(PPViewController<UserServiceDelegate>*)viewController

{
    [viewController showProgressHUDActivityWithText:@"加载中..."];
    
    //A new working Queue
    dispatch_async(workingQueue, ^{
    
        CommonNetworkOutput* output = nil;
        output = [FitnessNetworkRequest fetchUserSinaWeiboId:SERVER_URL
                                                       snsId:snsID];
        
        //Back to the Main Queue
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [viewController hideProgressHUDActivity];
            
            NSDictionary *dictionary ;
            NSString     *uid;

            if (output.resultCode == ERROR_SUCCESS) {
                
                PPDebug(@"Fetch User ID by SINAWEIBO id ");
                
                dictionary = output.jsonDataDict;
                uid = [dictionary objectForKey:@"uid"];
                
                    [UserManager createUserWithUserId:uid
                                           sinaUserId:nil
                                             qqUserId:nil
                                             userType:nil
                                                 name:nil
                                      profileImageUrl:nil
                                               gender:nil
                                                email:nil
                                             password:nil];
                
                
                [viewController dismissViewControllerAnimated:YES completion:^{}];

            }
            else if (output.resultCode == ERROR_NETWORK) {
                [viewController popupUnhappyMessage:NSLS(@"网络错误,请稍后再试") title:nil];
                
                
            }
            else {
                // @"对不起，注册失败，请稍候再试"
//                [viewController popupUnhappyMessage:NSLS(@"kGeneralFailure") title:nil];
                
            }
            
            
            
            if ([viewController respondsToSelector:@selector(loginBySinaWeiboAccount:uid:)]){

               
                [viewController loginBySinaWeiboAccount:output.resultCode
                                           uid:uid];
                
                
            }
            });
        });
}






- (void)registerAijianmeiUserWithUsername:(NSString*)name
                                    email:(NSString*)email
                                 password:(NSString*)password
                                 usertype:(NSString*)usertype
                           viewController:(PPViewController<UserServiceDelegate>*)viewController

{
    
   // URL=http://42.96.132.109/wapapi/ios.php?&aucode=aijianmei&auact=au_register&username=ghsdfgdfs6&email=asdfasdf@qq.com&userpassword=asdfasdff&usertype=local
    
    [viewController showProgressHUDActivityWithText:@"注册中..."];

    //A new working Queue
    dispatch_async(workingQueue, ^{
        
        CommonNetworkOutput* output = nil;
        output = [FitnessNetworkRequest  registerUserByName:SERVER_URL
                                                       name:name
                                                      email:email
                                                   password:password
                                                   usertype:usertype];
        
        //Back to the Main Queue
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [viewController hideProgressHUDActivity];
            
            if (output.resultCode == ERROR_SUCCESS) {
                
                PPDebug(@"Fetch User ID by SINAWEIBO id ");
                
                [viewController dismissViewControllerAnimated:YES completion:^{}];
                
            }
            else if (output.resultCode == ERROR_NETWORK) {
                //                [viewController popupUnhappyMessage:NSLS(@"kSystemFailure") title:nil];
                
                
            }
            else if (output.resultCode == ERROR_USERID_NOT_FOUND) {
                // @"对不起，用户注册无法完成，请联系我们的技术支持以便解决问题"
                //                [viewController popupUnhappyMessage:NSLS(@"kUnknownRegisterFailure") title:nil];
                
                
                
            }
            else if (output.resultCode == ERROR_EMAIL_EXIST) {
                // @"对不起，该电子邮件已经被注册"
                //                [viewController popupUnhappyMessage:NSLS(@"kEmailUsed") title:nil];
                //                InputDialog *dialog = [InputDialog dialogWith:NSLS(@"kUserLogin") delegate:viewController];
                //                [dialog.targetTextField setPlaceholder:NSLS(@"kEnterPassword")];
                //                [dialog showInView:viewController.view];
                
                
                
                
            }
            else if (output.resultCode == ERROR_EMAIL_NOT_VALID) {
                // @"对不起，该电子邮件格式不正确，请重新输入"
                //                [viewController popupUnhappyMessage:NSLS(@"kEmailNotValid") title:nil];
                
                
                
            }
            else {
                // @"对不起，注册失败，请稍候再试"
                //                [viewController popupUnhappyMessage:NSLS(@"kGeneralFailure") title:nil];
                
            }
            
            
            
            if ([viewController respondsToSelector:@selector(signUpSucceeded:)]){
                
                NSArray *array  = (NSArray *)output.jsonDataDict;
                NSDictionary *dictionary = [array objectAtIndex:0];
                NSString *uid = [dictionary objectForKey:@"uid"];
                [viewController signUpSucceeded:output.resultCode];
                
                
            }
        });
    });

}


- (void)registerUserWithUsername:(NSString*)name
                           email:(NSString*)email
                        password:(NSString*)password
                        usertype:(NSString*)usertype
                           snsId:(NSString*)snsId
                 profileImageUrl:(NSString*)profileImageUrl
                             sex:(NSString*)sex
                             age:(NSString*)age
                     body_weight:(NSString*)weight
                          height:(NSString*)height
                         keyword:(NSString*)keyword
                        province:(NSString*)province
                            city:(NSString*)city
//                        delegate:(id<RKObjectLoaderDelegate>)delegate

{
//    [self initResultMap];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSMutableDictionary *queryParams = [[[NSMutableDictionary alloc] init] autorelease];
//        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
//        [queryParams setObject:@"au_register" forKey:@"auact"];
//        [queryParams setObject:usertype forKey:@"usertype"];
//        [queryParams setObject:snsId forKey:@"snsid"];
//        [queryParams setObject:name forKey:@"username"];
//        [queryParams setObject:email forKey:@"email"];
//        [queryParams setObject:password forKey:@"userpassword"];
//        [queryParams setObject:profileImageUrl forKey:@"profileImageUrl"];
//        [queryParams setObject:sex forKey:@"sex"];
//        [queryParams setObject:weight forKey:@"body_weight"];
//        [queryParams setObject:height forKey:@"height"];
//        [queryParams setObject:keyword forKey:@"keyword"];
//        [queryParams setObject:province forKey:@"province"];
//        [queryParams setObject:city forKey:@"city"];
//        
//        RKObjectManager *objectManager = [RKObjectManager sharedManager];
//        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/ios.php" queryParameters:queryParams];
//        
//        NSLog(@"url: %@", [url absoluteString]);
//        NSLog(@"resourcePath: %@", [url resourcePath]);
//        NSLog(@"query: %@", [url query]);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
//        });
//    });
}


- (void)initUserMap
{
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    RKObjectMapping *resultMapping =[RKObjectMapping mappingForClass:[User class]];
//    [resultMapping mapKeyPathsToAttributes:
//     @"uid", @"_uid",
//     @"userType", @"userType",
//     @"profileImageUrl", @"profileImageUrl",
//     @"avatarBackGroundImage",@"avatarBackGroundImage",
//     @"name", @"name",
//     @"description", @"description",
//     @"gender", @"gender",
//     @"sinaUserId",@"sinaUserId",
//     @"qqUserId",@"qqUserId",
//     @"email", @"email",
//     @"labelsArray", @"labelsArray",
//     @"age", @"age",
//     @"height", @"height",
//     @"weight", @"weight",
//     @"BMIValue", @"BMIValue",
//     @"province", @"province",
//     @"city", @"city",
//     nil];
//    
//    [objectManager.mappingProvider setMapping:resultMapping forKeyPath:@""];
    
}

/* 当用户选择使用新浪微博登陆的时候，要
    进行判断，该新浪微博的id 是否已经是我们的用户
 */

- (void)registerUserWithSinaUserInfo:(NSDictionary*)userInfo

//                            delegate:(id<RKObjectLoaderDelegate>)delegate
{
//    [self initResultMap];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithDictionary:userInfo];
//        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
//        [queryParams setObject:@"au_register" forKey:@"auact"];
//        [queryParams setObject:@"sina" forKey:@"usertype"];
//        
//        RKObjectManager *objectManager = [RKObjectManager sharedManager];
//        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/ios.php" queryParameters:queryParams];
//        
//        NSLog(@"url: %@", [url absoluteString]);
//        NSLog(@"resourcePath: %@", [url resourcePath]);
//        NSLog(@"query: %@", [url query]);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
//        });
//    });
}


- (void)fechUserBySnsId:(NSString*)snsID
               userType:(NSString*)userType
//                            delegate:(id<RKObjectLoaderDelegate>)delegate
{
//    [self initUserMap];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//   // http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=au_getuserinfobysnsid&snsid=2578458467&usertype=sina
//        
//        
//        NSMutableDictionary *queryParams = [[[NSMutableDictionary  alloc]init] autorelease];
//        [queryParams setObject:@"aijianmei" forKey:@"aucode"];
//        [queryParams setObject:@"au_getuserinfobysnsid" forKey:@"auact"];
//        [queryParams setObject:snsID forKey:@"snsid"];
//        [queryParams setObject:userType forKey:@"usertype"];
//
//        
//        RKObjectManager *objectManager = [RKObjectManager sharedManager];
//        RKURL *url = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/ios.php" queryParameters:queryParams];
//        
//        NSLog(@"url: %@", [url absoluteString]);
//        NSLog(@"resourcePath: %@", [url resourcePath]);
//        NSLog(@"query: %@", [url query]);
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [url resourcePath], [url query]] delegate:delegate ];
//        });
//    });
}





- (void)fetchSinaUserInfo:(NSString*)uid
                    delegate:(id<SinaWeiboRequestDelegate>)delegate
{
     //https://api.weibo.com/2/users/show.json

    _sinaweiboManager = [SinaWeiboManager sharedManager];
    [_sinaweiboManager.sinaweibo requestWithURL:@"users/show.json"
                                         params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                 uid, @"uid", nil]
                                     httpMethod:@"GET"
                                       delegate:delegate];
}

//保存新浪微博的信息
- (void)storeSinaUserInfo:(NSDictionary*)userInfo
{
    NSLog(@"<storeSinaUserInfo>:%@",[[userInfo objectForKey:@"id"] stringValue]);
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:[[userInfo objectForKey:@"id"] stringValue]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//读取新浪微博的信息
- (NSDictionary*)getSinaUserInfoWithUid:(NSString *)uid
{
    if (!uid) {
        return nil;
    }
    
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:uid];
    NSDictionary *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    return userInfo;
}

//删除新浪微博的信息
- (void)deleteSinaUserInfoWithUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults]  removeObjectForKey:uid];
    NSLog(@"######Delete sinaweibo account with ID :%@",uid);
    [[SinaWeiboManager sharedManager] removeAuthData];
    [[[SinaWeiboManager sharedManager] sinaweibo] logOut];
    
}



-(void)storeUserInfoByUid:(NSString *)uid
{
    
    //以后程序启动的时候就是要读取默认的这个Uid数据;
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"OriginalUserId"];
    
    
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:self.user];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:uid];
    
}


-(User*)getUserInfoByUid:(NSString *)uid
{
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:uid];
    User *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return user;
}

-(void)deleteUserByUid:(NSString *)uid
{
    
    if ([self.user sinaUserId])
    {
        [self deleteSinaUserInfoWithUid:[self.user sinaUserId]];
    }
    
    if ([self getUserInfoByUid:uid])
    {
        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:uid];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OriginalUserId"];
        NSLog(@"####Delete User with ID :%@ Successfully!",uid);
    }
    
    [self setUser:nil];
}

//关注爱健美网新浪微博
- (void)createSinaFriendshipWithUid:(NSString*)uid
                 delegate:(id<SinaWeiboRequestDelegate>)delegate
{
    
    //https://api.weibo.com/2/friendships/create.json
    
    
    _sinaweiboManager = [SinaWeiboManager sharedManager];
    [_sinaweiboManager.sinaweibo requestWithURL:@"friendships/create.json"
                                         params: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                  uid, @"uid", nil]
                                     httpMethod:@"POST"
                                       delegate:delegate];
    
}


-(void)shareThroughSinaWeiboWithImageArray:(NSArray *)imageArray
                               TextContent:(NSString *)TextContent
                                  delegate:(id<SinaWeiboRequestDelegate>)delegate
{
        NSString *status = @"我正在使用爱健美客户端！";
        UIImage *pic =[UIImage imageNamed:@"Default.png"];


         NSMutableDictionary * params =[NSMutableDictionary dictionaryWithObjectsAndKeys:
                               status, @"status",pic,@"pic",nil];

          [[SinaWeiboManager sharedManager].sinaweibo requestWithURL:@"statuses/upload.json"
                                                    params:params
                                                httpMethod:@"POST"
                                                  delegate:delegate];
    
}

+ (void)followWeixinUser:(NSString *)userData{

  

}

- (void)uploadUserAvatar:(UIImage*)image
             resultBlock:(UploadImageResultBlock)resultBlock
{
    //    http://42.96.132.109/wapapi/imgtest.php
    
    // save data locally firstly
//    [[UserManager defaultManager] saveAvatarLocally:image];
//    [[UserManager defaultManager] storeUserData];

    NSString* userId = [[UserManager defaultManager] userId];
    NSData* data = [image data];
    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = [FitnessNetworkRequest uploadUserImage:SERVER_URL
                                                                      userId:userId
                                                                   imageData:data
                                                                   imageType:PARA_AVATAR];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (output.resultCode == ERROR_SUCCESS){
                
                // update avatar
                NSString* retURL = [[output jsonDataDict] objectForKey:PARA_URL];
//                [[UserManager defaultManager] setAvatar:retURL];
//                [[UserManager defaultManager] storeUserData];
                
                
                EXECUTE_BLOCK(resultBlock, output.resultCode, retURL);
            }
            else{
                EXECUTE_BLOCK(resultBlock, output.resultCode, nil);
            }
            
        });
    });
    


    
    
    
    
    
    
    
    
    
    //Router setup: 
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    [objectManager.router routeClass:[User class] toResourcePath:@"/imgtest.php" forMethod:RKRequestMethodPOST];
//    
//    NSLog(@"Post an Image baseURL %@%@",[objectManager baseURL],@"/imgtest.php");
//    

//    
//    //The post
//   User *user =[[UserService defaultService] user];
//    
////    UIImage *image1 = [UIImage imageNamed:@"touxiang_40x40.png"];
////    UIImage *image2 = [UIImage imageNamed:@"table_header_bg.png"];
//    NSData *imageData1 = UIImagePNGRepresentation(image);
////    NSData *imageData2 = UIImagePNGRepresentation(image2);
 
//    RKParams* params = [RKParams params];
//    [params setValue:user.uid forParam:@"uid"];
//    [params setValue:user.profileImageUrl forParam:@"profileImageUrl"];
//    [params setValue:user.name forParam:@"name"];
//    [params setValue:user.description forParam:@"description"];
//    [params setValue:user.gender forParam:@"gender"];
//    [params setValue:user.sinaUserId forParam:@"sinaUserId"];
//    [params setValue:user.email forParam:@"email"];
//    [params setValue:user.age forParam:@"age"];
//    [params setValue:user.weight forParam:@"weight"];
//    [params setValue:user.height forParam:@"height"];
//    [params setValue:user.BMIValue forParam:@"BMIValue"];
//    [params setValue:user.province forParam:@"province"];
//    [params setValue:user.city forParam:@"city"];
//    
//    if (image) {
//    [params setData:imageData1 MIMEType:@"image/png" forParam:@"avatarimage"];
//    }
//    
//    
//
//    
////    [params setData:imageData2 MIMEType:@"image/png" forParam:@"backgroundimage"];
//    
//    
//
//    [objectManager postObject:user usingBlock:^(RKObjectLoader *loader)
//     {
//         loader.delegate = delegate;
//         loader.params = params;
//         loader.targetObject = nil;
//         loader.objectMapping = userMapping;
//         loader.method = RKRequestMethodPOST;
//         
//         loader.onDidLoadResponse = ^(RKResponse *response) {
//             NSLog(@"Response did arrive");
//             NSLog(@"%@",response.bodyAsString);
//         };
//     }];
}


- (BOOL)hasBindAccount
{
    if ([self hasbindSina] || [self hasBindEmail])
        return YES;
    else
        return NO;
}

- (BOOL)hasBindEmail
{
    if ([_user.email length] > 0){
        return YES;
    }
    else{
        return NO;
    }
}

- (BOOL)hasbindSina
{
    if ([_user.sinaUserId length] > 0)
        return YES;
    else
        return NO;
}



@end
