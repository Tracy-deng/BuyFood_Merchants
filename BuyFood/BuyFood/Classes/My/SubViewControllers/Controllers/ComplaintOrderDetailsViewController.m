//
//  ComplaintOrderDetailsViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/20.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ComplaintOrderDetailsViewController.h"
#import "HeaderView.h"
#import "OrderListCell.h"
#import "FooterView.h"
#import "OrderDetailModel.h"
#import "LoadView.h"
#import "RequestTool.h"
#import "OrderDetailsParams.h"
#import "MarketOrderModelList.h"
#import "OrderDetailModel.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
@interface ComplaintOrderDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    OrderDetailModel *detailModel;
    OrderDetailModel * productEveryModel;
    UIButton* bottomBtn;  // 联系卖家
    
}

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray * productDetailData;

@end

@implementation ComplaintOrderDetailsViewController
- (NSMutableArray *)productDetailData
{
    if (_productDetailData == nil) {
        self.productDetailData = [NSMutableArray arrayWithCapacity:0];
    }
    return _productDetailData;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    self.title = @"订单详情";
    
    [self creatDataDetailSource];
    [self setUpBottomBtn];
}

-(void)creatDataDetailSource
{

    LoadView *loadView = [LoadView new];
    [loadView startAnimation];

        OrderDetailsParams *parms = [[OrderDetailsParams alloc]init];
        parms.orderno = self.detailUrl;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [RequestTool orderDetails:parms success:^(MarketOrderModelList *result) {
                NSLog(@"%@",result.OrderMarket);
                for (NSDictionary *detailPdic in result.OrderMarket) {
                    productEveryModel = [[OrderDetailModel alloc]init];
                    [productEveryModel setValuesForKeysWithDictionary:detailPdic];
                    [self.productDetailData addObject:productEveryModel];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [loadView stopAnimation];
                    [self setUpTableView];
                    [self.tableView reloadData];
                });
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
                [loadView stopAnimation];
            }];
        });
    
}
/** 设置tableView */
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
/** 设置tableView的头部视图 */
- (void)setUpTableViewHeader
{
    HeaderView* headerView = [HeaderView initWithHeaderView];
    headerView.height = SCREEN_HEIGHT* 0.39;
    [headerView setUpContentView];
    
    [headerView setOrderNumberLabelText:[NSString stringWithFormat:@"订单号 %@",productEveryModel.orderno] andGetTimeBtnText:@"" andOrderTimeLabelText:[NSString stringWithFormat:@"下单时间 %@",productEveryModel.ordertime] andOrderAddressLabelText:productEveryModel.useraddress];
    self.tableView.tableHeaderView = headerView;
}
#pragma tableViewDelegate UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return productEveryModel.OrderDetailList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListCell* cell = [OrderListCell cellWithTableView:tableView];

    NSDictionary * p =  productEveryModel.OrderDetailList[indexPath.row];
    OrderDetailModel * detail = [[OrderDetailModel alloc]init];
    [detail setValuesForKeysWithDictionary:p];
     [cell setUpFoodNameLabel:detail.productname andNumberLabel:[NSString stringWithFormat:@"%ld",(long)detail.productcount] andMoneyLabel:[NSString stringWithFormat:@"%.2f",detail.productprice]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView* )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] init];
    [headerView setBackgroundColor:[UIColor clearColor]];
    UILabel* shopStoreName = [[UILabel alloc] init];
    ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];
    shopStoreName.text =  shopsInfo.marketname;
    shopStoreName.textColor = HDCColor(43, 131, 56);
    [headerView addSubview:shopStoreName];
    [shopStoreName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView.mas_top).offset(10);
        make.left.equalTo(headerView.mas_left).offset(30);
        make.width.equalTo(@68);
        make.height.equalTo(@24);
    }];

    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.view.height * 0.10;
}

- (UIView* )tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    FooterView* footerView = [FooterView initWithFooterView];
    [footerView setUpContentView];
    [footerView setUpMoneyLabel:[NSString stringWithFormat:@"%.2f",productEveryModel.markettotalmoney] andOrderNumberLabel:[productEveryModel.orderno substringFromIndex:productEveryModel.orderno.length - 4]];
    return footerView;
}

/** 设置底部【联系买家】按钮 */
- (void)setUpBottomBtn
{
    bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 12"] forState:UIControlStateNormal];
    [bottomBtn setTitle:@"联系买家" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:HDCColor(36, 197, 67) forState:UIControlStateNormal];
    [self.view addSubview:bottomBtn];
    [bottomBtn addTarget:self action:@selector(didPhone:) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.equalTo(@40);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.56);
    }];
}
- (void)didPhone:(UIButton *)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%ld",productEveryModel.telephone]];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}
@end
