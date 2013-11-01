//
//  WorkDataService.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/26/13.
//
//

#import <Foundation/Foundation.h>


@interface WorkoutDataService : NSObject


- (id)init;
+(WorkoutDataService *)sharedService;




/*
 http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getAllAtionList
 
 {
 part: "肩部",
 list: [
 {
 id: "3",
 name: "卧推"
 },
 {
 id: "2",
 name: "哑铃卧推"
 },
 {
 id: "1",
 name: "哑铃飞鸟"
 },
 
 */
//下载锻炼目录列表数据,总目录
-(void)loadWorkoutCatalogListWithUid:(NSString *)uid
//                            delegate:(id<RKObjectLoaderDelegate>)delegate
;




/*
 http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=postUserActionList&uid=498&actionId=23
 
 {
 uid: 498,
 errorCode: "0"
 }
 
 */
//更新锻炼目录列表数据,每个用户点击选择之后都会进行更新
-(void)postWorkoutCatalogListWithUserId:(NSString *)uid
                               actionId:(NSString *)actionId
//                               delegate:(id<RKObjectLoaderDelegate>)delegate
;






/*http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getUserActionListById&uid=498
 
 uid: "498",
 errorCode: "0",
 userActionList: [
 {
 name: "训练器卧推",
 id: "23"
 },
 {
 name: "上斜杠铃卧推",
 id: "22"
 },
 {
 name: "哑铃飞鸟",
 id: "1"
 },
 {
 name: "哑铃卧推",
 id: "2"
 },
 {
 name: "卧推",
 id: "2"
 },
 {
 name: "深蹲",
 id: "4"
 },
 {
 name: "俯卧撑",
 id: "5"
 },
 {
 name: "引体向上",
 id: "6"
 },
 {
 name: "箭步蹲",
 id: "7"
 },
 {
 name: "单臂哑铃前平举",
 id: "8"
 }
 ]
 }
 
 
 */
//下载锻炼个人目录数据是个人的目录,每个人的目录都不一定相同
-(void)loadUserSpecificWorkoutDataWithUserId:(NSString *)uid
//                                    delegate:(id<RKObjectLoaderDelegate>)delegate
;



/*
 [
 {
 uid: "498",
 errorCode: "0",
 coureList: [
 {
 nums: 100,
 weight: 23,
 time: 56,
 calories: 0,
 groupId: "1"
 },
 {
 nums: 2,
 weight: 2,
 time: 2,
 calories: 0,
 groupId: "2"
 },
 {
 nums: 3,
 weight: 3,
 time: 3,
 calories: 0,
 groupId: "3"
 },
 {
 nums: 4,
 weight: 4,
 time: 4,
 calories: 0,
 groupId: "4"
 }
 ]
 }
 ]
 
 
 http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getCourseInfo&uid=498&actionId=1&date=20130820
 
 */
//下载锻炼个人单个锻炼的数据，包括组数、次数、时间、重量、卡路里
-(void)loadUserWorkoutDataWithUserId:(NSString *)uid
                           workoutId:(NSString *)workoutId
//                            delegate:(id<RKObjectLoaderDelegate>)delegate
;




/*
 
 http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=postCourseInfo&uid=498
 */

//下载锻炼个人单个锻炼的数据，包括组数、次数、时间、重量、卡路里
-(void)postUserWorkoutDataWithUserId:(NSString *)uid
                           workoutId:(NSString *)workoutId
//                            delegate:(id<RKObjectLoaderDelegate>)delegate
;

    


@end
