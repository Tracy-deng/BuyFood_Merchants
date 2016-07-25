//
//  PromotionManagementViewController.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/26.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "PromotionManagementViewController.h"
#import "Masonry.h"
#import "ManagementCell.h"
#import "SalesPromotionViewController.h"
#import "RequestTool.h"
#import "LoadView.h"
#import "SalesProductParams.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "ModlistModel.h"
#import "ResultsModel.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface PromotionManagementViewController ()<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView* tabelView;
@property (nonatomic, strong) NSMutableArray * salesDataArray;

@end

@implementation PromotionManagementViewController
- (NSMutableArray *)salesDataArray
{
    if (_salesDataArray == nil) {
        self.salesDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _salesDataArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"促销管理";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createTabeleViewAndBottomBtn];
    [self getProductSalesData];
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
    UIButton* bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setBackgroundColor:[UIColor colorWithRed:35 / 255.0 green:194 / 255.0 blue:61 / 255.0 alpha:1]];
    [bottomBtn setTitle:@"添加" forState:UIControlStateNormal];
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

- (void)getProductSalesData
{
    NSLog(@"请求促销管理数据");
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    SalesProductParams *params = [[SalesProductParams alloc]init];
    ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];

    params.marketuserid = shopsInfo.marketuserid;

    [RequestTool getSalesProduce:params success:^(ResultsModel *result) {
        
        NSLog(@"请求促销管理数据成功 %@",result.ModelList);
        for (NSDictionary *Pdic in result.ModelList) {
            ModlistModel *model = [[ModlistModel alloc]init];
            [model setValuesForKeysWithDictionary:Pdic];
            [self.salesDataArray addObject:model];
        }
        [self.tabelView reloadData];
        [loadView stopAnimation];
        
    } failure:^(NSError *error) {
        NSLog(@"请求促销管理失败%@",error);
    }];
    
}
- (void)bottomBtnClick:(UIButton* )sender
{
    SalesPromotionViewController *saleVC = [[SalesPromotionViewController alloc] init];
    saleVC.addDataArray = self.salesDataArray;
    [self.navigationController pushViewController:saleVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.salesDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManagementCell* cell = [ManagementCell cellWithTableView:tableView];
    ModlistModel * salesModel = self.salesDataArray [indexPath.row];
 
    
    
    CGFloat stockNumber = [salesModel.productstock floatValue];
    NSString *stock = [NSString stringWithFormat:@"%.2f", stockNumber];
    
    CGFloat originPrice = [salesModel.productoutprice floatValue];
    NSString *oriPrice = [NSString stringWithFormat:@"%.2f",originPrice];
    
    CGFloat nowPrice = [salesModel.productoutprice2 floatValue];
    NSString *nowPricetring = [NSString stringWithFormat:@"%.2f",nowPrice];
    [cell setShopsImage:salesModel.productpic andShopsNameLabel:salesModel.productname andShopsWeight:stock  andShopsSpecifications:[NSString stringWithFormat:@"/%@",salesModel.productunit]andShopsOriginalPriceTitle:@"原价" andShopsOriginalPrice:oriPrice andShopsPromotionPriceTitle:@"促销价" andShopsPromotionPrice:nowPricetring];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height * 0.15;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        
//        [self.tabelView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
        
    }];
    
    topRowAction.backgroundColor = [UIColor colorWithRed:46/255.0 green:192/255.0 blue:70/255.0 alpha:1];

    return @[deleteRowAction,topRowAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
