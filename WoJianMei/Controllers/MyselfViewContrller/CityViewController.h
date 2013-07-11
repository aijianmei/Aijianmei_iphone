//
//  CityViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/10/13.
//
//

#import "PPTableViewController.h"

@protocol pickCityDelegate <NSObject>
@required
-(void) didPickCity:(NSString *)aCity;
@end


@interface CityViewController : PPTableViewController
{
    NSArray *_citiesList;
    NSInteger _selectedRow;
    NSString *_selectedCity;
    
    NSString *_selectedProvince;
}

@property (nonatomic,retain) NSArray *citiesList;
@property(nonatomic, assign) id<pickCityDelegate>delegate;
@property(nonatomic, retain) NSString *selectedCity;
@property(nonatomic, retain) NSString *selectedProvince;


@end
