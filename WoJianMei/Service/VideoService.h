//
//  VideoService.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/1/13.
//
//

#import <Foundation/Foundation.h>

@interface VideoService : NSObject


+(VideoService*)sharedService;

/*  http://42.96.132.109/wapapi/ios.php?aucode=aijianmei&auact=getcommentbyid&id=117&channeltype=1
*/

-(void)loadVideCommentByVideId:(NSString *)VideoId
                   channelType:(NSString *)channleType
//                      delegate:(id<RKObjectLoaderDelegate>)delegate
;


@end
