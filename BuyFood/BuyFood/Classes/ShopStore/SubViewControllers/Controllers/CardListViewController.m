//
//  CardListViewController.m
//  CashIn【提现】
//
//  Created by 黄栋春 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "CardListViewController.h"
#import "TakeMoneyViewController.h"

@interface CardListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
     NSInteger current;
}

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray *array;


@end

@implementation CardListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:WhiteColor];
    self.title = @"选择提现方式";
    [self createTableViewAndBtn];
    self.array = @[@"支付宝",
                   @"银行卡"];
}

- (void)createTableViewAndBtn
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];//关键语句
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.view);
        make.height.equalTo(@(200));
    }];
    /** 设置按钮 */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:greenColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5.0;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.equalTo(@(150));
        make.height.equalTo(@(40));
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.row == current)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = self.array[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    current = indexPath.row;
    [self.tableView reloadData];
}

- (void)buttonClick:(UIButton *)sender
{
    TakeMoneyViewController *takeMoney = [[TakeMoneyViewController alloc] init];
    takeMoney.selectIndex = current;
    [self.navigationController pushViewController:takeMoney animated:YES];

}



@end
