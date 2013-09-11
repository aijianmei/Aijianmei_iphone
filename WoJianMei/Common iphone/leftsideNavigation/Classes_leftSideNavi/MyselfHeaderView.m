//
//  MyselfHeaderView.m
//  WoJianMei
//
//  Created by Tom Callon  on 6/17/13.
//
//

#import "MyselfHeaderView.h"

@implementation MyselfHeaderView
@synthesize titleLabel = _titleLabel;
@synthesize headerVImageButton =_headerVImageButton;
@synthesize userNameLabel =_userNameLabel;
@synthesize descriptionLabel =_descriptionLabel;
@synthesize userBackGroundImageView =_userBackGroundImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndexSep.png"]];
        bgImageView.frame = CGRectMake(0.0, 0.0, frame.size.width, frame.size.height);
        bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:bgImageView];
        [bgImageView release];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, frame.size.width - 20.0, frame.size.height)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor =[UIColor whiteColor];
        [self addSubview:_titleLabel];
        [_titleLabel release];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _titleLabel.frame = CGRectMake(10.0, 0.0, frame.size.width - 20.0, frame.size.height);
}

-(void)dealloc{

    
    [_titleLabel release];
    [_headerVImageButton release];
    [_userNameLabel release];
    [_descriptionLabel release];
    [_userBackGroundImageView release];
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
