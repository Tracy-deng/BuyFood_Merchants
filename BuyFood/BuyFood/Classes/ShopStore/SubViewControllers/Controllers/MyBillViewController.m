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
#import "RequestTool.h"
#import "MyBillParams.h"
#import "RequestTool.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "ResultsModel.h"
#import "MyBillModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "LoadView.h"

@interface MyBillViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MyBillHeaderView* myBillHeaderView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) ShopsUserInfo *userInfo;


@end

@implementation MyBillViewController
{
    NSMutableArray *dataSource;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的账单";
    self.userInfo = [ShopsUserInfoTool account];
    [self.view setBackgroundColor:HDCBackViewColor];
    [self setUpThreeBtn];
    [self createTableView];
    [self prepareAllDataSource];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self.tag == 1)
        {
            [self prepareAllDataSource];
        }
        if (self.tag == 2)
        {
            [self prepareIncomeDataSource];
        }
        if (self.tag == 3)
        {
            [self prepareSpendingDataSource];
        }
    }];
    self.tag = 1;
}
/** 获取全部账单 */
- (void)prepareAllDataSource
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    MyBillParams *params = [[MyBillParams alloc] init];
    params.userid = self.userInfo.marketuserid;
    params.pageindex = @"1";
    params.pagesize = @"0";
    params.billtype = @"0";
    [RequestTool myBill:params success:^(ResultsModel *result) {
        dataSource = [NSMutableArray array];
        dataSource = [MyBillModel mj_objectArrayWithKeyValuesArray:result.ModelList];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [loadView stopAnimation];
    } failure:^(NSError *error) {
        ;
    }];
}
/** 获取收入账单 */
- (void)prepareIncomeDataSource
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    MyBillParams *params = [[MyBillParams alloc] init];
    params.userid = self.userInfo.marketuserid;
    params.pageindex = @"1";
    params.pagesize = @"0";
    params.billtype = @"1";
    [RequestTool myBill:params success:^(ResultsModel *result) {
        dataSource = [NSMutableArray array];
        dataSource = [MyBillModel mj_objectArrayWithKeyValuesArray:result.ModelList];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [loadView stopAnimation];
    } failure:^(NSError *error) {
        ;
    }];
}

/** 获取支出账单 */
- (void)prepareSpendingDataSource
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    MyBillParams *params = [[MyBillParams alloc] init];
    params.userid = self.userInfo.marketuserid;
    params.pageindex = @"1";
    params.pagesize = @"0";
    params.billtype = @"2";
    [RequestTool myBill:params success:^(ResultsModel *result) {
        dataSource = [NSMutableArray array];
        dataSource = [MyBillModel mj_objectArrayWithKeyValuesArray:result.ModelList];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [loadView stopAnimation];
    } failure:^(NSError *error) {
        ;
    }];
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
    [self prepareAllDataSource];
    self.tag = 1;
    allBtn.selected = YES;
    self.myBillHeaderView.incomeBtn.selected = NO;
    self.myBillHeaderView.spendingBtn.selected = NO;
    self.myBillHeaderView.view1.backgroundColor = greenColor;
    self.myBillHeaderView.view2.backgroundColor = [UIColor whiteColor];
    self.myBillHeaderView.view3.backgroundColor = [UIColor whiteColor];
    [self.tableView reloadData];
}
- (void)incomeBtnClick:(UIButton* )incomeBtn
{
    [self prepareIncomeDataSource];
    self.tag = 2;
    incomeBtn.selected = YES;
    self.myBillHeaderView.allBtn.selected = NO;
    self.myBillHeaderView.spendingBtn.selected = NO;
    self.myBillHeaderView.view1.backgroundColor = [UIColor whiteColor];
    self.myBillHeaderView.view2.backgroundColor = greenColor;
    self.myBillHeaderView.view3.backgroundColor = [UIColor whiteColor];
    [self.tableView reloadData];
}
- (void)spendingBtnClick:(UIButton* )spendingBtn
{
    [self prepareSpendingDataSource];
    self.tag = 3;
    spendingBtn.selected = YES;
    self.myBillHeaderView.allBtn.selected = NO;
    self.myBillHeaderView.incomeBtn.selected = NO;
    
    self.myBillHeaderView.view1.backgroundColor = [UIColor whiteColor];
    self.myBillHeaderView.view2.backgroundColor = [UIColor whiteColor];
    self.myBillHeaderView.view3.backgroundColor = greenColor;
    [self.tableView reloadData];
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myBillHeaderView.mas_bottom).offset(5);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.70);
    }];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tag == 1)
    {
        MyBillAllCell* cell = [MyBillAllCell cellWithTableView:tableView];
        cell.model = dataSource[indexPath.row];
        [cell setuserHeaderImageName:self.userInfo.pic andUserName:self.userInfo.marketname];
        return cell;
    }
    else if (self.tag == 2)
    {
        MyBillIncomeCell* cell = [MyBillIncomeCell cellWithTableView:tableView];
        cell.model = dataSource[indexPath.row];
        [cell setuserHeaderImageName:self.userInfo.pic andUserName:self.userInfo.marketname];
        return cell;
    }
    else
    {
        MyBillSpendingCell* cell = [MyBillSpendingCell cellWithTableView:tableView];
        cell.model = dataSource[indexPath.row];
        [cell setuserHeaderImageName:self.userInfo.pic andUserName:self.userInfo.marketname];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.height * 0.12;
}



@end
