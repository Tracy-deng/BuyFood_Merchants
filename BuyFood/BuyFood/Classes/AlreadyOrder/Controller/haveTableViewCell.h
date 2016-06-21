//
//  haveTableViewCell.h
//  BuyFood
//
//  Created by dave-n1 on 16/6/20.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface haveTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel * numberLabel;  // 编号
@property (nonatomic, strong) UILabel * orderNumLabel; // 订单号
@property (nonatomic, strong) UILabel * timeLabel; // 时间
@property (nonatomic, strong) UILabel * addressLabel; // 地址
@property (nonatomic, strong) UIButton * addOrderBtn; // 接单按钮
@property (nonatomic, strong) UILabel * allLabel; // 总计
@property (nonatomic, strong) UILabel * moneyLabel; // 钱数目
@property (nonatomic, strong) UIButton * detailBtn; // 查看详情

@end
