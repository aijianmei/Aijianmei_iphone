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


@interface NumberDataViewController ()

@end

@implementation NumberDataViewController
@synthesize header =_header;
@synthesize footer = _footer;
@synthesize currentTextField =_currentTextField;


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
    [super dealloc];
}


- (void)viewDidUnLoad{
    [self setFooter:nil];
    [self setHeader:nil];
    [super viewDidUnload];
}



-(void)tap{
    
     BOOL  yes = [self.currentTextField  resignFirstResponder];
    
    if (yes) {
        PPDebug(@"dsds");
    }
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    [self setBackgroundImageName:@"gobal_background.png"];
    [self showBackgroundImage];
    

    
    
    //轻触手势（单击）
    UITapGestureRecognizer *tapCgr=nil;
    tapCgr=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                  action:@selector(tap)];
    tapCgr.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tapCgr];
    [tapCgr release];

    
    

    self.header = [NumberDataCellHeader
                   createHeaderWithName:@"名称"
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

    
    
    
    

    [self loadloadDatasFromSever];
    
    
    self.dataList = [[NumberDataManager defaultManager] dataList];
    
    
        
    [self.dataTableView setContentOffset:CGPointMake(0, 190)];

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

    NSString *rowString = [NSString stringWithFormat:@"%i",row -1];
    NumberData *data = [[NumberDataManager defaultManager] getNumberDataById:rowString];
    
    switch (coloumn) {
        case 1:
        {
            [data setNumber:textField.text];
        }
            break;
        case 2:
        {
            [data setWeight:textField.text];
        }
            break;
            
        case 3:
        {
            [data setTime:textField.text];
        }
            break;
        default:
            break;
    }
    
    PPDebug(@"number :%@",data.number);
    PPDebug(@"weight :%@",data.weight);
    PPDebug(@"time :%@",data.time);

    
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
}


-(void)loadloadDatasFromSever

{
    //初始化数据
    [[NumberDataManager defaultManager] addNumberDataWithId:@"0" name:@"腹肌" number:@"0" weight:@"0" time:@"0" calories:@"0"];
    
    [[NumberDataManager defaultManager] addNumberDataWithId:@"0" name:@"腹肌" number:@"0" weight:@"0" time:@"0" calories:@"0"];

    [[NumberDataManager defaultManager] addNumberDataWithId:@"0" name:@"腹肌" number:@"0" weight:@"0" time:@"0" calories:@"0"];

    [[NumberDataManager defaultManager] addNumberDataWithId:@"0" name:@"腹肌" number:@"0" weight:@"0" time:@"0" calories:@"0"];

    [[NumberDataManager defaultManager] addNumberDataWithId:@"0" name:@"腹肌" number:@"0" weight:@"0" time:@"0" calories:@"0"];

    [[NumberDataManager defaultManager] addNumberDataWithId:@"0" name:@"腹肌" number:@"0" weight:@"0" time:@"0" calories:@"0"];

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
    
}










@end
