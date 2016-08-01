//
//  MyBillAllCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/6/24.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBillModel.h"

@interface MyBillAllCell : UITableViewCell
@property (nonatomic, strong) MyBillModel *model;


+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setuserHeaderImageName:(NSString* )userHeaderImageName andUserName:(NSString* )userName;
@end
