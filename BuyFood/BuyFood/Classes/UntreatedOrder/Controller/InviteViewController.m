//
//  InviteViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "InviteViewController.h"
#import "PickUpCell.h"
#import "ComplaintOrderDetailsViewController.h"
#import "MarketOrderModelList.h"
#import "RequestTool.h"
#import "MarketUserIDParams.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "OrderMarketModel.h"
#import "LoadView.h"
#import "MJRefresh.h"
@interface InviteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray * inviteDataArray;

@end

@implementation InviteViewController

- (NSMutableArray *)inviteDataArray{
    if (_inviteDataArray == nil) {
        self.inviteDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _inviteDataArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    self.tableView = [[UITableView alloc]init];
    self.tableView.backgroundColor = HDCColor(238, 238, 238);
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 44));
    }];
    self.tableView.rowHeight = 155;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone; // 删除分割线
    [self GetOrderList];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self GetOrderList];
    }];
}

- (void)GetOrderList
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    MarketUserIDParams *params = [[MarketUserIDParams alloc] init];
    params.marketuserid = userInfo.marketuserid;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [RequestTool untreatedInviteOrderList:params success:^(MarketOrderModelList *result) {
            HDCLog(@"%@", result.OrderMarket);
            [self.inviteDataArray removeAllObjects];
            for (NSDictionary *dict in result.OrderMarket) {
                NSLog(@"%@",dict[@"OrderDetailList"]);
                OrderMarketModel *model = [[OrderMarketModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.inviteDataArray addObject:model];
            }
            [loadView stopAnimation];
            NSLog(@"%@",self.inviteDataArray);
            [self.tableView.header endRefreshing];
            
        dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
        });
           
        } failure:^(NSError *error) {
            ;
            NSLog(@"%@",error);
            [loadView stopAnimation];
        }];

    });
    }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.inviteDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PickUpCell *cell = [PickUpCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    OrderMarketModel * model = self.inviteDataArray[indexPath.row];
    
    [cell setOrderNumberLabelText:model.orderno andOrderTimeLabelText:model.ordertime andOrderAddressLabelText:model.marketuseraddress moneyLabel:model.markettotalmoney];
  
    cell.searchListBtn.tag = indexPath.row;
    [cell.searchListBtn addTarget:self action:@selector(searchListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

#pragma mark -- cell 的button -->详情页面
- (void)searchListBtnClick:(UIButton *)sender
{
    NSLog(@"进入订单详情");
    
    
    ComplaintOrderDetailsViewController *detailVC = [[ComplaintOrderDetailsViewController alloc]init];
    
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
