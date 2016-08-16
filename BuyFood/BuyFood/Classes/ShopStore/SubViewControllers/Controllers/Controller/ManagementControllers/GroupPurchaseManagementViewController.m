//
//  GroupPurchaseManagementViewController.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "GroupPurchaseManagementViewController.h"
#import "Masonry.h"
#import "ManagementCell.h"
#import "GroupPurchaseViewController.h"
#import "MarketUserIdParams.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "RequestTool.h"
#import "ResultsModel.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface GroupPurchaseManagementViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView* tabelView;
@property (nonatomic, strong) ShopsUserInfo *userInfo;


@end

@implementation GroupPurchaseManagementViewController
{
    NSMutableArray *dataSource;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"团购管理";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createTabeleViewAndBottomBtn];
    self.userInfo = [ShopsUserInfoTool account];
    
    [self prepareGroupBuyDataSource];
}

- (void)prepareGroupBuyDataSource
{
    [MBProgressHUD showMessage:@"数据加载中..."];
    MarketUserIdParams *params = [[MarketUserIdParams alloc] init];
    params.marketuserid = self.userInfo.marketuserid;
    params.pagesize = @"0";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [RequestTool groupBuyList:params success:^(ResultsModel *result) {
            if (![result.totalcount isEqualToString:@"0"])
            {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showSuccess:@"数据加载成功"];
//                dataSource = [OutDoorModelList mj_objectArrayWithKeyValuesArray:result.ModelList];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.tabelView reloadData];
//                    [self.tabelView.header endRefreshing];
//                });
            }
            else
            {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"暂无数据"];
//                [self.tabelView.header endRefreshing];
            }
            
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"数据加载失败"];
//            [self.tabelView.header endRefreshing];
        }];
    });
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
    self.tabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
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
    [self.navigationController pushViewController:[[GroupPurchaseViewController alloc] init] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagementCell *cell = [ManagementCell cellWithOtherTableView:tableView];
    [cell setOtherShopsImage:@"rectangle9" andShopsNameLabel:@"大百草" andShopsWeight:@"222.0" andShopsSpecifications:@"/千克" andShopsOriginalPriceTitle:@"原价" andShopsOriginalPrice:@"18" andShopsPromotionPriceTitle:@"团购价" andShopsPromotionPrice:@"¥14" andTime:@"12:00开团"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height * 0.15;
}





@end
