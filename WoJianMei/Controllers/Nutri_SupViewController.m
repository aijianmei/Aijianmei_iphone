//
//  HealthFoodViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Nutri_SupViewController.h"
#import "NutritionDetailCell.h"

#import "BookController.h"
#import "NutritionInfo.h"


#define SCROLL_VIEW_TAG 20120913

@interface Nutri_SupViewController ()

@end

@implementation Nutri_SupViewController
@synthesize buttonScrollView =_buttonScrollView;



-(void)dealloc{

    [_buttonScrollView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forBarMetrics:UIBarMetricsDefault];
//
//    NSString *contentPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"];
//	NSString *txtContent = [NSString stringWithContentsOfFile:contentPath encoding:NSUTF8StringEncoding error:nil];
    

    NutritionInfo *nutrition1 = [[NutritionInfo alloc]initWithNutritionId:
                                @"1" nutritionTitle:@"下午茶喝一杯咖啡 瘦身又抵饿"imageName:@"1.jpg" creatdDate:@"2012年9月13日" clickedNumber:@"243"];
    
    NutritionInfo *nutrition2 = [[NutritionInfo alloc]initWithNutritionId:
                                @"2" nutritionTitle:@"鱼鳞可预防骨质疏松防衰老"imageName:@"2.jpg" creatdDate:@"2012年3月13日" clickedNumber:@"2753"];
    NutritionInfo *nutrition3 = [[NutritionInfo alloc]initWithNutritionId:
                                @"3" nutritionTitle:@"辣辣更健康 六种日常调味品吃出美丽"imageName:@"3.jpg" creatdDate:@"2012年2月13日" clickedNumber:@"23"];
    NutritionInfo *nutrition4 = [[NutritionInfo alloc]initWithNutritionId:
                                @"4" nutritionTitle:@"营养不良的严重危害"imageName:@"4.jpg" creatdDate:@"2012年1月13日" clickedNumber:@"233"];
    NutritionInfo *nutrition5 = [[NutritionInfo alloc]initWithNutritionId:
                                @"5" nutritionTitle:@"煮鸡蛋 营养吸收百分百"imageName:@"5.jpg" creatdDate:@"2012年4月13日" clickedNumber:@"233"];
    NutritionInfo *nutrition6 = [[NutritionInfo alloc]initWithNutritionId:
                                @"6" nutritionTitle:@"排毒养颜 越吃越美丽"imageName:@"6.jpg" creatdDate:@"2012年6月3日" clickedNumber:@"3323"];
    
    
    
    NSArray *array = [[NSArray alloc] initWithObjects:nutrition1,nutrition2,nutrition3,nutrition4,nutrition5,nutrition6, nil];
    
    [nutrition1 release];
    [nutrition2 release];
    [nutrition3 release];
    [nutrition4 release];
    [nutrition5 release];
    [nutrition6 release];

    
    self.dataList = array;
    [array release];
    
    
    
    NSMutableArray *buttonArrays  =[[NSMutableArray alloc]init];
    NSArray *buttonTitleArray =[NSArray arrayWithObjects:@"最近更新",@"最热门",@"健身",@"瑜伽",@"增肌",@"减肥",@"瘦身",@"健美操",@"其它", nil];
    
    for (NSString *buttonTitle in buttonTitleArray) {
        
        UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(30, 0, 70, 30)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        [button setBackgroundImage:[UIImage imageNamed:@"set.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"set2.png"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:buttonTitle forState:UIControlStateNormal];

        [buttonArrays addObject:button];
        
        [button release];
        

    }
    

    UIScrollView *scrollView = [PPViewController createButtonScrollViewByButtonArray:buttonArrays buttonsPerLine:[buttonArrays count] buttonSeparatorY:-1];
    self.buttonScrollView =scrollView;
    [scrollView release];
    [buttonArrays release];


    
    
    float buttonHeight = 30;
    float buttonWidth = 70;
//    float buttonSeparatorY = 3;
    


    [[self.view viewWithTag:SCROLL_VIEW_TAG] removeFromSuperview];
     self.buttonScrollView.tag = SCROLL_VIEW_TAG;
    [self.buttonScrollView setFrame:CGRectMake(0,10, 1220, 30)];
    
    [self.buttonScrollView setContentSize:CGSizeMake([buttonArrays count] * buttonWidth * 2.6, buttonHeight)];
    
    [self.buttonScrollView setShowsHorizontalScrollIndicator:YES];
    [self.view addSubview:self.buttonScrollView];
    
    [self setBackgroundImageName:@"Default@2x.png"];
    [self showBackgroundImage];

}


-(void)buttonClicked:(id)sender{

    NSLog(@"i click the button :%@",[sender description]);
}
-(void)viewWillAppear:(BOOL)animated{
  
    [super viewWillAppear:YES];
    
    UIViewController *nv =[self.navigationController topViewController];
    [nv.navigationItem setTitle:@"营养与补充"];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonItemStylePlain target:self action:nil];
//    [bar setBackgroundImage:nil forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [nv.navigationItem setLeftBarButtonItem:nil];
    [nv.navigationItem setRightBarButtonItem:bar];
    
    

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.buttonScrollView = nil;
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NutritionCell";
    NutritionDetailCell *cell = (NutritionDetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
 
    NutritionInfo *nutrition = [dataList objectAtIndex:indexPath.row];
    [cell setCellInfo:nutrition];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  [NutritionDetailCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookController *bc = [[BookController alloc] init];
    [self.navigationController pushViewController:bc animated:YES];
    [bc release];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
