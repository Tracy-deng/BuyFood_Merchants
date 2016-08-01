//
//  DistributionViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "DistributionViewController.h"
#import "DispatchCell.h"
#import "ComplaintOrderDetailsViewController.h"
#import "LoadView.h"
#import "MJRefresh.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "RequestTool.h"
#import "OrderParams.h"
#import "MarketOrderModelList.h"
#import "OrderMarketModel.h"
#import "MJRefresh.h"
#import "GetOrderParams.h"
#import "ResultsModel.h"
@interface DistributionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray * distributionDataArray;
@end

@implementation DistributionViewController
- (NSMutableArray *)distributionDataArray{
    if (_distributionDataArray == nil) {
        self.distributionDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _distributionDataArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
   
    
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = greenColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.height.equalTo(@0.5);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.backgroundColor = HDCColor(238, 238, 238);
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(view.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 44 - 70));
        
    }];
    self.tableView.rowHeight = 155;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone; // 删除分割线
    
    
    [self createDistributionData];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self createDistributionData];
    }];
}

- (void)createDistributionData
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
     ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    OrderParams *params = [[OrderParams alloc] init];
    params.marketuserid = userInfo.marketuserid;
    params.pageindex = @"1";
    params.pagesize = @"10";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [RequestTool untreatedDistributionOrderList:params success:^(MarketOrderModelList *result) {
            NSLog(@"%@",result.OrderMarket);
            [self.distributionDataArray removeAllObjects];
            for (NSDictionary *dict in result.OrderMarket) {
                OrderMarketModel *model = [[OrderMarketModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.distributionDataArray addObject:model];
            }
            NSLog(@"%@",self.distributionDataArray);
            [loadView stopAnimation];
            [self.tableView .header endRefreshing];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [loadView stopAnimation];
        }];

    });
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.distributionDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DispatchCell *cell = [DispatchCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    OrderMarketModel *model = self.distributionDataArray[indexPath.row];
    [cell setOrderNumberLabelText:model.orderno andGetTimeBtnText:@"立即送达" andOrderTimeLabelText:model.ordertime andOrderAddressLabelText:model.marketuseraddress moneyLabel:model.markettotalmoney];
    
    cell.searchListBtn.tag = indexPath.row;
    [cell.searchListBtn addTarget:self action:@selector(searchListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 接单
    cell.getOrderBtn.tag = indexPath.row;
    [cell.getOrderBtn addTarget:self action:@selector(didGetOrder:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
    
}
#pragma mark -- cell 的button -->详情页面
- (void)searchListBtnClick:(UIButton *)sender
{
    NSLog(@"进入订单详情");
    
    OrderMarketModel * model = self.distributionDataArray[sender.tag];
    ComplaintOrderDetailsViewController *detailVC = [[ComplaintOrderDetailsViewController alloc]init];
    detailVC.detailUrl = model.orderno;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)didGetOrder:(UIButton *)sender
{
    
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    
    NSLog(@"接单处理%ld",sender.tag);
    OrderMarketModel * model = self.distributionDataArray[sender.tag];
    NSString *orderNum = model.orderno; // 订单号
    
    GetOrderParams *parms = [[GetOrderParams alloc]init];
    parms.orderno = orderNum;
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    parms.marketuserid = userInfo.marketuserid;
    parms.posttypeid = 1;
    [RequestTool getOrder:parms success:^(ResultsModel *result) {
        NSLog(@"%@",result.ModelList);
        [self createDistributionData];
        [loadView stopAnimation];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [loadView stopAnimation];
    }];
    
}

@end
