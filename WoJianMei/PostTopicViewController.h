//
//  PostTopicViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 12/3/13.
//
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"

@interface PostTopicViewController : PPViewController<UIActionSheetDelegate>


- (IBAction)clickPickImagesButton:(id)sender;
- (IBAction)clickVotesButton:(id)sender;

@end
