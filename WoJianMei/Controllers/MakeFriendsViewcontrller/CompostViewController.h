//
//  CompostViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/20/13.
//
//

#import "PPViewController.h"

@interface CompostViewController : PPViewController<UITextViewDelegate>

{
    UITextView *textView;
	UIView *accessoryView;


}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIView *accessoryView;

- (IBAction)tappedMe:(id)sender;


@end
