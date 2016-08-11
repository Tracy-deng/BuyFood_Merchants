//
//  OwnHavePushController.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/17.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OwnHavePushController.h"
#import "pushTableViewCell.h"
#import "alreadyTableViewCell.h"
#import "ComplaintOrderDetailsViewController.h"
#import "ResultsModel.h"
#import "RequestTool.h"
#import "MarketOrderModelList.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "LoadView.h"
#import "MJRefresh.h"
#import "ResultsModel.h"
#import "OrderParams.h"
#import "OrderMarketModel.h"
@interface OwnHavePushController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIButton *pushBtn;
@property (nonatomic, strong) UIButton *alreadBtn;
@property (nonatomic, strong) UITableView * mainPushTabview;
@property (nonatomic, assign) BOOL isSelected;  //判断加载哪个cell
@property (nonatomic, strong) NSMutableArray * inviteDataArray; // 配送中的数据源
@property (nonatomic, strong) NSMutableArray * havePushedDataArray; // 已完成的数据源
@end

@implementation OwnHavePushController
- (NSMutableArray *)inviteDataArray{
    if (_inviteDataArray == nil) {
        self.inviteDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _inviteDataArray;
}
- (NSMutableArray *)havePushedDataArray{
    if (_havePushedDataArray == nil) {
        self.havePushedDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _havePushedDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSegmentControl];
    self.view.backgroundColor = HDCColor(238, 238, 238);
    [self creatTableView];
    _isSelected = YES;
    [self getHavePushedDataSource];
    
    self.mainPushTabview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_isSelected == YES) {
            [self getHavePushedDataSource];
        }else{
            [self getPushedData];
        }
    }];
}

// 配送中
-(void)getHavePushedDataSource
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    OrderParams *params = [[OrderParams alloc] init];
    params.marketuserid = userInfo.marketuserid;
    params.pageindex = @"1";
    params.pagesize = @"0";
    
     if ([userInfo.markettypeid isEqualToString:@"1" ]|| [userInfo.markettypeid isEqualToString:@"2"] ) {
         
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             
             [RequestTool alreadyDistributionOrderList:params success:^(MarketOrderModelList *result) {
                 HDCLog(@"%@", result.OrderMarket);
                 [self.inviteDataArray removeAllObjects];
                 for (NSDictionary *dict in result.OrderMarket) {
                     OrderMarketModel *model = [[OrderMarketModel alloc]init];
                     [model setValuesForKeysWithDictionary:dict];
                     [self.inviteDataArray addObject:model];
                 }
                 [loadView stopAnimation];
                 NSLog(@"%@",self.inviteDataArray);
                 [self.mainPushTabview.header endRefreshing];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.mainPushTabview reloadData];
                 });
                 
             } failure:^(NSError *error) {
                 ;
                 NSLog(@"%@",error);
                 [loadView stopAnimation];
             }];
             
         });
     }else{
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             
             [RequestTool alreadyBandDistributionOrderList:params success:^(MarketOrderModelList *result) {
                 HDCLog(@"%@", result.OrderMarket);
                 [self.inviteDataArray removeAllObjects];
                 for (NSDictionary *dict in result.OrderMarket) {
                     OrderMarketModel *model = [[OrderMarketModel alloc]init];
                     [model setValuesForKeysWithDictionary:dict];
                     [self.inviteDataArray addObject:model];
                 }
                 [loadView stopAnimation];
                 NSLog(@"%@",self.inviteDataArray);
                 [self.mainPushTabview.header endRefreshing];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.mainPushTabview reloadData];
                 });
                 
             } failure:^(NSError *error) {
                 ;
                 NSLog(@"%@",error);
                 [loadView stopAnimation];
             }];
             
         });
     }
    

}


//  已完成
-(void)getPushedData
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    OrderParams *params = [[OrderParams alloc] init];
    params.marketuserid = userInfo.marketuserid;
    params.pageindex = @"1";
    params.pagesize = @"10";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [RequestTool alreadyDistributionOverOrderList:params success:^(MarketOrderModelList *result) {
            HDCLog(@"%@", result.OrderMarket);
            [self.havePushedDataArray removeAllObjects];
            for (NSDictionary *dict in result.OrderMarket) {
                OrderMarketModel *model = [[OrderMarketModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.havePushedDataArray addObject:model];
            }
            [loadView stopAnimation];
            NSLog(@"%@",self.havePushedDataArray);
            [self.mainPushTabview.header endRefreshing];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.mainPushTabview reloadData];
            });
            
        } failure:^(NSError *error) {
            ;
            NSLog(@"%@",error);
            [loadView stopAnimation];
        }];
        
    });
    
}

- (void)addSegmentControl
{
    _view1 = [[UIView alloc]init];
    _view1.backgroundColor = greenColor;
    [self.view addSubview:_view1];
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.height.equalTo(@33);
        make.width.equalTo(@(SCREEN_WIDTH/2));
    }];
    
    _view2 = [[UIView alloc]init];
    _view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view2];
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.width.equalTo(_view1);
        make.left.equalTo(_view1.mas_right);
    }];
    
    _pushBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [_pushBtn setTitle:@"配送中" forState:(UIControlStateNormal)];
    [_pushBtn setTitleColor:greenColor forState:(UIControlStateNormal)];
    _pushBtn.backgroundColor = [UIColor whiteColor];
    _pushBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_view1 addSubview:_pushBtn];
    [_pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.left.equalTo(_view1);
        make.height.equalTo(@30);
    }];
    [_pushBtn addTarget:self action:@selector(didPushBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    _alreadBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_alreadBtn setTitle:@"已送达" forState:(UIControlStateNormal)];
    _alreadBtn.backgroundColor = [UIColor whiteColor];
    [_alreadBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _alreadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_view2 addSubview:_alreadBtn];
    [_alreadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.width.equalTo(_view2);
        make.height.equalTo(@30);
    }];
    [_alreadBtn addTarget:self action:@selector(didAlreadyBtn:) forControlEvents:(UIControlEventTouchUpInside)];
   
}
// 点击配送中
- (void)didPushBtn:(UIButton *)sender
{
    [sender setTitleColor:greenColor forState:(UIControlStateNormal)];
    _view1.backgroundColor = greenColor;
    
    [_alreadBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _view2.backgroundColor = [UIColor whiteColor];
    _isSelected = YES;
    [self getHavePushedDataSource]; // 配送中
    [self.mainPushTabview reloadData];
}

// 点击已送达
- (void)didAlreadyBtn:(UIButton *)sender
{
   [sender setTitleColor:greenColor forState:(UIControlStateNormal)];
    _view2.backgroundColor = greenColor;
    
    [_pushBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _view1.backgroundColor = [UIColor whiteColor];
    _isSelected = NO;
    [self getPushedData]; // 已完成
    [self.mainPushTabview reloadData];
    
}

- (void)creatTableView
{
    _mainPushTabview = [[UITableView alloc]init];
    _mainPushTabview.rowHeight = 155;
    [self.view addSubview:_mainPushTabview];
    _mainPushTabview.delegate = self;
    _mainPushTabview.dataSource = self;
    [_mainPushTabview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view1.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 64 - 33 -44));
    }];
    _mainPushTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainPushTabview registerClass:[pushTableViewCell class] forCellReuseIdentifier:@"push"];
    [self.mainPushTabview registerClass:[alreadyTableViewCell class] forCellReuseIdentifier:@"already"];
}
#pragma mark -- TableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSelected == YES) {
        
        return self.inviteDataArray.count;
    }else{
        
        return self.havePushedDataArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (_isSelected == YES) {
        OrderMarketModel * model = self.inviteDataArray[indexPath.row];
         pushTableViewCell *cell = [_mainPushTabview dequeueReusableCellWithIdentifier:@"push"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.detailBtn.tag = indexPath.row;
        [cell.detailBtn addTarget:self action:@selector(didDetailBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.model = model;
        return cell;
    }else{
        OrderMarketModel * model = self.havePushedDataArray[indexPath.row];
        alreadyTableViewCell *cell = [_mainPushTabview dequeueReusableCellWithIdentifier:@"already"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        
        cell.detailBtn.tag = indexPath.row;
        [cell.detailBtn addTarget:self action:@selector(didDetailBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }
   

}

- (void)didDetailBtn:(UIButton *)sender
{
    NSLog(@"进入详情");
    
    ComplaintOrderDetailsViewController *detailVC = [[ComplaintOrderDetailsViewController alloc]init];
    if (_isSelected == YES) {
        OrderMarketModel * model = self.inviteDataArray[sender.tag];
        detailVC.detailUrl = model.orderno;
    }else if(_isSelected == NO)
    {
        OrderMarketModel * model = self.havePushedDataArray[sender.tag];
        detailVC.detailUrl = model.orderno;
    }
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
