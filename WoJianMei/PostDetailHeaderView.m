//
//  PostDetailHeaderView.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/10/13.
//
//

#import "PostDetailHeaderView.h"
#import "PPDebug.h"
#import "DeviceDetection.h"
#import "UIImageView+WebCache.h"

#import "PostStatus.h"


@implementation PostDetailHeaderView

+ (id)createView:(id<PostDetailCommonHeaderViewDelegate>)delegate
{
    NSString* identifier = [PostDetailHeaderView getViewIdentifier];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil];
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create %@ but cannot find view object from Nib", identifier);
        return nil;
    }
    PostDetailHeaderView<PostDetailCommonHeaderViewProtocol> *view = [topLevelObjects objectAtIndex:0];
    view.delegate = delegate;
//    [view updateView];
    return view;
}

+ (NSString *)getViewIdentifier
{
    if ([DeviceDetection isIPhone5]) {
    }
    return @"PostDetailHeaderView";
}

+ (CGFloat)heightForTitleText:(NSString *)text
{
    if (text==nil) {
        return 0;
    }
    //size
    CGSize size = CGSizeMake(320, 100);
    
    //Dictionary
    NSAttributedString *attrStr = [[[NSAttributedString alloc] initWithString:text] autorelease];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0
                                    effectiveRange:&range];
    
    CGRect frame =[text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:dic
                                     context:nil];
    CGFloat titleHeight = CGRectGetHeight(frame);
    
    NSLog(@"h = %f", CGRectGetHeight(frame));
    NSLog(@"w = %f", CGRectGetWidth(frame));
    return titleHeight;
}




+ (CGFloat)getViewHeight
{
    return  578.0f;
}



- (void)updateView:(PostStatus*)post{
    
    //Title
    [self.titleLabel setText:@"我练习胸肌的方法正确吗？？buddy !!!!"];
    CGFloat titleHeight =[PostDetailHeaderView   heightForTitleText:self.titleLabel.text];
    [self  resetView:self.titleLabel y:20 height:titleHeight];
//    [self.titleLabel setBackgroundColor:[UIColor redColor]];
    
    
    //Text Content
    [self.contentView setText:@"以下是我的健身房方法哦，请各位大神看看我的健身方法是否正确哦。"];
    CGFloat textHeight =[PostDetailHeaderView   heightForTitleText:self.contentView.text];
    [self  resetView:self.contentView y:20 height:textHeight];
//    [self.contentView setBackgroundColor:[UIColor greenColor]];

    
    
    
    [self.imageView setImageWithURL:[NSURL URLWithString:@"http://192.168.1.106/~tomcallon/image2.jpg"]
                   placeholderImage:[UIImage imageNamed:@"place_holder@2x.png"]
                            success:^(UIImage *image, BOOL cached)
     {
     }
                            failure:^(NSError *error)
     {
         
     }];

    
    [self.nameLable setText:@"我是猛男"];
    [self.genderLabel setText:@"男"];
    [self.fitnessLabel setText:@"健身新手"];
    [self.postTimeLabel setText:@"2014/2/1"];
    [self.visitLabel setText:@"4333人访问"];
    [self.joinLabel setText:@"42参与"];
}

- (void)resetView:(UIView *)view y:(CGFloat)y height:(CGFloat)height
{
    CGRect frame = view.frame;
    frame.size.height = height;
    frame.origin.y = y;
    view.frame = frame;
}



@end
