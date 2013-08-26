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
#import <RestKit/RestKit.h>


@interface NumberDataViewController : PPTableViewController<NumberDataCellFooterDelegate,NumberDataCellHeaderDelegate,NumberDataCellDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate,RKObjectLoaderDelegate>
{
    
    NumberDataCellHeader *_header;
    NumberDataCellFooter *_footer;
    
    UITextField *_currentTextField;
    
}
@property (nonatomic,retain)   NumberDataCellHeader * header;
@property (nonatomic,retain)   NumberDataCellFooter * footer;
@property (nonatomic,retain)   UITextField *currentTextField;



-(void)tap;

@end
