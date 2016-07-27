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

@interface InviteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;


@end

@implementation InviteViewController

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
}

- (void)GetOrderList
{
    ShopsUserInfo *userInfo = [ShopsUserInfoTool account];
    MarketUserIDParams *params = [[MarketUserIDParams alloc] init];
    params.marketuserid = userInfo.marketuserid;
    [RequestTool untreatedInviteOrderList:params success:^(MarketOrderModelList *result) {
        HDCLog(@"%@", result.ErrorMsg);
    } failure:^(NSError *error) {
        ;
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PickUpCell *cell = [PickUpCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setOrderNumLabelText:@"#54" andOrderNumberLabelText:@"订单号 145443455" andOrderTimeLabelText:@"下单时间 11 -6   09:00" andOrderAddressLabelText:@"紫东国际创意园e1栋3楼"];
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
