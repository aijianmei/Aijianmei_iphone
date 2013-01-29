//
//  CompostViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/20/13.
//
//

#import "PPTableViewController.h"

@interface CompostViewController :PPTableViewController<UITextViewDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>

{
    UITextView      *textView;
	UIView          *textAccessoryView;


}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIView     *textAccessoryView;

- (IBAction)tappedMe:(id)sender;


@end
