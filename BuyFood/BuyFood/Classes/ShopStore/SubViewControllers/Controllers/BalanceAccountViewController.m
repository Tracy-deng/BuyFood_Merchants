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
    [RequestTool balanceAccount:params success:^(ResultsModel *result)
     {
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
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    [imageView1 setImage:[UIImage imageNamed:@"green"]];
    [view addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(30);
        make.top.mas_equalTo(view.mas_top).offset(50);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    
    UILabel *statusLabel1 = [[UILabel alloc] init];
    statusLabel1.text = @"审核";
    statusLabel1.textColor = greenColor;
    statusLabel1.textAlignment = NSTextAlignmentCenter;
    statusLabel1.font = [UIFont systemFontOfSize:18];
    [view addSubview:statusLabel1];
    [statusLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView1.mas_centerX);
        make.top.mas_equalTo(imageView1.mas_bottom).offset(10);
        make.width.equalTo(@(80));
        make.height.equalTo(@(40));
    }];
    
    
    UILabel *statusProduct1 = [[UILabel alloc] init];
    statusProduct1.text = @"已提交审核";
    statusProduct1.textColor = HDCColor(117, 117, 117);
    statusProduct1.textAlignment = NSTextAlignmentCenter;
    statusProduct1.font = [UIFont systemFontOfSize:12];
    [view addSubview:statusProduct1];
    [statusProduct1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(statusLabel1.mas_centerX);
        make.top.mas_equalTo(statusLabel1.mas_bottom).offset(10);
        make.width.equalTo(@(100));
        make.height.equalTo(@(30));
    }];
    
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    [imageView2 setImage:[UIImage imageNamed:@"gray"]];
    [view addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX);
        make.top.width.height.equalTo(imageView1);
    }];
    
    UILabel *statusLabel2 = [[UILabel alloc] init];
    statusLabel2.text = @"审核中";
    statusLabel2.textAlignment = NSTextAlignmentCenter;
    statusLabel2.font = [UIFont systemFontOfSize:18];
    [view addSubview:statusLabel2];
    [statusLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView2.mas_centerX);
        make.top.width.height.equalTo(statusLabel1);
    }];
    
    UILabel *statusProduct2 = [[UILabel alloc] init];
    statusProduct2.text = @"审核中请耐心等待";
    statusProduct2.textColor = HDCColor(117, 117, 117);
    statusProduct2.textAlignment = NSTextAlignmentCenter;
    statusProduct2.font = [UIFont systemFontOfSize:12];
    [view addSubview:statusProduct2];
    [statusProduct2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(statusLabel2.mas_centerX);
        make.top.width.height.equalTo(statusProduct1);
    }];
    
    
    UIImageView *imageView3 = [[UIImageView alloc] init];
    [imageView3 setImage:[UIImage imageNamed:@"gray"]];
    [view addSubview:imageView3];
    [imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view.mas_right).offset(-30);
        make.top.width.height.equalTo(imageView1);
    }];
    
    UILabel *statusLabel3 = [[UILabel alloc] init];
    statusLabel3.text = @"通过审核";
    statusLabel3.textAlignment = NSTextAlignmentCenter;
    statusLabel3.font = [UIFont systemFontOfSize:18];
    [view addSubview:statusLabel3];
    [statusLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView3.mas_centerX);
        make.top.width.height.equalTo(statusLabel1);
    }];
    
    UILabel *statusProduct3 = [[UILabel alloc] init];
    statusProduct3.text = @"审核已通过将会在2-7个工作日内打款,请留意您的账户余额";
    statusProduct3.textColor = HDCColor(117, 117, 117);
    statusProduct3.numberOfLines = 0;
    statusProduct3.textAlignment = NSTextAlignmentCenter;
    statusProduct3.font = [UIFont systemFontOfSize:12];
    [view addSubview:statusProduct3];
    [statusProduct3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(statusLabel3.mas_centerX);
        make.top.equalTo(statusProduct1);
        make.width.equalTo(@(80));
        make.height.equalTo(@(85));
    }];
    
    UILabel *line1 = [[UILabel alloc] init];
    [line1 setBackgroundColor:HDCColor(194, 194, 194)];
    [view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView1.mas_right);
        make.right.equalTo(imageView2.mas_left);
        make.height.equalTo(@(2));
        make.centerY.mas_equalTo(imageView1.mas_centerY);
    }];
    UILabel *line2= [[UILabel alloc] init];
    [line2 setBackgroundColor:HDCColor(194, 194, 194)];
    [view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView2.mas_right);
        make.right.equalTo(imageView3.mas_left);
        make.height.equalTo(@(2));
        make.centerY.mas_equalTo(imageView1.mas_centerY);
    }];
}

@end
