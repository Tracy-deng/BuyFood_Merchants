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

@interface ComplaintOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;


@end

@implementation ComplaintOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:WhiteColor];
    // 解决navigationBar影响tableView的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"投诉订单";
    [self setUpTableView];
}
/** 设置tableView */
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc]init];
//    self.tableView.backgroundColor = HDCColor(238, 238, 238);
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ComplaintOrderCell* cell = [ComplaintOrderCell cellWithTableView:tableView];
    [cell setOrderNumLabelText:@"#54" andOrderNumberLabelText:@"订单号  1234567" andGetTimeBtnText:@"蔬菜不新鲜" andOrderTimeLabelText:@"下单时间 11-07      09:00" andOrderAddressLabelText:@"紫东国际创意园区E1栋3楼"];
    [cell.searchListBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)btnClick:(UIButton* )sender
{
    HDCLog(@"查看详情");
    [self.navigationController pushViewController:[[ComplaintOrderDetailsViewController alloc] init] animated:YES];
}
@end
