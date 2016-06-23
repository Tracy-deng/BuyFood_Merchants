//
//  MyBillViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "MyBillViewController.h"

@interface MyBillViewController ()

@end

@implementation MyBillViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的账单";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self setUpThreeBtn];
}

- (void)setUpThreeBtn
{
    UIView* btnView = [[UIView alloc] init];
    [btnView setBackgroundColor:HDCColor(250, 250, 250)];
    [self.view addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.08);
    }];
    UIButton* allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [allBtn setTitle:@"全部" forState:UIControlStateNormal];
    allBtn.layer.borderWidth = 1;
    allBtn.layer.cornerRadius = 5;
    allBtn.layer.borderColor = HDCColor(153, 153, 153).CGColor;
    [allBtn setTitleColor:HDCColor(102, 102, 102) forState:UIControlStateNormal];
    [allBtn setTitleColor:greenColor forState:UIControlStateHighlighted];
    [btnView addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnView.mas_top).offset(10);
        make.left.mas_equalTo(btnView.mas_left).offset(10);
        make.width.mas_equalTo(btnView.mas_width).multipliedBy(0.24);
        make.height.mas_equalTo(allBtn.mas_width).multipliedBy(0.33);
    }];
    UIButton* incomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [incomeBtn setTitle:@"收入" forState:UIControlStateNormal];
    incomeBtn.layer.cornerRadius = 5;
    [incomeBtn setBackgroundColor:greenColor];
    [incomeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [incomeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [btnView addSubview:incomeBtn];
    [incomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(allBtn);
        make.width.equalTo(allBtn);
        make.height.equalTo(allBtn);
    }];
    UIButton* spendingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [spendingBtn setTitle:@"支出" forState:UIControlStateNormal];
    spendingBtn.layer.borderWidth = 1;
    spendingBtn.layer.cornerRadius = 5;
    spendingBtn.layer.borderColor = HDCColor(153, 153, 153).CGColor;
    [spendingBtn setTitleColor:HDCColor(102, 102, 102) forState:UIControlStateNormal];
    [spendingBtn setTitleColor:greenColor forState:UIControlStateHighlighted];
    [btnView addSubview:spendingBtn];
    [spendingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(allBtn);
        make.right.mas_equalTo(btnView.mas_right).offset(-10);
        make.width.equalTo(allBtn);
        make.height.equalTo(allBtn);
    }];
}


@end
