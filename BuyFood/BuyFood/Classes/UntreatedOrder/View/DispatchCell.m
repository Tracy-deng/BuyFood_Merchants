//
//  DispatchCell.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/18.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "DispatchCell.h"

@interface DispatchCell()


/** 订单号 */
@property (nonatomic, strong) UILabel* orderNumberLabel;
/** 送达时间 */
@property (nonatomic, strong) UIButton* getTimeBtn;
/** 下单时间 */
@property (nonatomic, strong) UILabel* orderTimeLabel;
/** 下单地址 */
@property (nonatomic, strong) UILabel* orderAddressLabel;

/** 合计label */
@property (nonatomic, strong) UILabel* totalLabel;
/** 合计金额 */
@property (nonatomic, strong) UILabel* totalMoney;



@end

@implementation DispatchCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    DispatchCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[DispatchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:HDCColor(238, 238, 238)];
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
    // 送达时间 getTimeBtn
    self.getTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getTimeBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 13"] forState:UIControlStateNormal];
    self.getTimeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.getTimeBtn setTitleColor:HDCColor(35, 189, 52) forState:UIControlStateNormal];
    [whiteView addSubview:self.getTimeBtn];
    [self.getTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumberLabel.mas_bottom).offset(5);
        make.left.equalTo(self.orderNumberLabel);
        make.width.mas_equalTo(whiteView.mas_width).multipliedBy(0.30);
        make.height.mas_equalTo(@25);
    }];
    // 下单时间 orderTimeLabel
    self.orderTimeLabel = [[UILabel alloc] init];
    self.orderTimeLabel.textColor = HDCColor(102, 102, 102);
    self.orderTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [whiteView addSubview:self.orderTimeLabel];
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumberLabel.mas_bottom).offset(29);
        make.left.equalTo(self.orderNumberLabel.mas_left);
        make.width.mas_equalTo(whiteView.mas_width).multipliedBy(0.70);
        make.height.mas_equalTo(@20);
    }];
    // 下单地址 orderAddressLabel
    self.orderAddressLabel = [[UILabel alloc] init];
    self.orderAddressLabel.textColor = HDCColor(102, 102, 102);
    self.orderAddressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    self.orderAddressLabel.numberOfLines = 0;
    [whiteView addSubview:self.orderAddressLabel];
    [self.orderAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderTimeLabel.mas_bottom).offset(1);
        make.left.equalTo(self.orderNumberLabel.mas_left);
        make.width.mas_equalTo(whiteView.mas_width).multipliedBy(0.70);
        make.height.mas_equalTo(@40);
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
    self.totalLabel.text = @"合计:";
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
    
    self.noGetOrderBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.noGetOrderBtn setImage:[UIImage imageNamed:@"gb"] forState:(UIControlStateNormal)];
    [whiteView addSubview:self.noGetOrderBtn];
    [self.noGetOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(whiteView.mas_right).offset(-3);
        make.top.equalTo(whiteView.mas_top).offset(5);
        make.width.height.equalTo(@20);
    }];
    
}

- (void)setOrderNumberLabelText:(NSString* )orderNumberLabelText andGetTimeBtnText:(NSString* )getTimeBtnText andOrderTimeLabelText:(NSString* )orderTimeLabelText andOrderAddressLabelText:(NSString* )orderAddressLabelText moneyLabel:(NSString *)moneyText
{
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单号 %@",orderNumberLabelText];
    [self.getTimeBtn setTitle:getTimeBtnText forState:UIControlStateNormal];
    self.orderTimeLabel.text = [NSString stringWithFormat:@"下单时间 %@",orderTimeLabelText];
    self.orderAddressLabel.text = orderAddressLabelText;
    self.totalMoney.text = moneyText;
}

@end
