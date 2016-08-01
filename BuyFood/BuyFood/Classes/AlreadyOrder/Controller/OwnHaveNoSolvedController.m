//
//  OwnHaveNoSolvedController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/17.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OwnHaveNoSolvedController.h"
#import "ownSlovedTableViewCell.h"
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
@interface OwnHaveNoSolvedController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * ownSolvedTableView;
@property (nonatomic, strong) NSMutableArray * noSolvedArray; //
@end

@implementation OwnHaveNoSolvedController
- (NSMutableArray *)noSolvedArray
{
    if (_noSolvedArray == nil) {
        self.noSolvedArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _noSolvedArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   self.view.backgroundColor = [UIColor whiteColor];
    [self creatTableView];
    
    [self getNoSolvedDataSource];
    self.ownSolvedTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNoSolvedDataSource];
    }];
}

- (void)getNoSolvedDataSource
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    OrderParams *params = [[OrderParams alloc] init];
    params.marketuserid = userInfo.marketuserid;
    params.pageindex = @"1";
    params.pagesize = @"10";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [RequestTool alreadySolvedOrderList:params success:^(MarketOrderModelList *result) {
            NSLog(@"%@",result.OrderMarket);
            [self.noSolvedArray removeAllObjects];
            for (NSDictionary *dict in result.OrderMarket) {
                OrderMarketModel *model = [[OrderMarketModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.noSolvedArray addObject:model];
            }
            NSLog(@"%@",self.noSolvedArray);
            [loadView stopAnimation];
            [self.ownSolvedTableView .header endRefreshing];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.ownSolvedTableView reloadData];
            });
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            [loadView stopAnimation];
        }];
        
    });
}
- (void)creatTableView
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = greenColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.height.equalTo(@0.1);
        make.width.equalTo(@(SCREEN_WIDTH/2));
    }];
    
    _ownSolvedTableView = [[UITableView alloc]init];
    [self.view addSubview:_ownSolvedTableView];
    _ownSolvedTableView.delegate = self;
    _ownSolvedTableView.dataSource = self;
    [_ownSolvedTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 44 -64));
    }];
    _ownSolvedTableView.rowHeight = 155;
    _ownSolvedTableView.separatorStyle =  UITableViewCellSeparatorStyleNone; // 删除分割线
    [_ownSolvedTableView registerClass:[ownSlovedTableViewCell class] forCellReuseIdentifier:@"haveView"];
}

/**
 *   实现tableView代理方法
 */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.noSolvedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ownSlovedTableViewCell *cell = [_ownSolvedTableView dequeueReusableCellWithIdentifier:@"haveView"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置分割线颜色
    //    tableView.separatorColor = HDCColor(238, 238, 238);
    
    OrderMarketModel *model = self.noSolvedArray[indexPath.row];
    cell.model = model;
    cell.detailBtn.tag = indexPath.row;
    [cell.detailBtn addTarget:self action:@selector(didDetailBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
    
}


- (void)didDetailBtn:(UIButton *)sender
{
    NSLog(@"进入详情");
    OrderMarketModel * model = self.noSolvedArray[sender.tag];
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
