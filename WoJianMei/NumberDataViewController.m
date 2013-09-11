//
//  NumberDataViewController.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import "NumberDataViewController.h"
#import "NumberDataCell.h"
#import "NumberData.h"
#import "NumberDataManager.h"
#import "WorkoutDataService.h"
#import "UserService.h"
#import "NumberData.h"


@interface NumberDataViewController ()
@property (nonatomic, retain) NSIndexPath *selectedIndexPath;


@end

@implementation NumberDataViewController
@synthesize header =_header;
@synthesize footer = _footer;
@synthesize currentTextField =_currentTextField;
@synthesize selectedCatalog =_selectedCatalog;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize numberDataInfo =_numberDataInfo;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




-(void)dealloc {
    [_header release];
    [_footer release];
    [_currentTextField release];
    [_selectedCatalog release];
    [_numberDataInfo release];
    [super dealloc];
}


- (void)viewDidUnLoad{
    [self setFooter:nil];
    [self setHeader:nil];
    [super viewDidUnload];
}



-(void)tap{
    
    TPKeyboardAvoidingTableView *tableView =  (TPKeyboardAvoidingTableView *)self.dataTableView;
    [tableView  hideKeyboard];
    //重新计算平均值
    [[NumberDataManager defaultManager] countAvgOfTheData];
    [self updateFooterAndHeader];
}



-(void)updateFooterAndHeader{

    //header
    
    //获得系统时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    //    [dateformatter setDateFormat:@"HH:mm"];
    //    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    //    [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    NSString *  morelocationString=[dateformatter stringFromDate:senddate];
    
    NSString *timeAndName = [NSString stringWithFormat:@"%@\n%@",_selectedCatalog.name,morelocationString];
    
    [self.header.nameButton setTitle:timeAndName forState:UIControlStateNormal];
    [self.header.weightButton setTitle:@"重量(kg)" forState: UIControlStateNormal];
    [self.header.numberButton setTitle:@"数量" forState: UIControlStateNormal];
    [self.header.timeButton setTitle:@"时间(s)" forState: UIControlStateNormal];
    [self.header.caloriesButton setTitle:@"卡路里" forState: UIControlStateNormal];

    
    
    [[NumberDataManager defaultManager] countAvgOfTheData];
    
    //footer 
    //renew the average value locally
    [self.footer.averageButton setTitle:@"平均值" forState:UIControlStateNormal];
    [self.footer.numberButton setTitle:[[NumberDataManager defaultManager] numAvg] forState:UIControlStateNormal];
    [self.footer.weightButton setTitle:[[NumberDataManager defaultManager] weightAvg] forState:UIControlStateNormal];
    [self.footer.timeButton setTitle:[[NumberDataManager defaultManager] timeAvg] forState:UIControlStateNormal];
    [self.footer.caloriesButton setTitle:[[NumberDataManager defaultManager] caloriesAvg] forState:UIControlStateNormal];

}


#pragma --mark
#pragma -- NumberDataCellHeaderDelegate Method

- (void)didClickHeaderButton:(UIButton *)button atIndex:(int)buttonIndex{
    
    ZSYPopoverListView *listView = [[ZSYPopoverListView alloc] initWithFrame:CGRectMake(0,0,200,120)];
    listView.titleName.text = @"组数选择";
    listView.datasource = self;
    listView.delegate = self;
    
    
//    [listView setCancelButtonTitle:@"Cancel" block:^{
//            NSLog(@"cancel");
//        }];
//    [listView setDoneButtonWithTitle:@"OK" block:^{
//            NSLog(@"Ok%d", [listView indexPathForSelectedRow].row);
//        }];
    [listView show];
    [listView release];

}

#pragma --mark
#pragma -- NumberDataCellHeaderDelegate Method

- (void)didClickFooterAddButton:(UIButton *)button atIndex:(int)buttonIndex{
    [self addGroupByCurrentGroupNumber];
}

- (void)didClickFooterDeleteButton:(UIButton *)button atIndex:(int)buttonIndex{
    [self deleteGroupByCurrentGroupNumber];
}


#pragma mark -
- (NSInteger)popoverListView:(ZSYPopoverListView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)popoverListView:(ZSYPopoverListView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusablePopoverCellWithIdentifier:identifier];
    
    [cell setSelected:NO];
    if (nil == cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    if ( self.selectedIndexPath && NSOrderedSame == [self.selectedIndexPath compare:indexPath])
    {
        cell.imageView.image = [UIImage imageNamed:@"fs_main_login_selected.png"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"fs_main_login_normal.png"];
    }
    
    if (indexPath.row ==0) {
        cell.textLabel.text = [NSString stringWithFormat:@"添加一组数据"];

    }
    if (indexPath.row ==1) {
        cell.textLabel.text = [NSString stringWithFormat:@"删除组数据"];
    }
    
    return cell;
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"fs_main_login_normal.png"];
    NSLog(@"deselect:%d", indexPath.row);
}

- (void)popoverListView:(ZSYPopoverListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    UITableViewCell *cell = [tableView popoverCellForRowAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"fs_main_login_selected.png"];
    NSLog(@"select:%d", indexPath.row);
    

    if (indexPath.row ==0) {
        [self addGroupByCurrentGroupNumber];
    }
    
    if (indexPath.row ==1) {
        [self deleteGroupByCurrentGroupNumber];
    }
}


-(void)addGroupByCurrentGroupNumber{

    
    int currentGroupCount =  [[[NumberDataManager defaultManager] dataList] count];
    
    if (currentGroupCount >=7) {
        [self popupHappyMessage:@"亲，最多能够添加7组数据" title:nil];
        return;
    }
    
    [[NumberDataManager defaultManager] addNumberDataWithId:@"0" name:@"" number:@"0" weight:@"0" time:@"0" calories:@"0"];
    self.dataList = [[NumberDataManager defaultManager] dataList];
    [self.dataTableView reloadData];
    
    //往服务器,保存数据
    [self postDataArray];

}
-(void)deleteGroupByCurrentGroupNumber {
    
    int currentGroupCount =  [[[NumberDataManager defaultManager] dataList] count];
    
    if (currentGroupCount <=1) {
        [self popupHappyMessage:@"亲,不能删除最后的一组数据" title:nil];
        return;
    }

    [[NumberDataManager defaultManager].dataList removeLastObject];
    self.dataList = [[NumberDataManager defaultManager] dataList];
    [self.dataTableView reloadData];
    
    //往服务器,保存数据
    [self postDataArray];
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    
    [self setNavigationLeftButton:@"" imageName:@"top_bar_backButton.png"  action:@selector(clickBack:)];

    
    
    //轻触手势（单击）
    UITapGestureRecognizer *tapCgr=nil;
    tapCgr=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                  action:@selector(tap)];
    tapCgr.numberOfTapsRequired=1;
    [self.dataTableView addGestureRecognizer:tapCgr];
    [tapCgr release];

    
    

    self.header = [NumberDataCellHeader
                   createHeaderWithName:_selectedCatalog.name
                                                         weight:@"90"
                                                         number:@"34"
                                                           time:@"43"
                                                       calories:@"43"
                                                       delegate:self];
    
    [self.header setBackgroundColor:[UIColor clearColor]];
    
    self.footer = [NumberDataCellFooter createFooterWithAverage:@"平均值"
                                                         weight:@"90"
                                                         number:@"34"
                                                           time:@"43"
                                                       calories:@"43"
                                                       delegate:self];
    [self.footer setBackgroundColor:[UIColor clearColor]];

    
    
    [self.dataTableView setTableHeaderView:_header];
    [self.dataTableView setTableFooterView:_footer];



    self.dataList = [[NumberDataManager defaultManager] dataList];
    
    [self.dataTableView setContentOffset:CGPointMake(0, 190)];
    
    
    

}

-(void)postDataArray{
    
    User *user =[[UserService defaultService] user];
    [[WorkoutDataService sharedService]  postUserWorkoutDataWithUserId:user.uid workoutId:self.selectedCatalog._id delegate:self];
    
    [self showActivityWithText:@"正在保存..."];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  [NumberDataCell getCellHeight];
}

#pragma mark --
#pragma mark  tableviewDelegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NumberDataCell getCellIdentifier];
	NumberDataCell *cell = (NumberDataCell*)[self.dataTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
	if (cell == nil) {
		cell = [NumberDataCell createCell:self];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    
    cell.indexPath = indexPath;
    NumberData *numberData  = [self.dataList objectAtIndex:indexPath.row];
    
    if (numberData) {
        [cell setCellInfo:numberData];
    }

    return cell;
    

}


//当用户点击了cell中的textfield 就对应修改其值；
-(void)didClickCellTextField:(UITextField *)textField
                     atIndex:(NSIndexPath *)indexPath{
    
    //行
    int row =indexPath.row + 1;
    //列
    int column =textField.tag + 1;
    
    PPDebug(@"###第%d行###,###第%d列###,###数值:%@####",row,column,textField.text);
        
    switch (row) {
        //第一行
        case 1:
        {
        [self setDataByRow:row coloum:column textField:textField];
        }
            break;
        //第二行
        case 2:
        {
            [self setDataByRow:row coloum:column textField:textField];
        }
            break;
        case 3:
        {
            [self setDataByRow:row coloum:column textField:textField];

            
        }
            break;
        case 4:
        {
            [self setDataByRow:row coloum:column textField:textField];

        }
            break;
        case 5:
        {
            [self setDataByRow:row coloum:column textField:textField];

        }
            break;
        case 6:
        {
            [self setDataByRow:row coloum:column textField:textField];

        }
            break;
        case 7:
        {
            [self setDataByRow:row coloum:column textField:textField];

        }
            break;
        default:
            break;
    }
}

-(void)setDataByRow:(int)row
             coloum:(int)coloumn
          textField:(UITextField*)textField{

    NSString *rowString = [NSString stringWithFormat:@"%i",row];

    NumberData *data = [[NumberDataManager defaultManager] getNumberDataById:rowString];
    
    switch (coloumn) {
        case 1:
        {
            [data setNumber:textField.text];
            PPDebug(@"number :%@",data.number);

        }
            break;
        case 2:
        {
            [data setWeight:textField.text];
            PPDebug(@"weight :%@",data.weight);

        }
            break;
            
        case 3:
        {
            [data setTime:textField.text];
            PPDebug(@"time :%@",data.time);

        }
            break;
        default:
            break;
    }
}

#pragma --mark
#pragma --UIScrollViewDelegate Method
//当UIScrollView 变化的时候要隐藏键盘,方便用户使用;
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    TPKeyboardAvoidingTableView *tableView =  (TPKeyboardAvoidingTableView *)scrollView;
    [tableView  hideKeyboard];
    

}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{  // called on finger up as we are moving
    
    TPKeyboardAvoidingTableView *tableView =  (TPKeyboardAvoidingTableView *)scrollView;
    [tableView  hideKeyboard];
    

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{     // called when scroll view grinds to a halt
    
    TPKeyboardAvoidingTableView *tableView =  (TPKeyboardAvoidingTableView *)scrollView;
    [tableView  hideKeyboard];
    
    [self postDataArray];

}



  

-(void)loadloadDatasFromSever

{
    //初始化数据
    [[NumberDataManager defaultManager] addNumberDataWithId:@"0" name:@"腹肌" number:@"0" weight:@"0" time:@"0" calories:@"0"];
}


#pragma mark -
#pragma mark - RKObjectLoaderDelegate
- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    NSLog(@"Response code: %d", [response statusCode]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)requestDidStartLoad:(RKRequest *)request
{
    NSLog(@"Start load request...");
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    NSLog(@"***Load objects count: %d", [objects count]);
    [self hideActivity];
    [self popupHappyMessage:@"保存数据成功！" title:nil];
    
    
    
    
    
    //footer
    //renew the average value locally
    [[NumberDataManager defaultManager] countAvgOfTheData];
    [self updateFooterAndHeader];
}

@end
