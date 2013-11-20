//
//  NumberDataViewController.h
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import <UIKit/UIKit.h>
#import "PPTableViewController.h"
#import "NumberDataCellFooter.h"
#import "NumberDataCellHeader.h"
#import "NumberDataCell.h"
#import "TPKeyboardAvoidingTableView.h"
#import "UserCatalog.h"
#import "ZSYPopoverListView.h"
#import "NumberData.h"

@interface NumberDataViewController : PPTableViewController<NumberDataCellFooterDelegate,NumberDataCellHeaderDelegate,NumberDataCellDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,ZSYPopoverListDatasource, ZSYPopoverListDelegate>
{
    
    NumberDataCellHeader *_header;
    NumberDataCellFooter *_footer;
    
    UITextField *_currentTextField;
    Catalog     * _selectedCatalog;
    NumberDataInfo *_numberDataInfo;
    
    
}
@property (nonatomic,retain)   NumberDataCellHeader * header;
@property (nonatomic,retain)   NumberDataCellFooter * footer;
@property (nonatomic,retain)   UITextField *currentTextField;
@property  (nonatomic,retain)  Catalog  * selectedCatalog;
@property  (nonatomic,retain)  NumberDataInfo *numberDataInfo;




-(void)tap;
-(void)updateFooterAndHeader;

@end
