//
//  PickUpCell.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/17.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "PickUpCell.h"

@interface PickUpCell()

/** 订单号 */
@property (nonatomic, strong) UILabel* orderNumberLabel;
/** 下单时间 */
@property (nonatomic, strong) UILabel* orderTimeLabel;
/** 下单地址 */
@property (nonatomic, strong) UILabel* orderAddressLabel;
/** 合计label */
@property (nonatomic, strong) UILabel* totalLabel;
/** 合计金额 */
@property (nonatomic, strong) UILabel* totalMoney;




@end


@implementation PickUpCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    PickUpCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[PickUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUpContentView];
    }
    return self;
}

- (void)setUpContentView
{
    self.contentView.backgroundColor = HDCColor(238, 238, 238);
    
    UIView *greenView = [[UIView alloc]init];
    [self.contentView addSubview:greenView];
    greenView.backgroundColor = greenColor;
    greenView.layer.masksToBounds = YES;
    greenView.layer.cornerRadius = 2;
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(4.5);
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    UIView *whiteView = [[UIView alloc]init];
    [greenView addSubview:whiteView];
    whiteView.backgroundColor = [UIColor whiteColor];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(greenView).offset(7);
        make.left.equalTo(greenView);
        make.right.equalTo(greenView);
        make.bottom.equalTo(greenView);
    }];
    
    UIView *lineView = [UIView new];
    [whiteView addSubview:lineView];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView);
        make.right.equalTo(whiteView);
        make.height.equalTo(@1.0);
        make.bottom.equalTo(whiteView.mas_bottom).offset(-30);
    }];
#pragma 设置UI布局

    
    // 订单号 orderNumberLabel
    self.orderNumberLabel = [[UILabel alloc] init];
    self.orderNumberLabel.textColor = HDCColor(153, 153, 153);
    self.orderNumberLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [whiteView addSubview:self.orderNumberLabel];
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(whiteView.mas_top).offset(10);
        make.left.equalTo(whiteView.mas_left).offset(30);
        make.width.mas_equalTo(whiteView.mas_width).multipliedBy(0.80);
        make.height.mas_equalTo(@20);
    }];
    // 下单时间 orderTimeLabel
    self.orderTimeLabel = [[UILabel alloc] init];
    self.orderTimeLabel.textColor = HDCColor(102, 102, 102);
    self.orderTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [whiteView addSubview:self.orderTimeLabel];
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumberLabel.mas_bottom).offset(29);
        make.left.equalTo(self.orderNumberLabel.mas_left);
        make.width.mas_equalTo(whiteView.mas_width).multipliedBy(0.80);
        make.height.mas_equalTo(@20);
    }];
    // 下单地址 orderAddressLabel
    self.orderAddressLabel = [[UILabel alloc] init];
    self.orderAddressLabel.textColor = HDCColor(102, 102, 102);
    self.orderAddressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [whiteView addSubview:self.orderAddressLabel];
    [self.orderAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderTimeLabel.mas_bottom).offset(2);
        make.left.equalTo(self.orderNumberLabel.mas_left);
        make.width.mas_equalTo(whiteView.mas_width).multipliedBy(0.50);
        make.height.mas_equalTo(@20);
    }];
    // 接单按钮 getOrderBtn  HDCColor(36, 197, 67)
    self.getOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getOrderBtn setTitle:@"接单" forState:UIControlStateNormal];
    [self.getOrderBtn setBackgroundColor:HDCColor(36, 197, 67)];
    [whiteView addSubview:self.getOrderBtn];
    [self.getOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(whiteView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.width.mas_offset(@50);
        make.height.mas_offset(@50);
    }];
    self.getOrderBtn.layer.cornerRadius = 25;
    self.getOrderBtn.layer.masksToBounds = YES;
    
    self.totalLabel = [UILabel new];
    self.totalLabel.text = @"合计";
    self.totalLabel.textColor = [UIColor grayColor];
    self.totalLabel.font = [UIFont systemFontOfSize:12];
    [whiteView addSubview:self.totalLabel];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView).offset(2);
        make.left.equalTo(whiteView).offset(17);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
    }];
    
    self.totalMoney = [UILabel new];
    self.totalMoney.font = [UIFont fontWithName:@"DINAlternate-Bold" size:17];
//    self.totalMoney.text = @"¥56";
    self.totalMoney.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:self.totalMoney];
    [self.totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalLabel);
        make.left.equalTo(self.totalLabel.mas_right).offset(5);
        make.height.equalTo(@30);
        make.width.equalTo(@200);
    }];
    
    self.searchListBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.searchListBtn setTitle:@"查看详情" forState:(UIControlStateNormal)];
    [self.searchListBtn setTitleColor:greenColor forState:(UIControlStateNormal)];
    [whiteView addSubview:self.searchListBtn];
    self.searchListBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.searchListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalMoney);
        make.right.equalTo(whiteView).offset(-10);
        make.width.equalTo(@60);
        make.height.equalTo(@30);
    }];
    
}

- (void)setOrderNumberLabelText:(NSString* )orderNumberLabelText andOrderTimeLabelText:(NSString* )orderTimeLabelText andOrderAddressLabelText:(NSString* )orderAddressLabelText moneyLabel:(NSString *)moneyText
{
   
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单号 %@",orderNumberLabelText];
    self.orderTimeLabel.text = [NSString stringWithFormat:@"下单时间 %@",orderTimeLabelText];
    self.orderAddressLabel.text = orderAddressLabelText;
    self.totalMoney.text = [NSString stringWithFormat:@"¥%@",moneyText];
}




/**
  // 设置订单编号 orderNumLabel
 self.orderNumLabel = [[UILabel alloc] init];
 self.orderNumLabel.textColor = HDCColor(102, 102, 102);
 self.orderNumLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:25];
 [self.contentView addSubview:self.orderNumLabel];
 [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.contentView.mas_top).offset(10);
 make.left.equalTo(self.contentView.mas_left).offset(20);
 make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.14);
 make.height.mas_equalTo(self.orderNumLabel.mas_width).multipliedBy(0.6);
 }];
 
 // 订单号 orderNumberLabel
 self.orderNumberLabel = [[UILabel alloc] init];
 self.orderNumberLabel.textColor = HDCColor(153, 153, 153);
 self.orderNumberLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
 [self.contentView addSubview:self.orderNumberLabel];
 [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.orderNumLabel.mas_top);
 make.left.equalTo(self.orderNumLabel.mas_right).offset(10);
 make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.35);
 make.height.mas_equalTo(self.orderNumberLabel.mas_width).multipliedBy(0.17);
 }];
 // 下单时间 orderTimeLabel
 self.orderTimeLabel = [[UILabel alloc] init];
 self.orderTimeLabel.textColor = HDCColor(102, 102, 102);
 self.orderTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
 [self.contentView addSubview:self.orderTimeLabel];
 [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.orderNumberLabel.mas_bottom).offset(29);
 make.left.equalTo(self.orderNumberLabel.mas_left);
 make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.50);
 make.height.mas_equalTo(self.orderTimeLabel.mas_width).multipliedBy(0.12);
 }];
 // 下单地址 orderAddressLabel
 self.orderAddressLabel = [[UILabel alloc] init];
 self.orderAddressLabel.textColor = HDCColor(102, 102, 102);
 self.orderAddressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
 [self.contentView addSubview:self.orderAddressLabel];
 [self.orderAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.mas_equalTo(self.orderTimeLabel.mas_bottom).offset(2);
 make.left.equalTo(self.orderNumberLabel.mas_left);
 make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.50);
 make.height.mas_equalTo(self.orderTimeLabel.mas_width).multipliedBy(0.12);
 }];
 // 接单按钮 getOrderBtn  HDCColor(36, 197, 67)
 self.getOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 [self.getOrderBtn setTitle:@"接单" forState:UIControlStateNormal];
 [self.getOrderBtn setBackgroundColor:HDCColor(36, 197, 67)];
 [self.getOrderBtn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
 [self.contentView addSubview:self.getOrderBtn];
 [self.getOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
 make.centerY.mas_equalTo(self.contentView.mas_centerY);
 make.right.equalTo(self.contentView.mas_right).offset(-20);
 make.width.mas_offset(@50);
 make.height.mas_offset(@50);
 }];
 self.getOrderBtn.layer.cornerRadius = 25;
 self.getOrderBtn.layer.masksToBounds = YES;
 
 */

@end
