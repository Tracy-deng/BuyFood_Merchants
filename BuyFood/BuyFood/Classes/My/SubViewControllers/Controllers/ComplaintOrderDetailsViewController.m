//
//  ComplaintOrderDetailsViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/20.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ComplaintOrderDetailsViewController.h"

@interface ComplaintOrderDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;


@end

@implementation ComplaintOrderDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCRandomColor];
    self.title = @"投诉订单详情";
    [self setUpTableView];
}

- (void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.userInteractionEnabled = NO;
    [self.view addSubview:self.tableView];
}

- (void)setUpTableViewHeader
{
//    self.tableView.tableHeaderView =
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"哈哈哈哈哈";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.view.height * 0.21;
    }
    else
    {
        return 0;
    }
    
}

- (UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView* headerView = [[UIView alloc] init];
        [headerView setBackgroundColor:HDCColor(250, 250, 250)];
        return headerView;
    }
    else
    {
        return nil;
    }
}




@end
