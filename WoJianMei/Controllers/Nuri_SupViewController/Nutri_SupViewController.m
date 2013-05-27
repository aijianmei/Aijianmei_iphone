//
//  HealthFoodViewController.m
//  WoJianMei
//
//  Created by Tom Callon on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Nutri_SupViewController.h"
#import "NutritionDetailCell.h"
#import "NutritionInfo.h"
#import "iCarousel.h"
///// the setings of the iCarousel
#define NUMBER_OF_ITEMS 13
#define NUMBER_OF_VISIBLE_ITEMS 18
#define ITEM_SPACING 220




#define SCROLL_VIEW_TAG 20120913

@interface Nutri_SupViewController ()

@end

@implementation Nutri_SupViewController
@synthesize buttonScrollView =_buttonScrollView;



-(void)dealloc{
    
    
    
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
    [_carousel release];
    [_myHeaderView release];
    [_buttonScrollView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self initUI];
    [self initDatas];
}


-(void)buttonClicked:(id)sender{

    NSLog(@"i click the button :%@",[sender description]);
}
-(void)viewWillAppear:(BOOL)animated{
  
    [super viewWillAppear:YES];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    self.buttonScrollView = nil;
    
}


#pragma mark -
#pragma mark UITableView Delegate Methods
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
    [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"table_header_bg@2x.png"]]];
    
    [cell setCellInfo:nutrition];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  [NutritionDetailCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   //TODO
}


#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return NUMBER_OF_ITEMS;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //if you have less than around 30 items in the carousel
    //you'll get better performance if NUMBER_OF_VISIBLE_ITEMS >= NUMBER_OF_ITEMS
    //because then the item view reflections won't have to be re-generated as
    //the carousel is scrolling
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	UILabel *label = nil;
	
	//create new view if no view is available for recycling
	if (view == nil)
	{
        //set up reflection view
		view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 130.0f)] autorelease];
        
        //set up content
		label = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
		label.backgroundColor = [UIColor lightGrayColor];
		label.layer.borderColor = [UIColor whiteColor].CGColor;
        label.layer.borderWidth = 4.0f;
        label.layer.cornerRadius = 8.0f;
        label.textAlignment = UITextAlignmentCenter;
		label.font = [label.font fontWithSize:50];
        
        
        [view addSubview:label];
        
        ///add images
        NSString *imageName = [NSString stringWithFormat:@"%d",index +1];
        UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        [label addSubview: imageView];
        [imageView release];
        
        
        
	}
	else
	{
		label = [[view subviews] lastObject];
	}
	
    //set label
	label.text = [NSString stringWithFormat:@"%@", @"adfsafasfasdfasdf"];
    
    //update reflection
    //this step is expensive, so if you don't need
    //unique reflections for each item, don't do this
    //and you'll get much smoother peformance
    //    [view update];
    
    
	
	return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    
    
    PPDebug(@"I did selected the picture of %d",index);
    
}

-(void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel{
    
    
    
    PPDebug(@"%d",[carousel currentItemIndex]);
    
}


#pragma mark -
#pragma mark  InitDatas Methods

-(void)initDatas{
    
    NutritionInfo *nutrition1 = [[NutritionInfo alloc]initWithNutritionId:
                                 @"1" nutritionTitle:@"下午茶喝一杯咖啡 瘦身又抵饿"imageName:@"1.jpg" creatdDate:@"2012年9月13日" clickedNumber:@"243" commentsNumber:@"23"];
    
    NutritionInfo *nutrition2 = [[NutritionInfo alloc]initWithNutritionId:
                                 @"2" nutritionTitle:@"鱼鳞可预防骨质疏松防衰老"imageName:@"2.jpg" creatdDate:@"2012年3月13日" clickedNumber:@"2753" commentsNumber:@"23" ];
    NutritionInfo *nutrition3 = [[NutritionInfo alloc]initWithNutritionId:
                                 @"3" nutritionTitle:@"辣辣更健康 六种日常调味品吃出美丽"imageName:@"3.jpg" creatdDate:@"2012年2月13日" clickedNumber:@"23" commentsNumber:@"23"];
    NutritionInfo *nutrition4 = [[NutritionInfo alloc]initWithNutritionId:
                                 @"4" nutritionTitle:@"营养不良的严重危害"imageName:@"4.jpg" creatdDate:@"2012年1月13日" clickedNumber:@"233" commentsNumber:@"23"];
    NutritionInfo *nutrition5 = [[NutritionInfo alloc]initWithNutritionId:
                                 @"5" nutritionTitle:@"煮鸡蛋 营养吸收百分百"imageName:@"5.jpg" creatdDate:@"2012年4月13日" clickedNumber:@"233" commentsNumber:@"23"];
    NutritionInfo *nutrition6 = [[NutritionInfo alloc]initWithNutritionId:
                                 @"6" nutritionTitle:@"排毒养颜 越吃越美丽"imageName:@"6.jpg" creatdDate:@"2012年6月3日" clickedNumber:@"3323" commentsNumber:@"23"];
    
    
    
    NSArray *array = [[NSArray alloc] initWithObjects:nutrition1,nutrition2,nutrition3,nutrition4,nutrition5,nutrition6, nil];
    
    [nutrition1 release];
    [nutrition2 release];
    [nutrition3 release];
    [nutrition4 release];
    [nutrition5 release];
    [nutrition6 release];
    
    
    self.dataList = array;
    [array release];
    
    
    
}

#pragma mark -
#pragma mark  initUI  Methods

-(void)initUI{
    
    
//    [self.navigationItem setTitle:@"营养与补充"];

    
    
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
    

    
    //configure carousel
    UIView *headerView =[[UIView alloc]init];
    [headerView setFrame: CGRectMake(0, 0, 320, 140)];
    self.myHeaderView = headerView;
    [headerView release];
    
    
    self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, 320, 140)];
    
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    _carousel.type = iCarouselTypeCylinder;
    
    [self.myHeaderView addSubview:_carousel];
    [self.dataTableView setTableHeaderView:self.myHeaderView];
    
    
    [self setBackgroundImageName:@"BackGround.png"];
    [self showBackgroundImage];
    
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
