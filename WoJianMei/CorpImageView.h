//
//  ViewController.h
//  image
//
//  Created by 岩 邢 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICliper.h"
#import "UIOverView.h"

@interface CorpImageView : UIViewController
{
     UICliper *cliper;
     UIImageView *_imgView;

}
@property (nonatomic,retain) IBOutlet UIImageView *imgView;





@end
