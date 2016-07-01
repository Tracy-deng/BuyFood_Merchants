//
//  AddPrinterViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "AddPrinterViewController.h"

@interface AddPrinterViewController ()
@property (nonatomic, strong) UITableView *printerTableView ; // 搜索到的蓝牙设备
@end

@implementation AddPrinterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"添加打印机";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self creatUI];
}


- (void)creatUI
{
    UIView * backGroundView = [[UIView alloc]init];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGroundView];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.25);
    }];
    
    
    UIImageView * printerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopsImage"]];
    printerView.backgroundColor = greenColor;
    [backGroundView addSubview:printerView];
    [printerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backGroundView.mas_top).offset(15);
        make.width.height.equalTo(@80);
        make.left.equalTo(backGroundView).offset(SCREEN_WIDTH / 2 - 40);
    }];
    
    printerView.layer.masksToBounds = YES;
    printerView.layer.cornerRadius = 40;
    
    UILabel *searchLabel = [UILabel new];
    searchLabel.text = @"正在搜索打印机";
    searchLabel.font = [UIFont systemFontOfSize:12];
    searchLabel.textColor = [UIColor colorWithWhite:0.609 alpha:1.000];
    [backGroundView addSubview:searchLabel];
    [searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(printerView.mas_bottom).offset(2);
        make.left.equalTo(printerView);
        make.width.equalTo(@100);
        make.height.equalTo(@25);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"正在搜索打印机";
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = greenColor;
    [backGroundView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchLabel.mas_bottom).offset(2);
        make.left.equalTo(printerView);
        make.width.equalTo(@100);
        make.height.equalTo(@25);
    }];
    
    UIButton * reSearchBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [reSearchBtn setTitle:@"重新搜索" forState:(UIControlStateNormal)];
    reSearchBtn.frame = CGRectMake(0, 0, 100, 30);
    reSearchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [reSearchBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [reSearchBtn addTarget:self action:@selector(didReSearch:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:reSearchBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    self.printerTableView = [[UITableView alloc]init];
    self.printerTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.printerTableView];
    [self.printerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backGroundView.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@300);
    }];
    
    
}

- (void)didReSearch:(UIButton *)sender
{
    NSLog(@"点击重新搜索蓝牙设备");
}


@end
