//
//  BaseTableViewCell.h
//  BuyFood
//
//  Created by dave-n1 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel * orderNumLabel; // 订单号
@property (nonatomic, strong) UILabel * timeLabel; // 时间
@property (nonatomic, strong) UILabel * addressLabel; // 地址

@property (nonatomic, strong) UILabel * allLabel; // 总计
@property (nonatomic, strong) UILabel * moneyLabel; // 钱数目
@property (nonatomic, strong) UIButton * detailBtn; // 查看详情

@property (nonatomic, strong) UIView * greenView;

@property (nonatomic, strong) UIView * whiteView;

@property (nonatomic, strong) UIView * lineView;

@end
