//
//  OutdoorActivitiesManagementViewController.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OutdoorActivitiesManagementViewController.h"
#import "Masonry.h"
#import "ManagementCell.h"
#import "OutdoorActivitiesViewController.h"
#import "RequestTool.h"
#import "ResultsModel.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "MarketUserIdParams.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface OutdoorActivitiesManagementViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView* tabelView;
@property (nonatomic, strong) ShopsUserInfo *userInfo;


@end

@implementation OutdoorActivitiesManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"户外活动管理";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createTabeleViewAndBottomBtn];
    self.userInfo = [ShopsUserInfoTool account];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MarketUserIdParams *params = [[MarketUserIdParams alloc] init];
    params.marketuserid = self.userInfo.marketuserid;
    [RequestTool outDoorList:params success:^(ResultsModel *result) {
        HDCLog(@"%@", result.ModelList);
    } failure:^(NSError *error) {
        ;
    }];
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
    [self.navigationController pushViewController:[[OutdoorActivitiesViewController alloc] init] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagementCell *cell = [ManagementCell cellWithOtherTableView:tableView];
    cell.shopsWeight.hidden = YES;
    cell.shopsSpecifications.hidden = YES;
    [cell setOtherShopsImage:@"rectangle9" andShopsNameLabel:@"半马" andShopsWeight:nil andShopsSpecifications:nil andShopsOriginalPriceTitle:@"人数:" andShopsOriginalPrice:@"100人" andShopsPromotionPriceTitle:@"报名费" andShopsPromotionPrice:@"¥88" andTime:@"15:00开跑"];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height * 0.15;
}



@end
