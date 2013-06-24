//
//  AGLeftSideViewController.m
//  AGShareSDKDemo
//
//  Created by 冯 鸿杰 on 13-1-30.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import "AJMRightSideViewController.h"
#import "AppDelegate.h"
#import "AGLeftSideTableCell.h"
#import <ShareSDK/ShareSDK.h>





#define TABLE_CELL @"tableCell"

@interface AJMRightSideViewController ()

@end

@implementation AJMRightSideViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}

- (void)dealloc
{
    [_myselfHeaderView release];
    [_navigationController release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Custom initialization
     CGRect frame =  CGRectMake(0, 0, 200, 150);
    _myselfHeaderView = [[MyselfHeaderView alloc] initWithFrame:frame];
    [_myselfHeaderView setFrame:frame];
    _myselfHeaderView.titleLabel.text = @"Tom Callon";
    

    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndexBG.png"]];
    bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    
    bgImageView.frame = CGRectMake(0.0, 0.0, self.view.frame
                                   .size.width,     self.view.frame.size.height);
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)
                                              style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.sectionHeaderHeight = 32;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    
    
    [_tableView setTableHeaderView:_myselfHeaderView];
    [_tableView setFrame:CGRectMake(61, 0, 259, 480)];
    
    

    [self.view addSubview:_tableView];
    [_tableView release];
    
    [self.view setFrame:CGRectMake(100, 0, 100, 480)];
    
    
    

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 8;
        case 1:
            return 5;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TABLE_CELL];
    if (cell == nil)
    {
        cell = [[[AGLeftSideTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TABLE_CELL] autorelease];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18.0];
        //       cell.textLabel.textColor = [UIColor colorWithRGB:0xc3c3c2];
        
        cell.textLabel.textColor = [UIColor whiteColor];
        
        
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IndexLine.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        
        CGRect frame = cell.contentView.frame;
        
        lineView.frame = CGRectMake(0.0, frame.size.height - lineView.frame.size.height , cell.contentView.frame.size.width, lineView.frame.size.height);
        
        lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [cell addSubview:lineView];
        [lineView release];
    }
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"锻炼";
                    break;
                case 1:
                    cell.textLabel.text = @"健身计划";
                    break;
                case 2:
                    cell.textLabel.text = @"营养";
                    break;
                case 3:
                    cell.textLabel.text = @"补充";
                    break;
                case 4:
                    cell.textLabel.text = @"生活方式";
                    break;
                case 5:
                    cell.textLabel.text = @"论坛";
                    break;
                case 6:
                    cell.textLabel.text = @"交友互动";
                    break;
                case 7:
                    cell.textLabel.text = @"更多";
                    break;
            }
            break;
        }
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"关注新浪微博";
                    break;
                case 1:
                    cell.textLabel.text = @"关注腾讯微博";
                    break;
                case 2:
                    cell.textLabel.text = @"关注官方微信";
                    break;
                case 3:
                    cell.textLabel.text = @"访问官方网站";
                    break;
                case 4:
                {
                    NSBundle *bundle = [NSBundle mainBundle];
                    cell.textLabel.text = [NSString stringWithFormat:@"版本:ver%@",[[bundle infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]];
                    break;
                }
                default:
                    break;
            }
        }
        default:
            break;
    }
    
//    [cell.textLabel setTextAlignment:NSTextAlignmentRight];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 1:
            return @"关注爱健美";
        default:
            return nil;
    }
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 1:
            return _myselfHeaderView;
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 1:
            return tableView.sectionHeaderHeight;
        default:
            return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    UIStoryboard *currentInUseStoryBoard ;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIStoryboard * iPhoneStroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        
        currentInUseStoryBoard = iPhoneStroyBoard;
        
    }else{
        
        UIStoryboard * iPadStroyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        currentInUseStoryBoard = iPadStroyBoard;
        
    }
    
    
    
    
    switch (indexPath.section)
    {
        case 0:
        {
            self.view.userInteractionEnabled = NO;
            switch (indexPath.row)
            {
                case 0:
                {
                    
                    self.view.userInteractionEnabled = YES;
   
                }
                case 1:
                {
                    self.view.userInteractionEnabled = YES;

                }
                    
                case 2:
                {
                    self.view.userInteractionEnabled = YES;

                    
                }
                case 3:
                {
                    self.view.userInteractionEnabled = YES;

                }
                case 4:
                {
                    self.view.userInteractionEnabled = YES;

                }
                case 5:
                {
                    self.view.userInteractionEnabled = YES;

                }
                case 6:
                {
                    self.view.userInteractionEnabled = YES;

                }
                case 7:
                {
                    self.view.userInteractionEnabled = YES;

                }
                    
                default:
                    break;
            }
            break;
        }
            
            
        case 1:
        {
            
            switch (indexPath.row)
            {
                case 0:
                {
                    self.view.userInteractionEnabled = YES;

                }
                case 1:
                {
                    self.view.userInteractionEnabled = YES;
             
                }
                case 2:
                {
                    self.view.userInteractionEnabled = YES;

                }
                case 3:
                {
                    self.view.userInteractionEnabled = YES;

                   
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

@end
