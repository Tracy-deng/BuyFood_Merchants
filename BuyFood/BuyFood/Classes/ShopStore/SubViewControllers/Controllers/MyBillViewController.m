//
//  MyBillViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "MyBillViewController.h"
#import "MyBillHeaderView.h"
#import "MyBillAllCell.h"
#import "MyBillIncomeCell.h"
#import "MyBillSpendingCell.h"
#import "MyBillInComeInfoViewController.h"
#import "MyBillSpendingInfoViewController.h"

@interface MyBillViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MyBillHeaderView* myBillHeaderView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, assign) NSInteger tag;


@end

@implementation MyBillViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的账单";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self setUpThreeBtn];
    [self createTableView];
    self.tag = 1;
}

- (void)setUpThreeBtn
{
    self.myBillHeaderView = [MyBillHeaderView initWithMyBillHeaderView];
    [self.myBillHeaderView setHeaderContentView];
    self.myBillHeaderView.allBtn.selected = YES;
    [self.myBillHeaderView.allBtn addTarget:self action:@selector(allBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myBillHeaderView.incomeBtn addTarget:self action:@selector(incomeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myBillHeaderView.spendingBtn addTarget:self action:@selector(spendingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.myBillHeaderView setBackgroundColor:HDCColor(250, 250, 250)];
    [self.view addSubview:self.myBillHeaderView];
    [self.myBillHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.08);
    }];
}

- (void)allBtnClick:(UIButton* )allBtn
{
    HDCLog(@"allBtn");
    self.tag = 1;
    allBtn.selected = !allBtn.isSelected;
    self.myBillHeaderView.incomeBtn.selected = NO;
    self.myBillHeaderView.spendingBtn.selected = NO;
    [self.tableView reloadData];
}
- (void)incomeBtnClick:(UIButton* )incomeBtn
{
    HDCLog(@"incomeBtn");
    self.tag = 2;
    incomeBtn.selected = !incomeBtn.isSelected;
    self.myBillHeaderView.allBtn.selected = NO;
    self.myBillHeaderView.spendingBtn.selected = NO;
    [self.tableView reloadData];
}
- (void)spendingBtnClick:(UIButton* )spendingBtn
{
    HDCLog(@"spendingBtn");
    self.tag = 3;
    spendingBtn.selected = !spendingBtn.isSelected;
    self.myBillHeaderView.allBtn.selected = NO;
    self.myBillHeaderView.incomeBtn.selected = NO;
    [self.tableView reloadData];
}

- (void)createTableView
{
    UILabel* titleForHeader = [[UILabel alloc] init];
    titleForHeader.backgroundColor = [UIColor clearColor];
    titleForHeader.text = @"账单详情";
    titleForHeader.textColor = HDCColor(153, 153, 153);
    titleForHeader.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    [self.view addSubview:titleForHeader];
    [titleForHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myBillHeaderView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.width.equalTo(self.view);
        make.height.equalTo(@30);
    }];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleForHeader.mas_bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.70);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tag == 1)
    {
        MyBillAllCell* cell = [MyBillAllCell cellWithTableView:tableView];
        if (indexPath.row == 0)
        {
            [cell setuserHeaderImageName:@"headerImage" andUserName:@"小张" andOrderText:@"蔬菜订单" andTimeLabel:@"13:13" andMoneyText:@"+100.00"];
        }
        else
        {
            [cell setuserHeaderImageName:@"headerImage" andUserName:@"小张" andOrderText:@"转到银行卡" andTimeLabel:@"14:14" andMoneyText:@"-150.00"];
        }
        return cell;
    }
    else if (self.tag == 2)
    {
        MyBillIncomeCell* cell = [MyBillIncomeCell cellWithTableView:tableView];
        [cell setuserHeaderImageName:@"headerImage" andUserName:@"小张" andOrderText:@"蔬菜订单" andTimeLabel:@"13:13" andMoneyText:@"+100.00"];
        return cell;
    }
    else
    {
        MyBillSpendingCell* cell = [MyBillSpendingCell cellWithTableView:tableView];
        [cell setuserHeaderImageName:@"headerImage" andUserName:@"小张" andOrderText:@"转到银行卡" andTimeLabel:@"13:13" andMoneyText:@"-120.00"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.height * 0.12;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tag == 2)
    {
        [self.navigationController pushViewController:[[MyBillInComeInfoViewController alloc] init] animated:YES];
    }
    if (self.tag == 3)
    {
        [self.navigationController pushViewController:[[MyBillSpendingInfoViewController alloc] init] animated:YES];
    }
}

@end
