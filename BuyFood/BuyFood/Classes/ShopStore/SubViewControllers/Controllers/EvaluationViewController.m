//
//  EvaluationViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "EvaluationViewController.h"
#import "EvaluationHeaderView.h"

@interface EvaluationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) EvaluationHeaderView* contentHeaderView;

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIView* footerView;


@end

@implementation EvaluationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"评价详情";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self setUpContentHeaderView];
    [self createTableViewCell];
    self.footerView = [[UIView alloc] init];
    self.footerView.backgroundColor = [UIColor redColor];
    self.footerView.hidden = YES;
}

- (void)setUpContentHeaderView
{
     self.contentHeaderView = [EvaluationHeaderView initEvaluationHeaderView];
    [self.contentHeaderView creatHeaderContentView];
    [self.contentHeaderView setOrderNumberLabel:@"688" andGreatEvaluationLabel:@"97%"];
    [self.contentHeaderView setBackgroundColor:HDCColor(250, 250, 250)];
    [self.view addSubview:self.contentHeaderView];
    [self.contentHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(64);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.14);
    }];
}

- (void)createTableViewCell
{
    UILabel* titleForHeader = [[UILabel alloc] init];
    titleForHeader.backgroundColor = [UIColor clearColor];
    titleForHeader.text = @"评价详情";
    titleForHeader.textColor = HDCColor(153, 153, 153);
    titleForHeader.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    [self.view addSubview:titleForHeader];
    [titleForHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentHeaderView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.width.equalTo(self.view);
        make.height.equalTo(@30);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleForHeader.mas_bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.70);
    }];
}
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
    static NSString* ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"110";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
}
- (UIView* )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footerView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.footerView.hidden = !self.footerView.hidden;
}

@end
