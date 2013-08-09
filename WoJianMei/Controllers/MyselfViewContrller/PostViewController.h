//
//  PostViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/6/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"


@interface PostViewController : PPTableViewController
{
    UIImage *_postImage;
    NSString *_postText;
    
}
@property (nonatomic,retain) UIImage *postImage;
@property (nonatomic,retain) NSString *postText;
@property (nonatomic,assign) id delegate;

@end
