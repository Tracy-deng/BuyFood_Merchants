//
//  SecondsKillManagementViewController.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "SecondsKillManagementViewController.h"
#import "Masonry.h"
#import "ManagementCell.h"
#import "SecondsKillViewController.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface SecondsKillManagementViewController ()<UITableViewDelegate,
                                                    UITableViewDataSource>
@property (nonatomic, strong) UITableView* tabelView;

@end

@implementation SecondsKillManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"秒杀管理";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createTabeleViewAndBottomBtn];
}
- (void)createTabeleViewAndBottomBtn
{
    self.tabelView = [[UITableView alloc] init];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.view addSubview:self.tabelView];
    [self.tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view).multipliedBy(0.75);
    }];
    UIButton* bottomBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:35 / 255.0 green:194 / 255.0 blue:61 / 255.0 alpha:1]];
    [bottomBtn setTitle:@"添加" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    bottomBtn.layer.cornerRadius = 3.0;
    [bottomBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(21);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.width.equalTo(@(SCREEN_WIDTH - 2 * 21));
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.08);
    }];
}

- (void)bottomBtnClick:(UIButton* )sender
{
    [self.navigationController pushViewController:[[SecondsKillViewController alloc] init] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagementCell *cell = [ManagementCell cellWithOtherTableView:tableView];
    [cell setOtherShopsImage:@"rectangle9" andShopsNameLabel:@"大百草" andShopsWeight:@"222.0" andShopsSpecifications:@"/千克" andShopsOriginalPriceTitle:@"原价" andShopsOriginalPrice:@"18" andShopsPromotionPriceTitle:@"秒杀价" andShopsPromotionPrice:@"¥14" andTime:@"12:00"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height * 0.15;
}




@end
