//
//  ProductCell.h
//  WoJianMei
//
//  Created by Tom Callon  on 1/17/14.
//
//

#import "ProductCommonCell.h"

@class ProductItem;
@interface ProductCell : ProductCommonCell


+ (id)createCell:(id)delegate;
+ (NSString*)getCellIdentifier;
+ (CGFloat)getCellHeight;


-(void)updateCellWithProduct:(ProductItem *)product;


@end
