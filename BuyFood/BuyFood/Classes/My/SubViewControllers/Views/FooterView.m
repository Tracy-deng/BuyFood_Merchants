//
//  FooterView.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "FooterView.h"

@interface FooterView ()
/** 分割线*/
@property (nonatomic, strong) UILabel* line;
/** 合计 */
@property (nonatomic, strong) UILabel* total;
/** 合计金额 */
@property (nonatomic, strong) UILabel* totalMoney;
/** 订单号 */
@property (nonatomic, strong) UILabel* orderNum;
/** 订单号码*/
@property (nonatomic, strong) UILabel* orderNumber;

@end

@implementation FooterView

+ (instancetype)initWithFooterView
{
    return [[self alloc] init];
}

- (void)setUpContentView
{
    self.line = [[UILabel alloc] init];
    [self.line setBackgroundColor:HDCColor(224, 224, 224)];
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(5);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.95);
        make.height.equalTo(@1);
    }];
    self.total = [[UILabel alloc] init];
    self.total.textColor = HDCColor(153, 153, 153);
    self.total.text = @"合计:  ¥";
    self.total.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    [self addSubview:self.total];
    [self.total mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(5);
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.width.equalTo(@50);
        make.height.equalTo(@18);
    }];
    self.totalMoney = [[UILabel alloc] init];
    self.totalMoney.textColor = HDCColor(153, 153, 153);
    self.totalMoney.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    [self addSubview:self.totalMoney];
    [self.totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.total);
        make.left.mas_equalTo(self.total.mas_right).offset(0);
        make.width.equalTo(@30);
        make.height.equalTo(self.total);
    }];
    
    self.orderNumber = [[UILabel alloc] init];
    self.orderNumber.textColor = HDCColor(153, 153, 153);
    self.orderNumber.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    [self addSubview:self.orderNumber];
    [self.orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.total);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.width.equalTo(@80);
        make.height.equalTo(self.total);
    }];
    self.orderNum = [[UILabel alloc] init];
    self.orderNum.textColor = HDCColor(153, 153, 153);
    self.orderNum.text = @"订单号";
    self.orderNum.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    [self addSubview:self.orderNum];
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.total);
        make.right.mas_equalTo(self.orderNumber.mas_left).offset(-5);
        make.width.equalTo(@40);
        make.height.equalTo(self.total);
    }];
}
- (void)setUpMoneyLabel:(NSString* )money andOrderNumberLabel:(NSString* )orderNumber
{
    self.totalMoney.text = money;
    self.orderNumber.text = orderNumber;
}
@end
