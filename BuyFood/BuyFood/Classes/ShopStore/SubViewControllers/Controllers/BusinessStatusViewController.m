//
//  BusinessStatusViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BusinessStatusViewController.h"
#import "BusinessStatusView.h"
#import "ChooseBusinessTimeViewController.h"
#import "ShopsUserInfoTool.h"
#import "ShopsUserInfo.h"

@interface BusinessStatusViewController ()

@property (nonatomic, strong) BusinessStatusView* businessStatusView;
@property (nonatomic, strong) ShopsUserInfo* userInfo;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, assign) BOOL change;


@end

@implementation BusinessStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"营业状态";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    self.userInfo = [ShopsUserInfoTool account];
    self.time = [[self.userInfo.openstart stringByAppendingString:@"-"] stringByAppendingString:self.userInfo.openend];
    _change = YES;
    [self creatBusinessStatusView];
    [self setUpBusinessStatusBtn];
}

- (void)creatBusinessStatusView
{
    self.businessStatusView = [BusinessStatusView initBusinessStatusView];
    [self.businessStatusView creatHeaderContentView];
    
    [self.businessStatusView setHeaderImageViewName:@"headerImage" andBusinessStatus:@"休息中" andBusinessTime:self.time andBusinessStatusLabel:@"现在是休息时间,不接收订单"];
    [self.businessStatusView.businessTime addTarget:self action:@selector(chooseBusinessTime:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.businessStatusView];
    [self.businessStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.20);
    }];
}

- (void)chooseBusinessTime:(UIButton* )businessTimeBtn
{
    ChooseBusinessTimeViewController* chooseVC = [[ChooseBusinessTimeViewController alloc] init];
    chooseVC.startTime = self.userInfo.openstart;
    chooseVC.stopTime = self.userInfo.openend;
    [chooseVC returnText:^(NSString *showText) {
        [self.businessStatusView.businessTime setTitle:[NSString stringWithFormat:@"营业时间：%@",showText] forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:chooseVC animated:YES];
}

- (void)setUpBusinessStatusBtn
{
    UIButton* businessStatusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [businessStatusBtn setBackgroundImage:[UIImage imageNamed:@"businessStatus"] forState:UIControlStateNormal];
    [businessStatusBtn setTitle:@"开始接单" forState:UIControlStateNormal];
    [businessStatusBtn setBackgroundImage:[UIImage imageNamed:@"businessStatus_Stop"] forState:UIControlStateSelected];
    [businessStatusBtn setTitle:@"停止接单" forState:UIControlStateSelected];
    [businessStatusBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    businessStatusBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [businessStatusBtn addTarget:self action:@selector(businessStatusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:businessStatusBtn];
    [businessStatusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.businessStatusView.mas_bottom).offset(100);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.08);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.89);
    }];
}

- (void)businessStatusBtnClick:(UIButton* )sender
{
    sender.selected = !sender.isSelected;
    if (!sender.selected)
    {
        [self.businessStatusView setHeaderImageViewName:@"headerImage" andBusinessStatus:@"休息中" andBusinessTime:self.time andBusinessStatusLabel:@"现在是休息时间,不接收订单"];
    }
    else
    {
        [self.businessStatusView setHeaderImageViewName:@"headerImage" andBusinessStatus:@"营业中" andBusinessTime:self.time andBusinessStatusLabel:@"现在是营业时间,接收订单"];
    }
}

@end
