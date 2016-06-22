//
//  OrderListCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setUpFoodNameLabel:(NSString* )foodName andNumberLabel:(NSString* )number andMoneyLabel:(NSString* )money;

@end
