//
//  MyBillHeaderView.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/23.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "MyBillHeaderView.h"

@implementation MyBillHeaderView

+ (instancetype)initWithMyBillHeaderView
{
    return [[self alloc] init];
}

- (void)setHeaderContentView
{
    self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allBtn setTitle:@"全部" forState:UIControlStateNormal];
    self.allBtn.layer.borderWidth = 1;
    self.allBtn.layer.cornerRadius = 5;
    self.allBtn.layer.borderColor = HDCColor(153, 153, 153).CGColor;
    [self.allBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.allBtn setTitleColor:HDCColor(102, 102, 102) forState:UIControlStateNormal];
    [self.allBtn setBackgroundImage:[UIImage imageNamed:@"myBill"] forState:UIControlStateSelected];
    [self addSubview:self.allBtn];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.24);
        make.height.mas_equalTo(self.allBtn.mas_width).multipliedBy(0.33);
    }];
    self.incomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.incomeBtn setTitle:@"收入" forState:UIControlStateNormal];
    self.incomeBtn.layer.borderWidth = 1;
    self.incomeBtn.layer.cornerRadius = 5;
    self.incomeBtn.layer.borderColor = HDCColor(153, 153, 153).CGColor;
    [self.incomeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.incomeBtn setTitleColor:HDCColor(102, 102, 102) forState:UIControlStateNormal];
    [self.incomeBtn setBackgroundImage:[UIImage imageNamed:@"myBill"] forState:UIControlStateSelected];
    [self addSubview:self.incomeBtn];
    [self.incomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.equalTo(self.allBtn);
        make.width.equalTo(self.allBtn);
        make.height.equalTo(self.allBtn);
    }];
    self.spendingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.spendingBtn setTitle:@"支出" forState:UIControlStateNormal];
    self.spendingBtn.layer.borderWidth = 1;
    self.spendingBtn.layer.cornerRadius = 5;
    self.spendingBtn.layer.borderColor = HDCColor(153, 153, 153).CGColor;
    [self.spendingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.spendingBtn setTitleColor:HDCColor(102, 102, 102) forState:UIControlStateNormal];
    [self.spendingBtn setBackgroundImage:[UIImage imageNamed:@"myBill"] forState:UIControlStateSelected];
    [self addSubview:self.incomeBtn];
    [self addSubview:self.spendingBtn];
    [self.spendingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allBtn);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.width.equalTo(self.allBtn);
        make.height.equalTo(self.allBtn);
    }];
}

@end
