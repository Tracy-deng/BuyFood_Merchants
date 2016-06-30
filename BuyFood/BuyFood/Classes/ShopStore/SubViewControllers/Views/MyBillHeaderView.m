//
//  MyBillHeaderView.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/23.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "MyBillHeaderView.h"

@interface MyBillHeaderView ()

@end

@implementation MyBillHeaderView

+ (instancetype)initWithMyBillHeaderView
{
    return [[self alloc] init];
}

- (void)setHeaderContentView
{
    _view1 = [[UIView alloc]init];
    _view1.backgroundColor = greenColor;
    [self addSubview:_view1];
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);//).offset(64
        make.left.equalTo(self);
        make.height.equalTo(@(SCREEN_HEIGHT * 0.08));
        make.width.equalTo(@(SCREEN_WIDTH/3));
    }];
    _view2 = [[UIView alloc]init];
    _view2.backgroundColor = [UIColor whiteColor];
    [self addSubview:_view2];
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(_view1);
        make.left.equalTo(_view1.mas_right);
    }];
    _view3 = [[UIView alloc]init];
    _view3.backgroundColor = [UIColor whiteColor];
    [self addSubview:_view3];
    [_view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(_view1);
        make.left.equalTo(_view2.mas_right);
    }];
    
    
    self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.allBtn setBackgroundColor:[UIColor whiteColor]];
    [self.allBtn setTitle:@"全部" forState:UIControlStateNormal];
    [self.allBtn setTitleColor:greenColor forState:UIControlStateSelected];
    self.allBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.allBtn setTitleColor:HDCColor(102, 102, 102) forState:UIControlStateNormal];
    [_view1 addSubview:self.allBtn];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.left.equalTo(_view1);
        make.height.equalTo(@(SCREEN_HEIGHT * 0.08 - 2));
    }];
    
    
    
    self.incomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.incomeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.incomeBtn setBackgroundColor:[UIColor whiteColor]];
    [self.incomeBtn setTitle:@"收入" forState:UIControlStateNormal];
    [self.incomeBtn setTitleColor:greenColor forState:UIControlStateSelected];
    [self.incomeBtn setTitleColor:HDCColor(102, 102, 102) forState:UIControlStateNormal];
    [_view2 addSubview:self.incomeBtn];
    [self.incomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.width.equalTo(_view2);
        make.height.equalTo(self.allBtn);
    }];
    
    
    self.spendingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.spendingBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.spendingBtn setBackgroundColor:[UIColor whiteColor]];
    [self.spendingBtn setTitle:@"支出" forState:UIControlStateNormal];
    [self.spendingBtn setTitleColor:greenColor forState:UIControlStateSelected];
    [self.spendingBtn setTitleColor:HDCColor(102, 102, 102) forState:UIControlStateNormal];
    [_view3 addSubview:self.spendingBtn];
    [self.spendingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.width.equalTo(_view3);
        make.height.equalTo(self.allBtn);
    }];
}

@end
