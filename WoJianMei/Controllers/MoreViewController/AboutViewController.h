//
//  AboutViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/21/12.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
@interface AboutViewController : PPViewController
{
    UILabel *_versionLabel;
}

@property (nonatomic,retain) IBOutlet UILabel *versionLable;




@end
