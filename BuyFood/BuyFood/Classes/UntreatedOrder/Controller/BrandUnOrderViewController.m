//
//  BrandUnOrderViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/7/17.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BrandUnOrderViewController.h"
#import "DispatchCell.h"
#import "ComplaintOrderDetailsViewController.h"

@interface BrandUnOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;

@end

@implementation BrandUnOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationItem.title = @"未处理订单";
    [self.view setBackgroundColor:HDCBackViewColor];
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
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DispatchCell *cell = [DispatchCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setOrderNumberLabelText:@"订单号 145443455" andGetTimeBtnText:@"立即送达" andOrderTimeLabelText:@"下单时间 11 -6   09:00" andOrderAddressLabelText:@"紫东国际创意园e1栋3楼" moneyLabel:@""];
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
