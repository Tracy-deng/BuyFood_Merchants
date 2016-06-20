//
//  PickUpCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/17.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickUpCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setOrderNumLabelText:(NSString* )orderNumLabelText andOrderNumberLabelText:(NSString* )orderNumberLabelText andOrderTimeLabelText:(NSString* )orderTimeLabelText andOrderAddressLabelText:(NSString* )orderAddressLabelText;

@end
