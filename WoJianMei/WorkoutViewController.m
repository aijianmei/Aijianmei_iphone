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



@interface WorkoutViewController ()

@end

@implementation WorkoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
        
//    UIViewController *nv =[self.navigationController topViewController];
//    [nv.navigationController.navigationBar setUserInteractionEnabled:YES];
//    
//    [nv.navigationItem setTitle:@"健身视频"];
//    [nv.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bottom_bg.png"] forBarMetrics:UIBarMetricsDefault];
//    
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStyleBordered target:self action:nil];
//    [bar setTitle:@"碧珍"];
//    [nv.navigationItem setRightBarButtonItem:bar];
//    
//    [bar setAction:@selector(iamTomsGirlfriend)];
    
    
//    UIBarButtonItem *rightbarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered target:self action:nil];
//    [nv.navigationItem setLeftBarButtonItem:rightbarButton];
    
    
    
    [self initWorkOutDatas];
    
     self.dataList = [[VideoManager defaultManager]  videoList];
    
    
    [self setBackgroundImageName:@"BackGround.png"];
    [self showBackgroundImage];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark ----------------------------------------————————————————
#pragma mark  tableviewDelegate Method

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
{
    
 
    
    return @"hello";
    
}


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
    //    Pectoral ( chest ) >
    //    Abs ( abdomen ) >
    //    Oblique Abs ( lateral abdomen ) >
    //    Dorsal ( back ) >
    //    Lumbar ( lower back ) >
    
    
    
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




@end
