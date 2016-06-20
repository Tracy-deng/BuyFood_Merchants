//
//  PickUpViewController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/15.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "PickUpViewController.h"
#import "PickUpCell.h"
#import "OrderDetailsViewController.h"

@interface PickUpViewController ()

@end

@implementation PickUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PickUpCell* cell = [PickUpCell cellWithTableView:tableView];
    [cell setOrderNumLabelText:@"#54" andOrderNumberLabelText:@"订单号  1234567" andOrderTimeLabelText:@"下单时间 11-07      09:00" andOrderAddressLabelText:@"紫东国际创意园区E1栋3楼"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.height * 0.23;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
- (UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] init];
    headerView.layer.masksToBounds = YES;
    headerView.layer.cornerRadius = 2;
    [headerView setBackgroundColor:HDCColor(35, 189, 52)];
    return headerView;
}

- (UIView* )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* footerView = [[UIView alloc] init];
    footerView.layer.masksToBounds = YES;
    footerView.layer.cornerRadius = 2;
    UILabel* tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    tagLabel.text = @"合计";
    tagLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    [footerView addSubview:tagLabel];
    UILabel* moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(tagLabel.x + tagLabel.width, tagLabel.y, tagLabel.width + 10, tagLabel.height)];
    moneyLabel.text = @"¥50";
    moneyLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:15];
    moneyLabel.textColor = HDCColor(38, 38, 38);
    [footerView addSubview:moneyLabel];
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(self.view.width - self.view.width * 0.19 - 30, tagLabel.y, self.view.width * 0.30, tagLabel.height)];
    [btn setTitle:@"查看详情" forState:UIControlStateNormal];
    [btn setTitleColor:HDCColor(63, 200, 67) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btn];
    UIView* divisionView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, 10)];
    [divisionView setBackgroundColor:HDCColor(238, 238, 238)];
    [footerView addSubview:divisionView];
    footerView.backgroundColor = HDCColor(250, 250, 250);
    return footerView;
}

- (void)btnClick:(UIButton* )sender
{
    HDCLog(@"查看详情");
    [self.navigationController pushViewController:[[OrderDetailsViewController alloc] init] animated:YES];
}

@end
