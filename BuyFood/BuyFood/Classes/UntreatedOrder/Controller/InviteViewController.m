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
#import "OrderParams.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "OrderMarketModel.h"
#import "LoadView.h"
#import "MJRefresh.h"
#import "GetOrderParams.h"
#import "ResultsModel.h"
#import "OrderDetailsParams.h"
#import "PrinterToos.h"
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
    
    /** 接收通知 */
    //获取通知中心
    NSNotificationCenter * center =[NSNotificationCenter defaultCenter];
    
    //添加观察者 Observer表示观察者  reciveNotice:表示接收到的消息  name表示再通知中心注册的通知名  object表示可以相应的对象 为nil的话表示所有对象都可以相应
    [center addObserver:self selector:@selector(reciveNotice:) name:@"Invitenotice" object:nil];
}

- (void)reciveNotice:(NSNotification *)notification
{
    
    HDCLog(@"收到消息啦!!!");
    
    NSString *str = [notification.userInfo objectForKey:@"InviteOrderno"];
    HDCLog(@"接收到的订单号: ===== %@", str);
    
    GetOrderParams *parms = [[GetOrderParams alloc]init];
    parms.orderno = str;
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    parms.marketuserid = userInfo.marketuserid;
    parms.posttypeid = 1;
    [RequestTool getOrder:parms success:^(ResultsModel *result) {
        NSLog(@"%@",result.ModelList);
        if([result.ErrorCode isEqualToString:@"1"]){
            [self creatDataDetailSource:parms.orderno];
        }
        [self GetOrderList];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

- (void)GetOrderList
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    OrderParams *params = [[OrderParams alloc] init];
    params.marketuserid = userInfo.marketuserid;
    params.pageindex = @"1";
    params.pagesize = @"10";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [RequestTool untreatedInviteOrderList:params success:^(MarketOrderModelList *result) {
//            HDCLog(@"%@", result.OrderMarket);
            [self.inviteDataArray removeAllObjects];
            for (NSDictionary *dict in result.OrderMarket) {
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
    [cell setOrderNumberLabelText:model.orderno andOrderTimeLabelText:model.ordertime andOrderAddressLabelText:model.useraddress moneyLabel:model.markettotalmoney];
  
    cell.searchListBtn.tag = indexPath.row;
    [cell.searchListBtn addTarget:self action:@selector(searchListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 接单
    cell.getOrderBtn.tag = indexPath.row;
    [cell.getOrderBtn addTarget:self action:@selector(didGetOrder:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 取消订单
    cell.noGetOrderBtn.tag = indexPath.row;
    [cell.noGetOrderBtn addTarget:self action:@selector(noOrderBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
    
}

#pragma mark -- cell 的button -->详情页面
- (void)searchListBtnClick:(UIButton *)sender
{
    NSLog(@"进入订单详情");
    
     OrderMarketModel * model = self.inviteDataArray[sender.tag];
    ComplaintOrderDetailsViewController *detailVC = [[ComplaintOrderDetailsViewController alloc]init];
    detailVC.detailUrl = model.orderno;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didGetOrder:(UIButton *)sender
{
   
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    
    NSLog(@"接单处理%ld",(long)sender.tag);
    OrderMarketModel * model = self.inviteDataArray[sender.tag];
    NSString *orderNum = model.orderno; // 订单号
    
    GetOrderParams *parms = [[GetOrderParams alloc]init];
    parms.orderno = orderNum;
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    parms.marketuserid = userInfo.marketuserid;
    parms.posttypeid = 1;
    [RequestTool getOrder:parms success:^(ResultsModel *result) {
        NSLog(@"%@",result.ModelList);
        if([result.ErrorCode isEqualToString:@"1"]){
            [self creatDataDetailSource:parms.orderno];
        }
        [self GetOrderList];
        [loadView stopAnimation];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [loadView stopAnimation];
    }];
    
}
// 取消定单
-(void)noOrderBtn:(UIButton *)sender
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    
    NSLog(@"取消订单");
    OrderMarketModel * model = self.inviteDataArray[sender.tag];
    NSString *orderNum = model.orderno; // 订单号

    GetOrderParams *parms = [[GetOrderParams alloc]init];
    parms.orderno = orderNum;
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    parms.marketuserid = userInfo.marketuserid;
    [RequestTool noGetOrder:parms success:^(ResultsModel *result) {
        NSLog(@"%@",result.ModelList);
        [self GetOrderList];
        [loadView stopAnimation];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [loadView stopAnimation];
    }];
    
    
}

-(void)creatDataDetailSource:(NSString *)orderNum
{
    
    OrderDetailsParams *parms = [[OrderDetailsParams alloc]init];
    parms.orderno = orderNum;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [RequestTool orderDetails:parms success:^(MarketOrderModelList *result) {
            NSLog(@"%@",result.OrderMarket);
            
            if (result.OrderMarket.count != 0) {
                [[PrinterToos sharePrinterToos]printerTicket:result.OrderMarket];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    });
    
}
@end
