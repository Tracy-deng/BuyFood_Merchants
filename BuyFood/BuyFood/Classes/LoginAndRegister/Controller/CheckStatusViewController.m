//
//  CheckStatusViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/8/18.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "CheckStatusViewController.h"
#import "LoginViewController.h"

@interface CheckStatusViewController ()

@end

@implementation CheckStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:WhiteColor];
    self.title = @"认证状态";
    [self setNavLeftBtn];
    [self setUI];
}
/** 设置导航栏左边按钮 */
- (void)setNavLeftBtn
{
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
    UIBarButtonItem* laftBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = laftBarItem;
}

- (void)setUI
{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ytjsh"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(SCREEN_WIDTH * 0.55));
    }];
    
    UIButton *backToLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [backToLoginBtn setBackgroundColor:greenColor];
    [backToLoginBtn setTitle:@"返回登录" forState:UIControlStateNormal];
    [backToLoginBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [backToLoginBtn addTarget:self action:@selector(backToLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backToLoginBtn];
    [backToLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(50);
        make.width.equalTo(@(SCREEN_WIDTH - 100));
        make.height.mas_equalTo(@(35));
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-50);
    }];
    [backToLoginBtn.layer setMasksToBounds:YES];
    [backToLoginBtn.layer setCornerRadius:5.0];//设置矩形四个圆角半径
}

- (void)backToLoginBtnClick:(UIButton *)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
