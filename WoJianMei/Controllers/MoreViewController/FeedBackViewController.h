//
//  ChangeDescriptionViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 7/9/13.
//
//

#import "PPViewController.h"
#import <RestKit/RestKit.h>


@interface FeedBackViewController : PPViewController<UITextFieldDelegate,RKObjectLoaderDelegate>

{
    UITextField *_descriptionTextField;

}
@property (nonatomic,retain) IBOutlet UITextField *descriptionTextField;


@end
