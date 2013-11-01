//
//  WorkDataService.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/26/13.
//
//

#import "WorkoutDataService.h"
#import "WorkoutCatalog.h"
#import "Result.h"
#import "UserCatalog.h"
#import "NumberData.h"
#import "NumberDataManager.h"


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


//
///*
// http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getAllAtionList
//
//{
//part: "肩部",
//list: [
//    {
//        id: "3",
//    name: "卧推"
//    },
//    {
//        id: "2",
//    name: "哑铃卧推"
//    },
//    {
//        id: "1",
//    name: "哑铃飞鸟"
//    },
// */
//
////下载锻炼目录列表数据,不同用户的数据也是不同的，
////这里将会保存用户的不同数据
//-(void)loadWorkoutCatalogListWithUid:(NSString *)uid
//                            delegate:(id<RKObjectLoaderDelegate>)delegate{
//
//    //Router setup:
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    [objectManager.router routeClass:[WorkoutCatalog class] toResourcePath:@"/ios.php" forMethod:RKRequestMethodPOST];
//    
//    NSLog(@"Post an object baseURL %@%@",[objectManager baseURL],@"/ios.php");
//    
//    //Mapping setup:
//    RKObjectMapping *workoutCatalogMapping = [RKObjectMapping mappingForClass:[WorkoutCatalog class]];
//    [workoutCatalogMapping mapKeyPathsToAttributes:
//     @"part", @"part",
//     @"list", @"workouts",
//     nil];
//    
//    
//    //Mapping setup:
//    RKObjectMapping *workoutMapping = [RKObjectMapping mappingForClass:[Workout class]];
//    [workoutMapping mapKeyPathsToAttributes:
//     @"id", @"_id",
//     @"name", @"name",
//     nil];
//    
//    
//    [workoutCatalogMapping mapKeyPath:@"list"
//             toRelationship:@"workouts"
//                withMapping:workoutMapping];
//    
//    
//
//    [objectManager.mappingProvider addObjectMapping:workoutCatalogMapping];
//    [objectManager.mappingProvider setMapping:workoutCatalogMapping forKeyPath:@""];
//    
//    
//    
//     
//     
//    
//    WorkoutCatalog *workoutCatalog = [[WorkoutCatalog alloc]init];
//    
//    //The post
//    RKParams* params = [RKParams params];
//    [params setValue:@"aijianmei" forParam:@"aucode"];
//    [params setValue:@"getAllAtionList" forParam:@"auact"];
//    [params setValue:uid forParam:@"uid"];
//
//    
//        
//    [objectManager postObject:workoutCatalog usingBlock:^(RKObjectLoader *loader)
//     {
//         loader.delegate = delegate;
//         loader.params = params;
//         loader.targetObject = nil;
//         loader.onDidLoadResponse = ^(RKResponse *response) {
//             NSLog(@"Response did arrive");
//             NSLog(@"%@",response.bodyAsString);
//         };
//     }];
//}
//
///*
// http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=postUserActionList&uid=498&actionId=23
// 
// {
// uid: 498,
// errorCode: "0"
// }
// 
//*/
//-(void)postWorkoutCatalogListWithUserId:(NSString *)uid
//                               actionId:(NSString *)actionId
//                               delegate:(id<RKObjectLoaderDelegate>)delegate{
//    //Router setup:
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    [objectManager.router routeClass:[Result class] toResourcePath:@"/ios.php" forMethod:RKRequestMethodPOST];
//    
//    NSLog(@"Post an object baseURL %@%@",[objectManager baseURL],@"/ios.php");
//    
//    //Mapping setup:
//    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[Result class]];
//    [userMapping mapKeyPathsToAttributes:
//     @"uid", @"uid",
//     @"errorCode",@"errorCode",
//     nil];
//    
//    
//    
//    [objectManager.mappingProvider addObjectMapping:userMapping];
//    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@""];
//    
//    
//    Result *result = [[[Result alloc]init] autorelease];
//    
//  //  http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=postUserActionList&uid=498&actionId=23
//    
//    //The post
//    RKParams* params = [RKParams params];
//    [params setValue:@"aijianmei" forParam:@"aucode"];
//    [params setValue:@"postUserActionList" forParam:@"auact"];
//    [params setValue:uid forParam:@"uid"];
//    [params setValue:actionId forParam:@"actionId"];
//
//    NSLog(@"####post  uid :%@",uid);
//    NSLog(@"#####Post actionId :%@",actionId);
//    
//    
//    [objectManager postObject:result usingBlock:^(RKObjectLoader *loader)
//     {
//         loader.delegate = delegate;
//         loader.params = params;
//         loader.targetObject = nil;
//         loader.onDidLoadResponse = ^(RKResponse *response) {
//             NSLog(@"Response did arrive");
//             NSLog(@"%@",response.bodyAsString);
//         };
//     }];
//}
//
///*http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getUserActionListById&uid=498
// 
// uid: "498",
// errorCode: "0",
// userActionList: [
// {
// name: "训练器卧推",
// id: "23"
// },
// {
// name: "上斜杠铃卧推",
// id: "22"
// },
// {
// name: "哑铃飞鸟",
// id: "1"
// },
// {
// name: "哑铃卧推",
// id: "2"
// },
// {
// name: "卧推",
// id: "2"
// },
// {
// name: "深蹲",
// id: "4"
// },
// {
// name: "俯卧撑",
// id: "5"
// },
// {
// name: "引体向上",
// id: "6"
// },
// {
// name: "箭步蹲",
// id: "7"
// },
// {
// name: "单臂哑铃前平举",
// id: "8"
// }
// ]
// }
// 
// 
// */
////下载锻炼个人目录数据是个人的目录,每个人的目录都不一定相同
//-(void)loadUserSpecificWorkoutDataWithUserId:(NSString *)uid                    delegate:(id<RKObjectLoaderDelegate>)delegate{
//    //Router setup:
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    [objectManager.router routeClass:[UserCatalog class] toResourcePath:@"/ios.php" forMethod:RKRequestMethodPOST];
//    
//    NSLog(@"Post an object baseURL %@%@",[objectManager baseURL],@"/ios.php");
//    
//    //Mapping setup:
//    RKObjectMapping *userCatalogMapping = [RKObjectMapping mappingForClass:[UserCatalog class]];
//    [userCatalogMapping mapKeyPathsToAttributes:
//     @"uid", @"uid",
//     @"errorCode",@"errorCode",
//     @"userActionList",@"catalogList",
//     nil];
//    
//    
//    
//    //Mapping setup:
//    RKObjectMapping *catalogMapping = [RKObjectMapping mappingForClass:[Catalog class]];
//    [catalogMapping mapKeyPathsToAttributes:
//     @"id", @"_id",
//     @"name", @"name",
//     nil];
//    
//    
//    [userCatalogMapping mapKeyPath:@"userActionList"
//                       toRelationship:@"catalogList"
//                          withMapping:catalogMapping];
//
//    [objectManager.mappingProvider addObjectMapping:userCatalogMapping];
//    [objectManager.mappingProvider setMapping:userCatalogMapping forKeyPath:@""];
//    
//    
//    
//    
//    UserCatalog *userCatalog = [[[UserCatalog alloc] init] autorelease];
//    
//    //The post
//    RKParams* params = [RKParams params];
//    [params setValue:@"aijianmei" forParam:@"aucode"];
//    [params setValue:@"getUserActionListById" forParam:@"auact"];
//    [params setValue:uid forParam:@"uid"];
//
//
//    [objectManager postObject:userCatalog usingBlock:^(RKObjectLoader *loader)
//     {
//         loader.delegate = delegate;
//         loader.params = params;
//         loader.targetObject = nil;
//         loader.onDidLoadResponse = ^(RKResponse *response) {
//             NSLog(@"Response did arrive");
//             NSLog(@"%@",response.bodyAsString);
//         };
//     }];
//}
//
//
///*
// http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getCourseInfo&uid=498&actionId=1&date=20130820
//
// [
// {
// uid: 0,
// errorCode: 0,
// coureList: [
// {
// nums: 100,
// weight: 23,
// time: 56,
// calories: 0
// },
// {
// nums: 2,
// weight: 2,
// time: 2,
// calories: 0
// },
// {
// nums: 3,
// weight: 3,
// time: 3,
// calories: 0
// },
// {
// nums: 4,
// weight: 4,
// time: 4,
// calories: 0
// }
// ]
// }
// ]
// 
//*/
//
////下载锻炼个人单个锻炼的数据，包括组数、次数、时间、重量、卡路里
//-(void)loadUserWorkoutDataWithUserId:(NSString *)uid
//                           workoutId:(NSString *)workoutId
//                            delegate:(id<RKObjectLoaderDelegate>)delegate{
//
//
//    //Router setup:
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    [objectManager.router routeClass:[NumberDataInfo class] toResourcePath:@"/ios.php" forMethod:RKRequestMethodPOST];
//    
//    NSLog(@"Post an object baseURL %@%@",[objectManager baseURL],@"/ios.php");
//    
//    //Mapping setup:
//    RKObjectMapping *numberDataMapping = [RKObjectMapping mappingForClass:[NumberDataInfo class]];
//    [numberDataMapping mapKeyPathsToAttributes:
//     @"uid", @"uid",
//     @"errorCode",@"errorCode",
//     @"coureName",@"coureName",
//     @"numAvg",@"numAvg",
//     @"weightAvg",@"weightAvg",
//     @"timeAvg",@"timeAvg",
//     @"caloriesAvg",@"caloriesAvg",
//     @"coureList",@"numberDataArray",
//     nil];
//    
//    
//    //Mapping setup:
//    RKObjectMapping *catalogMapping = [RKObjectMapping mappingForClass:[NumberData class]];
//    [catalogMapping mapKeyPathsToAttributes:
//     @"groupId", @"numerDataId",
//     @"weight", @"weight",
//     @"nums", @"number",
//     @"time", @"time",
//     @"calories", @"calories",
//
//     nil];
//    
//    
//    [numberDataMapping mapKeyPath:@"coureList"
//                    toRelationship:@"numberDataArray"
//                       withMapping:catalogMapping];
//    
//    [objectManager.mappingProvider addObjectMapping:numberDataMapping];
//    [objectManager.mappingProvider setMapping:numberDataMapping forKeyPath:@""];
//    
//    
//    
//    
//    NumberDataInfo *numberDataInfo = [[[NumberDataInfo alloc] init] autorelease];
//    
//    //The post
//    RKParams* params = [RKParams params];
//    [params setValue:@"aijianmei" forParam:@"aucode"];
//    [params setValue:@"getCourseInfo" forParam:@"auact"];
//    [params setValue:uid forParam:@"uid"];
//    [params setValue:workoutId forParam:@"actionId"];
//
//    
//    
//    
//    [objectManager postObject:numberDataInfo usingBlock:^(RKObjectLoader *loader)
//     {
//         loader.delegate = delegate;
//         loader.params = params;
//         loader.targetObject = nil;
//         loader.onDidLoadResponse = ^(RKResponse *response) {
//             NSLog(@"Response did arrive");
//             NSLog(@"%@",response.bodyAsString);
//         };
//     }];
//    
//    
//}
//
//
///*
// 
// http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=postCourseInfo&uid=498
// */
//
////下载锻炼个人单个锻炼的数据，包括组数、次数、时间、重量、卡路里
//-(void)postUserWorkoutDataWithUserId:(NSString *)uid
//                           workoutId:(NSString *)workoutId
//                            delegate:(id<RKObjectLoaderDelegate>)delegate{
//    //Router setup:
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    [objectManager.router routeClass:[Result class] toResourcePath:@"/ios.php" forMethod:RKRequestMethodPOST];
//    
//    NSLog(@"Post an object baseURL %@%@",[objectManager baseURL],@"/ios.php");
//    
//    //Mapping setup:
//    RKObjectMapping *numberDataMapping = [RKObjectMapping mappingForClass:[Result class]];
//    [numberDataMapping mapKeyPathsToAttributes:
//     @"uid", @"uid",
//     @"errorCode",@"errorCode",
//     nil];
//    
//    
//    [objectManager.mappingProvider addObjectMapping:numberDataMapping];
//    [objectManager.mappingProvider setMapping:numberDataMapping forKeyPath:@""];
//    
//    
//    Result *result = [[[Result alloc] init] autorelease];
//    
//    
//    //The post
//    RKParams* params = [RKParams params];
//    [params setValue:@"aijianmei" forParam:@"aucode"];
//    [params setValue:@"postCourseInfo" forParam:@"auact"];
//    [params setValue:uid forParam:@"uid"];
//    [params setValue:workoutId forParam:@"actionId"];
//    
//    NSMutableArray *array  = [[NumberDataManager defaultManager] dataList];
//    
//    NSMutableArray *numberArray  =[[NSMutableArray alloc]init];
//    NSMutableArray *weightArray  =[[NSMutableArray alloc]init];
//    NSMutableArray *timeArray    =[[NSMutableArray alloc]init];
//
//    //只有当数组大于1的时候会进行以下操作
//    if ([array count] >=1) {
//        
//        for (int i = 0; i <= [array count] - 1; i++) {
//            
//            NumberData *numberData = [array objectAtIndex:i];
//            
//            [numberArray addObject:numberData.number];
//            [weightArray addObject:numberData.weight];
//            [timeArray   addObject:numberData.time];
//        }
//
//    }
//        
//    [params setValue:numberArray forParam:@"numberArray"];
//    [params setValue:weightArray forParam:@"weightArray"];
//    [params setValue:timeArray   forParam:@"timeArray"];
//
//    
//    [objectManager postObject:result usingBlock:^(RKObjectLoader *loader)
//     {
//         loader.delegate = delegate;
//         loader.params = params;
//         loader.targetObject = nil;
//         loader.onDidLoadResponse = ^(RKResponse *response) {
//             NSLog(@"Response did arrive");
//             NSLog(@"%@",response.bodyAsString);
//         };
//     }];    
//}






@end
