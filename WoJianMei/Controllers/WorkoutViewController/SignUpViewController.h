//
//  SignUpViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 5/23/13.
//
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UIWebViewDelegate>

{
    

       UIWebView *_signupWebView;
    
    
}


@property (retain, nonatomic) IBOutlet UIWebView *signupWebView;

@end
