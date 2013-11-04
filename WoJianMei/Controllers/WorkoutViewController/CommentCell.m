//
//  CommentCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 7/23/13.
//
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "Comment.h"

@implementation CommentCell
@synthesize myImageView =_myImageView;
@synthesize commentLabel =_commentLabel;
@synthesize nameLabel =_nameLabel;
@synthesize commentTimeLabel=_commentTimeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
        self.myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        
        
        
        self.nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 45, 40, 40)];
        [self.nameLabel setBackgroundColor:[UIColor clearColor]];
        [self.nameLabel setFont:[UIFont systemFontOfSize:9]];
        [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
        [self.nameLabel setTextColor:[UIColor grayColor]];

        
        
        self.commentLabel =[[UILabel alloc]initWithFrame:CGRectMake(70, 10, 250, 50)];;
        [self.commentLabel setBackgroundColor:[UIColor clearColor]];
        [self.commentLabel setFont:[UIFont systemFontOfSize:11]];
        [self.commentLabel setTextColor:[UIColor grayColor]];

        self.commentLabel.numberOfLines = 5;

        
        
        self.commentTimeLabel =[[UILabel alloc]initWithFrame:CGRectMake(220, 60, 100, 20)];
        [self.commentTimeLabel setFont:[UIFont systemFontOfSize:10]];
        [self.commentTimeLabel setBackgroundColor:[UIColor clearColor]];
        [self.commentTimeLabel setTextColor:[UIColor grayColor]];


        
        [self addSubview:self.myImageView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.commentLabel];
        [self addSubview:self.commentTimeLabel];

        
    }
    return self;
}

-(void)dealloc {
    [super dealloc];
    [_myImageView release];
    [_commentLabel release];
    [_nameLabel release];
    [_commentTimeLabel release];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (NSString*)getCellIdentifier
{
   static NSString *string = @"CommentCell";
    return  string;
}

+ (CGFloat)getCellHeight
{
    return 80.0f;
}

- (void)setCellInfo:(Comment *)comment{
    
    [self.myImageView setImageWithURL:[NSURL URLWithString:comment.userimg] placeholderImage:[UIImage imageNamed:@"touxiang_40x40.png"] options:SDWebImageCacheMemoryOnly];
    [self.commentLabel setText:comment.content];
    [self.commentTimeLabel setText:[NSString stringWithFormat:@"发表于:%@", comment.timestamp]];
    
    
    if (comment.username == NULL) {
        [comment setUsername:@"用户名"];
    }
   [self.nameLabel setText:comment.username];
    
    
   
 
}

@end
