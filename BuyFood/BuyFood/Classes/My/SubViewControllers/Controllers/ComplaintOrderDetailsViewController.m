//
//  ComplaintOrderDetailsViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/20.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ComplaintOrderDetailsViewController.h"
//#import "HeaderView.h"

@interface ComplaintOrderDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;


@end

@implementation ComplaintOrderDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    // 解决navigationBar影响tableView的问题
    self.title = @"投诉订单详情";
    [self setUpTableView];
}

- (void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = HDCColor(238, 238, 238);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone; // 删除分割线
    [self setUpTableViewHeader];
}

- (void)setUpTableViewHeader
{
//    HeaderView* headerView = [HeaderView initWithHeaderView];
//    headerView.height = self.view.height * 0.30;
//    [headerView setUpContentView];
//    [headerView setOrderNumLabelText:@"#54" andOrderNumberLabelText:@"订单号 145443455" andGetTimeBtnText:@"不新鲜" andOrderTimeLabelText:@"下单时间 11 -6   09:00" andOrderAddressLabelText:@"紫东国际创意园e1栋3楼"];
//    self.tableView.tableHeaderView = headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    [cell.contentView setBackgroundColor:[UIColor redColor]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.height * 0.10;
}

- (UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] init];
    [headerView setBackgroundColor:[UIColor clearColor]];
    UILabel* shopStoreName = [[UILabel alloc] init];
    shopStoreName.text = @"天天蔬菜";
    shopStoreName.textColor = HDCColor(43, 131, 56);
    [headerView addSubview:shopStoreName];
    [shopStoreName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_top).offset(5);
        make.left.equalTo(headerView.mas_left).offset(30);
        make.width.equalTo(@68);
        make.height.equalTo(@24);
    }];
    return headerView;
}




@end
