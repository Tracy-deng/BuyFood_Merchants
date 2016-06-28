//
//  BalanceAccountViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BalanceAccountViewController.h"
#import "HeaderViews.h"
#import "BalanceAccountCell.h"
#import "CardListViewController.h"

@interface BalanceAccountViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) HeaderViews* headerView;
@property (nonatomic, strong) UITableView* tableView;


@end

@implementation BalanceAccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    self.title = @"账户余额";
    [self setUpHeaderView];
    [self setUpTableView];
}

- (void)setUpHeaderView
{
    self.headerView = [HeaderViews initWithHeaderViews];
    [self.headerView setUpContentView];
    self.headerView.withdrawMoney.text = @"1758";
    [self.headerView.withdrawMoneyBtn addTarget:self action:@selector(withdrawMoneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(84);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.34);
        make.width.mas_equalTo(self.view);
    }];
}
- (void)withdrawMoneyBtnClick:(UIButton* )sender
{
    HDCLog(@"取现按钮点击");
    [self.navigationController pushViewController:[[CardListViewController alloc] init] animated:YES];
}

/** 设置tableView */
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(20);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.43);
    }];
    UILabel* label = [[UILabel alloc] init];
    label.text = @"提现记录";
    label.textColor = HDCColor(153, 153, 153);
    label.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.15);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.02);
    }];
}

#pragma UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BalanceAccountCell* cell = [BalanceAccountCell cellWithTableView:tableView];
    [cell setUpAccountMoneyLabel:@"110" andAccountTimeLabel:@"昨天14:00" andAccountCardLabel:@"跳转到工商银行卡"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
