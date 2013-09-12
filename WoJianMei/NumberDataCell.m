//
//  NumberDataCell.m
//  WoJianMei
//
//  Created by Tom Callon  on 8/19/13.
//
//

#import "NumberDataCell.h"
#import "NumberData.h"
#import "PPDebug.h"

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)




@implementation NumberDataCell
@synthesize caloriesLabel =_caloriesLabel;
@synthesize groupNumber =_groupNumber;
@synthesize timeField = _timeField;
@synthesize weightField =_weightField;
@synthesize numberField =_numberField;





- (void)dealloc {
    [_caloriesLabel release];
    [_groupNumber release];
    [_timeField release];
    [_weightField release];
    [_numberField release];
    [super dealloc];
}

- (void)setCellStyle
{
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

- (void)awakeFromNib{
    [self setCellStyle];
}


// just replace ProductDetailCell by the new Cell Class Name
+ (NumberDataCell*) createCell:(id)delegate
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NumberDataCell" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <NumberDataCell> but cannot find cell object from Nib");
        return nil;
    }

    ((NumberDataCell*)[topLevelObjects objectAtIndex:0]).delegate = delegate;
    return (NumberDataCell*)[topLevelObjects objectAtIndex:0];
    
}

+ (NSString*)getCellIdentifier
{
    return @"NumberDataCell";
}

+ (CGFloat)getCellHeight
{
    if (isPad) {
        return 210.f;
    }
    
    
    return 37.f;
}

- (void)setCellInfo:(NumberData *)numberData
{
    NSInteger count = indexPath.row + 1 ;
    NSString *group = [NSString stringWithFormat:@"第%d组",count];
    
    [_groupNumber setText:group];
    
    [_numberField setText:numberData.number];
    [_numberField addTarget:self action:@selector(didClickTextField:) forControlEvents:UIControlEventEditingDidEnd];
    
    [_weightField setText:numberData.weight];
    [_weightField addTarget:self action:@selector(didClickTextField:) forControlEvents:UIControlEventEditingDidEnd];

    [_timeField   setText:numberData.time];
    [_timeField addTarget:self action:@selector(didClickTextField:) forControlEvents:UIControlEventEditingDidEnd];
    
    [_caloriesLabel setText:numberData.calories];
    
    
}


#pragma --mark
#pragma --textFieldDelegate
-(void)didClickTextField:(UITextField *)textField
{
    
    if ([textField isEqual:_numberField]) {
        PPDebug(@"number field, %@",[textField description]);
        if ([delegate respondsToSelector:@selector(didClickCellTextField:atIndex:)]){
            [delegate didClickCellTextField:textField atIndex:self.indexPath];
        }
    }
    
    
    if ([textField isEqual:_weightField]) {
        PPDebug(@"weight field, %@",[textField description]);
        if ([delegate respondsToSelector:@selector(didClickCellTextField:atIndex:)]){
            [delegate didClickCellTextField:textField atIndex:self.indexPath];
        }
    }
    
    
    if ([textField isEqual:_timeField]) {
        PPDebug(@"time field, %@",[textField description]);
        if ([delegate respondsToSelector:@selector(didClickCellTextField:atIndex:)]){
            [delegate didClickCellTextField:textField atIndex:self.indexPath];
        }
    }
}


-(void)textFieldResignToFirstResponder{
    if ([_weightField  isEditing]) {
        [_weightField resignFirstResponder];
    }
    if ([_numberField  isEditing]) {
        [_numberField resignFirstResponder];
    }
    if ([_timeField  isEditing]) {
        [_timeField resignFirstResponder];
    }
}



























@end
