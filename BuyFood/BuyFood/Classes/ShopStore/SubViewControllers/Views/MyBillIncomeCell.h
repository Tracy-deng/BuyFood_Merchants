//
//  MyBillIncomeCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/24.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBillIncomeCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setuserHeaderImageName:(NSString* )userHeaderImageName andUserName:(NSString* )userName andOrderText:(NSString* )order andTimeLabel:(NSString* )time andMoneyText:(NSString* )money;

@end
