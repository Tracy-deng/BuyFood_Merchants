//
//  CardListViewController.m
//  CashIn【提现】
//
//  Created by 黄栋春 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "CardListViewController.h"
#import "CardCell.h"
#import "AddBankCardViewController.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface CardListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;


@end

@implementation CardListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.title = @"钱包";
    // 解决navigationBar影响tableView的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTableView];
    [self setNavRightBtn];
}

- (void)setNavRightBtn
{
    UIButton* addRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addRightBtn addTarget:self action:@selector(addRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addRightBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [addRightBtn setFrame:CGRectMake(30, 30, 15, 15)];
    UIBarButtonItem* addRightBtnBarItem = [[UIBarButtonItem alloc] initWithCustomView:addRightBtn];
    
    self.navigationItem.rightBarButtonItem = addRightBtnBarItem;
}

- (void)addRightBtnClick:(UIButton* )sender
{
    [self.navigationController pushViewController:[[AddBankCardViewController alloc] init] animated:YES];
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(50);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@(SCREEN_HEIGHT - 50));
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardCell* cell = [CardCell cellWithTableView:tableView];
    [cell setUpBackGroundImageName:@"cardListBackGroundImage" andBankName:@"中国农业银行" andCardType:@"储蓄卡" andCardNumber:@"***** **** **** 9987"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT * 0.22;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.section);
}


@end
