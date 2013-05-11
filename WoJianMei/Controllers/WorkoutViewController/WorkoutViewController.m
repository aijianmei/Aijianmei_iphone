//
//  WorkoutViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 12/29/12.
//
//

#import "WorkoutViewController.h"
#import "VideoListCell.h"

#import "Video.h"
#import "VideoManager.h"
#import "WorkOut.h"


#import "ReflectionView.h"
#import "iCarousel.h"
///// the setings of the iCarousel
#define NUMBER_OF_ITEMS 13
#define NUMBER_OF_VISIBLE_ITEMS 8
#define ITEM_SPACING 220




@interface WorkoutViewController ()

@end

@implementation WorkoutViewController
@synthesize myHeaderView =_myHeaderView;
@synthesize  carousel =_carousel;
@synthesize spacePageControl =_spacePageControl;



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    
    
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
    [_carousel release];
    
    [_spacePageControl release];
    
    [_myHeaderView release];
    [super dealloc];
    
}



-(void)iamTomsGirlfriend{
    
    NSLog(@"I am Tom's girlfriend");
    
}



//// init the userInterface 
-(void)initUI{

    
    
    [self setBackgroundImageName:@"BackGround.png"];
    [self showBackgroundImage];
    
    [self.navigationItem setTitle:@"健身视频"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStyleBordered target:self action:@selector(iamTomsGirlfriend)];
    [bar setTitle:@"每天锻炼"];
    [self.navigationItem setRightBarButtonItem:bar];
    [bar release];
    
    UIBarButtonItem *rightbarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered target:self action:nil];
    [self.navigationItem setLeftBarButtonItem:rightbarButton];
    
    
    
    
    
    //configure carousel


    UIView *headerView =[[UIView alloc]init];
    [headerView setFrame: CGRectMake(0, 0, 320, 140)];
    self.myHeaderView = headerView;
    [headerView release];
    
    
    self.carousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, 320, 140)];
    
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    _carousel.type = iCarouselTypeCylinder;
    
    [self.carousel setCenterItemWhenSelected:YES];
    
    [self.myHeaderView addSubview:_carousel];
   
    
    
    ////The page controll
    self.spacePageControl = [[SMPageControl alloc]initWithFrame:CGRectMake(10, 127, 300, 20)];
    [_spacePageControl setBackgroundColor:[UIColor clearColor]];
    _spacePageControl.numberOfPages = 13;
    [_spacePageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"currentPageDot.png"]];
    [_spacePageControl setPageIndicatorImage:[UIImage imageNamed:@"pageDot"]];
    [_spacePageControl addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventValueChanged];
    [self.myHeaderView addSubview:_spacePageControl];
    
    
    
    
    [self.dataTableView setTableHeaderView:self.myHeaderView];


    
    

}


#pragma mark-- PageControl

- (void)pageControl:(id)sender
{
	NSLog(@"Current Page (UIPageControl) : %i", _spacePageControl.currentPage);
}

- (void)spacePageControl:(SMPageControl *)sender
{
	NSLog(@"Current Page (SMPageControl): %i", sender.currentPage);
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
    [self initUI];
    
    [self initWorkOutDatas];
    
     self.dataList = [[VideoManager defaultManager]  videoList];
    
}


-(void)viewDidUnload{

    [super viewDidUnload];
    self.carousel = nil;

}

#pragma mark ----------------------------------------————————————————
#pragma mark  tableviewDelegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    
    return [dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    NSString *CellIdentifier = [VideoListCell getCellIdentifier];
    VideoListCell *cell = (VideoListCell*)[self.dataTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil) {
        cell  = [[[VideoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    //    cell.indexPath = indexPath;
    Video *video  = [dataList objectAtIndex:indexPath.row];
    if (video) {
        [cell setCellInfo:video];
    }
    
//
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isPad) {
        return 210.f;
    }
    return  [VideoListCell getCellHeight];
}

-(void)initWorkOutDatas{
    
    //    Upper Area
    //    Trapezius ( neck ) >
    //    Deltoid ( shoulders ) >
    //    Biceps ( arms ) >
    //    Triceps ( arms ) >
    //    Forearm ( wrists ) >
    
    //////Upper Area
    WorkOut *workOut =[[WorkOut alloc]init];
    workOut.workOutTimeLength = @"40minutes";
    workOut.repeatTimes = @"7 -12 次";
    workOut.sets = @"6-7组";
    Video *video1 = [[Video alloc]initWithId:@"1"
                                       title:@"Neck_exercises_s"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"neck_exercises_s.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video2 = [[Video alloc]initWithId:@"2"
                                       title:@"Shoulder-Exercises"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"Shoulder-Exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    
    Video *video3 = [[Video alloc]initWithId:@"3"
                                       title:@"Biceps-Exercises"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"Biceps-Exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video4 = [[Video alloc]initWithId:@"4"
                                       title:@"Triceps-Exercises"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"Triceps-Exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video5 = [[Video alloc]initWithId:@"5"
                                       title:@"Forearm-exercises"
                                   timeLeght:@"30minutes"
                                       image:[UIImage imageNamed:@"forearm-exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    //////Middle  Area
        
    
    
    Video *video6 = [[Video alloc]initWithId:@"6"
                                       title:@"Chest-Exercises_s"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"Chest-Exercises_s.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video7 = [[Video alloc]initWithId:@"7"
                                       title:@"Abs-Exercises_s"
                                   timeLeght:@"20minutes"
                                       image:[UIImage imageNamed:@"Abs-Exercises_s.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video8 = [[Video alloc]initWithId:@"8"
                                       title:@"Oblique-abdominal-exercises"
                                   timeLeght:@"30minutes"
                                       image:[UIImage imageNamed:@"Oblique-abdominal-exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video9 = [[Video alloc]initWithId:@"9"
                                       title:@"ack-Exercises"
                                   timeLeght:@"40minutes"
                                       image:[UIImage imageNamed:@"Back-Exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut];
    Video *video10 = [[Video alloc]initWithId:@"10"
                                        title:@"Lower-Back-Exercises"
                                    timeLeght:@"50minutes"
                                        image:[UIImage imageNamed:@"Lower-Back-Exercises.jpg"]
                                     isFollow:NO
                                      workOut:workOut ];
    
    
    
    //    Lower Area
    //    Gluteus ( buttocks ) >
    //    Adductor ( internal thigh ) >
    //    Quadriceps ( legs ) >
    //    Femoral ( hamstring ) >
    //    Calf ( ankles )
    
    
    Video *video11= [[Video alloc]initWithId:@"11"
                                       title:@"buttocks-exercises"
                                   timeLeght:@"12minutes"
                                       image:[UIImage imageNamed:@"buttocks-exercises.jpg"]
                                    isFollow:NO
                                     workOut:workOut ];
    Video *video12 = [[Video alloc]initWithId:@"12"
                                        title:@"adductor-exercises"
                                    timeLeght:@"34minutes"
                                        image:[UIImage imageNamed:@"adductor-exercises.jpg"]
                                     isFollow:NO
                                      workOut:workOut ];
    Video *video13 = [[Video alloc]initWithId:@"13"
                                        title:@"Quadriceps-exercises"
                                    timeLeght:@"45minutes"
                                        image:[UIImage imageNamed:@"quadriceps-exercises.jpg"]
                                     isFollow:NO
                                      workOut:workOut ];
    Video *video14 = [[Video alloc]initWithId:@"14"
                                        title:@"Hamstring-exercises"
                                    timeLeght:@"40minutes"
                                        image:[UIImage imageNamed:@"hamstring-exercises.jpg"]
                                     isFollow:NO
                                      workOut:workOut ];
    Video *video15 = [[Video alloc]initWithId:@"15"
                                        title:@"Calf-exercises"
                                    timeLeght:@"40minutes"
                                        image:[UIImage imageNamed:@"calf-exercises.jpg"]
                                     isFollow:NO
                                      workOut:workOut ];
    
    [workOut release];
    
    
    
    VideoManager *mangager =[VideoManager defaultManager];
    [mangager addVideo:video1];
    [mangager addVideo:video2];
    [mangager addVideo:video3];
    [mangager addVideo:video4];
    [mangager addVideo:video5];
    [mangager addVideo:video6];
    [mangager addVideo:video7];
    [mangager addVideo:video8];
    [mangager addVideo:video9];
    [mangager addVideo:video10];
    [mangager addVideo:video11];
    [mangager addVideo:video12];
    [mangager addVideo:video13];
    [mangager addVideo:video14];
    [mangager addVideo:video15];
    
    [video1 release];
    [video2 release];
    [video3 release];
    [video4 release];
    [video5 release];
    [video6 release];
    [video7 release];
    [video8 release];
    [video9 release];
    [video10 release];
    [video11 release];
    [video12 release];
    [video13 release];
    [video14 release];
    [video15 release];
    
    
    for (int i =0; i <[mangager.followVideoList  count]; i++) {
        ///get all the follow videos
        Video *video =[[mangager getAllFollowVideo] objectAtIndex:i];
        if (video.isFollow) {
            Video *notFollowVideo =[mangager getVideoById:video.videoId];
            notFollowVideo.isFollow =[NSNumber  numberWithBool:YES];
            NSLog(@"%d",[video.isFollow intValue]);
            NSLog(@"%d",[video.isFollow intValue]);
        }
    }
    
    
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
	UILabel *backgroudLabel = nil;
	
	//create new view if no view is available for recycling
	if (view == nil)
	{
        //set up reflection view
		view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 130.0f)] autorelease];
        
        //set up content
		backgroudLabel = [[[UILabel alloc] initWithFrame:view.bounds] autorelease];
		backgroudLabel.backgroundColor = [UIColor lightGrayColor];
		backgroudLabel.layer.borderColor = [UIColor whiteColor].CGColor;
        backgroudLabel.layer.borderWidth = 4.0f;
        backgroudLabel.layer.cornerRadius = 8.0f;
        backgroudLabel.textAlignment = UITextAlignmentCenter;
		backgroudLabel.font = [backgroudLabel.font fontWithSize:50];
        

        [view addSubview:backgroudLabel];

    ///add images
    NSString *imageName = [NSString stringWithFormat:@"%d",index +1];
    UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        
        
    [backgroudLabel addSubview: imageView];
    [imageView release];
     
        
    ///add subtitles to each image
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,100, 200, 30)];
    NSString *string  =[NSString stringWithFormat:@"%d",index];
    [label setText:string];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    label.backgroundColor = [UIColor blueColor];
    [imageView addSubview:label];
    [label release];
        
      
        
        
	}
	else
	{
		backgroudLabel = [[view subviews] lastObject];
	}
	
    //set label
	backgroudLabel.text = [NSString stringWithFormat:@"%@", @"adfsafasfasdfasdf"];
    
    //update reflection
    //this step is expensive, so if you don't need
    //unique reflections for each item, don't do this
    //and you'll get much smoother peformance
    
    /// When it is the reflecttion view we need to implement this method.
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
    
    [self.spacePageControl setCurrentPage:[carousel currentItemIndex]];
    
}





@end
