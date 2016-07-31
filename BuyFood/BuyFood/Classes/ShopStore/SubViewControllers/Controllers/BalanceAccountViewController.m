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
#import "HttpRequestTool.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "RequestTool.h"
#import "BalanceAccountParams.h"
#import "ResultsModel.h"

@interface BalanceAccountViewController ()

@property (nonatomic, strong) HeaderViews* headerView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ShopsUserInfo* userInfo;

@end

@implementation BalanceAccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    self.title = @"账户余额";
    self.userInfo = [ShopsUserInfoTool account];
    [self setUpHeaderView];
    [self setUpTableView];
}

- (void)setUpHeaderView
{
    self.headerView = [HeaderViews initWithHeaderViews];
    [self.headerView setUpContentView];
    
    [self.headerView.withdrawMoneyBtn addTarget:self action:@selector(withdrawMoneyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(84);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.34);
        make.width.mas_equalTo(self.view);
    }];
    
    
    BalanceAccountParams *params = [[BalanceAccountParams alloc] init];
    params.userid = self.userInfo.marketuserid;
    [RequestTool balanceAccount:params success:^(ResultsModel *result) {
        NSString *money = result.ModelList[0][@"totalmoney"];
        self.headerView.withdrawMoney.text = [NSString stringWithFormat:@"%@", money];
    } failure:^(NSError *error) {
        ;
    }];
}
/** 提现按钮点击 */
- (void)withdrawMoneyBtnClick:(UIButton* )sender
{
    [self.navigationController pushViewController:[[CardListViewController alloc] init] animated:YES];
}

/** 设置提现状态View */
- (void)setUpTableView
{
    UILabel* label = [[UILabel alloc] init];
    label.text = @"提现状态";
    label.textColor = HDCColor(153, 153, 153);
    label.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.15);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.02);
    }];
    
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:WhiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(20);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.47);
    }];
    
//    UIImageView *imageView = [[UIImageView alloc] init];
    
    
    
}

@end
