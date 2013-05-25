//
//  SignUpViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 5/23/13.
//
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController


@synthesize  signupWebView =_signupWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setTitle:@"没有爱健美账号？现在就注册！"];
    
    
    
//    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
//    
    
    
    NSURL *url =  [NSURL URLWithString:@"http://www.aijianmei.com/index.php?app=index&mod=User&act=register"];
    [self.signupWebView loadRequest:[NSURLRequest requestWithURL:url]];

    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    

    return YES;

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"finished download");
}

- (void)webViewDidStartLoad:(UIWebView *)webView{

    NSLog(@"I did start loading !");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    NSLog(@"%@",error);
    

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_signupWebView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSignupWebView:nil];
    [super viewDidUnload];
}
@end
