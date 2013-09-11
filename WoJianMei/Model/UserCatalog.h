//
//  UserCatalog.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/27/13.
//
//

#import <Foundation/Foundation.h>
@interface Catalog : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *_id;
@end




@interface UserCatalog : NSObject
@property (nonatomic, retain) NSString *errorCode;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSArray *catalogList;

@end
