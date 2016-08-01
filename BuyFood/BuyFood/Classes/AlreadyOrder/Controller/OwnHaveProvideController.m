//
//  OwnHaveProvideController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/17.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OwnHaveProvideController.h"
#import "haveTableViewCell.h"
#import "ComplaintOrderDetailsViewController.h"
#import "ResultsModel.h"
#import "RequestTool.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "LoadView.h"
#import "MJRefresh.h"
#import "OrderParams.h"
#import "OrderMarketModel.h"
#import "MarketOrderModelList.h"
@interface OwnHaveProvideController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *haveTableView;
@property (nonatomic, strong) NSMutableArray * inviteDataArray;
@end

@implementation OwnHaveProvideController
- (NSMutableArray *)inviteDataArray{
    if (_inviteDataArray == nil) {
        self.inviteDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _inviteDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _haveTableView = [[UITableView alloc]init];
    [self.view addSubview:_haveTableView];
    _haveTableView.delegate = self;
    _haveTableView.dataSource = self;
    [_haveTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 44));
    }];
    _haveTableView.rowHeight = 155;
    _haveTableView.separatorStyle =  UITableViewCellSeparatorStyleNone; // 删除分割线
    [_haveTableView registerClass:[haveTableViewCell class] forCellReuseIdentifier:@"haveView"];

    [self getOwnHabveProvideData];
    self.haveTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getOwnHabveProvideData];
    }];
}


- (void)getOwnHabveProvideData
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    OrderParams *params = [[OrderParams alloc] init];
    params.marketuserid = userInfo.marketuserid;
    params.pageindex = @"1";
    params.pagesize = @"10";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [RequestTool alreadyInviteOrderList:params success:^(MarketOrderModelList *result) {
            HDCLog(@"%@", result.OrderMarket);
            [self.inviteDataArray removeAllObjects];
            for (NSDictionary *dict in result.OrderMarket) {
                OrderMarketModel *model = [[OrderMarketModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.inviteDataArray addObject:model];
            }
            [loadView stopAnimation];
            NSLog(@"%@",self.inviteDataArray);
            [self.haveTableView.header endRefreshing];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.haveTableView reloadData];
            });

        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [loadView stopAnimation];
        }];
    });
    
}
/**
 *   实现tableView代理方法
 */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.inviteDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    haveTableViewCell *cell = [_haveTableView dequeueReusableCellWithIdentifier:@"haveView"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置分割线颜色
//    tableView.separatorColor = HDCColor(238, 238, 238);
    OrderMarketModel * model = self.inviteDataArray[indexPath.row];

    cell.model = model;
    
    cell.detailBtn.tag = indexPath.row;
    // 点击进详情
    [cell.detailBtn addTarget:self action:@selector(buttonAutoDetail:) forControlEvents:(UIControlEventTouchUpInside)];
   
    
    return cell;
    
}

#pragma mark -- cell 的button -->详情页面
- (void)buttonAutoDetail:(UIButton *)sender
{
    NSLog(@"进入订单详情");
    
    OrderMarketModel * model = self.inviteDataArray[sender.tag];
    ComplaintOrderDetailsViewController *detailVC = [[ComplaintOrderDetailsViewController alloc]init];
    detailVC.detailUrl = model.orderno;
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
