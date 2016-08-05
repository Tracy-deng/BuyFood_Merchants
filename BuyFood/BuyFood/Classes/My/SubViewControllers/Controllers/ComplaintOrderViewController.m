//
//  ComplaintOrderViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/18.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ComplaintOrderViewController.h"
#import "ComplaintOrderCell.h"
#import "ComplaintOrderDetailsViewController.h"
#import "RequestTool.h"
#import "OrderParams.h"
#import "MarketOrderModelList.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "OrderMarketModel.h"
#import "LoadView.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"

@interface ComplaintOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;


@end

@implementation ComplaintOrderViewController
{
    NSMutableArray *distributionDataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:WhiteColor];
    // 解决navigationBar影响tableView的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"投诉订单";
    [self setUpTableView];
    [self prepareComplaintOrderDataSource];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self prepareComplaintOrderDataSource];
    }];
}


- (void)prepareComplaintOrderDataSource
{
    [MBProgressHUD showMessage:@"数据正在加载中..."];
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    OrderParams *params = [[OrderParams alloc] init];
    params.marketuserid = userInfo.marketuserid;
    params.pageindex = @"1";
    params.pagesize = @"10";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [RequestTool ComplaintOrderList:params success:^(MarketOrderModelList *result) {
            if ([result.totalcount isEqualToString:@"0"])
            {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showSuccess:@"暂无数据"];
                [self.tableView.header endRefreshing];
            }
            else
            {
                [distributionDataArray removeAllObjects];
                distributionDataArray = [OrderMarketModel mj_objectArrayWithKeyValuesArray:result.OrderMarket];
                
                [MBProgressHUD hideHUD];
                [MBProgressHUD showSuccess:@"数据加载成功"];
                [self.tableView.header endRefreshing];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"数据加载失败"];
            [self.tableView.header endRefreshing];
        }];
    });
}

/** 设置tableView */
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 64));
    }];
    self.tableView.rowHeight = 155;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone; // 删除分割线
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return distributionDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ComplaintOrderCell* cell = [ComplaintOrderCell cellWithTableView:tableView];
    cell.model = distributionDataArray[indexPath.row];
    [cell.searchListBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)btnClick:(UIButton* )sender
{
    HDCLog(@"查看详情");
    OrderMarketModel * model = distributionDataArray[sender.tag];
    
    ComplaintOrderDetailsViewController *complainViewController = [[ComplaintOrderDetailsViewController alloc] init];
    complainViewController.detailUrl = model.orderno;
    
    [self.navigationController pushViewController:complainViewController animated:YES];
}
@end
