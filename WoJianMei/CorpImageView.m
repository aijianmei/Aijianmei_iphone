//
//  ViewController.m
//  image
//
//  Created by 岩 邢 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CorpImageView.h"

@interface CorpImageView ()

@end

@implementation CorpImageView
@synthesize imgView =_imgView;




-(void)dealloc{
    [_imgView release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //imgView = [[self.view subviews]objectAtIndex:0];
    cliper = [[UICliper alloc]initWithImageView:_imgView];
    
    NSData *imageData = UIImageJPEGRepresentation(self.imgView.image, 1.0);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *tmpPathToFile = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/avtar.png", path]];
    
    if([imageData writeToFile:tmpPathToFile atomically:YES]){
        //Write was successful.
        
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setImgView:nil];
    // Release any retained subviews of the main view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape( interfaceOrientation );
    //return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
