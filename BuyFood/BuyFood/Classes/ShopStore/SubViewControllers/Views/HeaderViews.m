//
//  HeaderViews.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "HeaderViews.h"

@implementation HeaderViews

+ (instancetype)initWithHeaderViews
{
    return [[self alloc] init];
}

- (void)setUpContentView
{
    [self setBackgroundColor:[UIColor whiteColor]];
    self.withdrawMoney = [[UILabel alloc] init];
    self.withdrawMoney.textAlignment = NSTextAlignmentCenter;
    self.withdrawMoney.textColor = HDCColor(35, 193, 58);
    self.withdrawMoney.font = [UIFont fontWithName:@"DINCondensed-Bold" size:55];
    [self addSubview:self.withdrawMoney];
    [self.withdrawMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(30);
        make.centerX.mas_equalTo(self.centerX);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.30);
        make.height.equalTo(self.withdrawMoney.mas_width).multipliedBy(0.7);
    }];
    UILabel* label = [[UILabel alloc] init];
    label.text = @"可提现金额";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = HDCColor(153, 153, 153);
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.withdrawMoney.mas_bottom).offset(0);
        make.centerX.mas_equalTo(self.centerX);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.22);
        make.height.equalTo(self.withdrawMoney.mas_width).multipliedBy(0.29);
    }];
    
    self.withdrawMoneyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.withdrawMoneyBtn setTitleColor:HDCColor(250, 250, 250) forState:UIControlStateNormal];
    [self.withdrawMoneyBtn setBackgroundImage:[UIImage imageNamed:@"bj_biaoqian"] forState:UIControlStateNormal];
    [self.withdrawMoneyBtn setTitle:@"立即提现" forState:UIControlStateNormal];
    self.withdrawMoneyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self addSubview:self.withdrawMoneyBtn];
    [self.withdrawMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.centerX);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.38);
        make.height.equalTo(self.withdrawMoneyBtn.mas_width).multipliedBy(0.28);
    }];
    
}

@end
