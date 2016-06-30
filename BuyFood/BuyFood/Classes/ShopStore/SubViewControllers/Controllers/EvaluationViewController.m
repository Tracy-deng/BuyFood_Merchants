//
//  EvaluationViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "EvaluationViewController.h"
#import "EvaluationHeaderView.h"
#import "EvaluationFooterView.h"
#import "EvaluateCell.h"

@interface EvaluationViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL  Display[100];
    
}
@property (nonatomic, strong) EvaluationHeaderView* contentHeaderView;

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) EvaluationFooterView* footerView;

@end

@implementation EvaluationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"评价详情";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self setUpContentHeaderView];
    [self createTableViewCell];
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
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight= 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
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
    if (Display[section] == YES)
    {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EvaluateCell* cell = [EvaluateCell cellWithTableView:tableView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.view.height * 0.12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.height * 0.17;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.footerView = [EvaluationFooterView initFootView];
    self.footerView.userInteractionEnabled = YES;
    self.footerView.tag = section;
    [self.footerView setBackgroundColor:[UIColor whiteColor]];
    [self.footerView setUpContentView];
    [self.footerView setFooterViewContentWithHeaderImage:@"rectangle9" andUserName:@"小张" andEvaluate:@"好评" andEvaluateContent:@"很好吃，配送很及时" andEvaluateTime:@"13：14"];
    if (section != 0)
    {
        UILabel* line1 = [[UILabel alloc] initWithFrame:CGRectMake(5, self.footerView.height, self.view.frame.size.width - 10, 1)];
        [line1 setBackgroundColor:[UIColor grayColor]];
        [self.footerView addSubview:line1];
    }
    [self.footerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(display1:)]];
    [self.footerView.replyBtn addTarget:self action:@selector(replyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.footerView.replyBtn.tag = section;
    return self.footerView;
}

- (void)display1:(UITapGestureRecognizer *)tap
{
    NSInteger section = tap.view.tag;
    Display[section] = YES;
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:tap.view.tag];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}
- (void)replyBtnClick:(UIButton* )sender
{
    NSLog(@"。。。。");
    NSLog(@"%ld",sender.tag);
    Display[sender.tag] = NO;
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:sender.tag];
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

@end
