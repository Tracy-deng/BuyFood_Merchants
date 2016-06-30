//
//  TakeMoneyViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/7/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "TakeMoneyViewController.h"
#import "TakeMoneyCell.h"

@interface TakeMoneyViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;


@end

@implementation TakeMoneyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCBackViewColor];
    self.title = @"取现";
    [self setUpTableViewAndBtn];
}

- (void)setUpTableViewAndBtn
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(0);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.60);
    }];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:HDCColor(35, 194, 61)];
    btn.layer.cornerRadius = 3.0;
    [btn setTitle:@"提交审核" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(21);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-100);
        make.width.equalTo(@(SCREEN_WIDTH - 2 * 21));
        make.height.equalTo(@(50));
    }];
}

- (void)btnClick:(UIButton* )sender
{
    HDCLog(@"提交审核");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 2)
        {
            static NSString* ID = @"Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
            
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            }
            
            cell.textLabel.text = @"中国农业银行";
            cell.textLabel.textColor = HDCColor(102, 102, 102);
            cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
            return cell;
        }
        else
        {
            TakeMoneyCell* cell = [TakeMoneyCell cellWithTableView:tableView];
            switch (indexPath.row)
            {
                case 0:
                    [cell setUpTitleText:@"姓名" andInputTextPlaceholder:@"请输入姓名" andInputText:@""];
                    break;
                case 1:
                    [cell setUpTitleText:@"卡号" andInputTextPlaceholder:@"23435344564" andInputText:@""];
                default:
                    break;
            }
            return cell;
        }
        
    }
    else
    {
        TakeMoneyCell* cell = [TakeMoneyCell cellWithTableView:tableView];
        [cell setUpTitleText:@"提现金额" andInputTextPlaceholder:@"最多可提现5000" andInputText:@""];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}




@end
