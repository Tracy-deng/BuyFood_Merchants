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
#import "MJRefresh.h"
#import "DeleteProductParams.h"
#import "MBProgressHUD.h"
#import "ChangePromotionViewController.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface PromotionManagementViewController ()<UITableViewDelegate,
UITableViewDataSource>
{
    BOOL toAddVC;
}
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
    
    self.tabelView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getProductSalesData];
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
        make.height.equalTo(@(SCREEN_HEIGHT - 64 - 30));
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
    
    // 消除字下面多余的线
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.tabelView.tableFooterView = view;
}

// 当页面出现的时候 从添加页面返回 刷新数据
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getProductSalesData];
    
//    if (toAddVC) {
//        toAddVC = NO;
//        [self.tabelView reloadData];
//        return;
//    }else{
//        [self.salesDataArray removeAllObjects];
//        [self getProductSalesData];
//        return;
//    }
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
        [self.salesDataArray removeAllObjects];
        for (NSDictionary *Pdic in result.ModelList) {
            ModlistModel *model = [[ModlistModel alloc]init];
            [model setValuesForKeysWithDictionary:Pdic];
            
            [self.salesDataArray addObject:model];
        }
        
        [loadView stopAnimation];
        [self.tabelView.header endRefreshing];
        [self.tabelView reloadData];
        
    } failure:^(NSError *error) {
        HDCLog(@"请求促销管理失败%@",error);
        [loadView stopAnimation];
    }];
    
}
- (void)bottomBtnClick:(UIButton* )sender
{
    toAddVC = YES;
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
    ManagementCell* cell = [ManagementCell cellWithSalesPromotionTableView:tableView];
    ModlistModel * salesModel = self.salesDataArray[indexPath.row];
 
    CGFloat stockNumber = [salesModel.productstock floatValue];
    NSString *stock = [NSString stringWithFormat:@"%.1f", stockNumber];
    
    CGFloat originPrice = [salesModel.productoutprice floatValue];
    NSString *oriPrice = [[NSString stringWithFormat:@"%.1f",originPrice] stringByAppendingString:salesModel.productunit];
    
    CGFloat nowPrice = [salesModel.productoutprice2 floatValue];
    NSString *nowPricetring = [[NSString stringWithFormat:@"%.1f",nowPrice] stringByAppendingString:salesModel.productunit];
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
        
        
        
        UIAlertController *selct = [UIAlertController alertControllerWithTitle:@"是否删除这个活动" message:@"请您三思😊" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ModlistModel *model = self.salesDataArray[indexPath.row];

            DeleteProductParams* params = [[DeleteProductParams alloc] init];
            params.proid = model.productid;
            [RequestTool deleteProduct:params success:^(ResultsModel *result) {

                if([result.ErrorCode isEqualToString:@"1"])
                {
                    [MBProgressHUD showSuccess:@"删除成功"];
                    [self.salesDataArray removeObjectAtIndex:indexPath.row];
                    
                    [self.tabelView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }failure:^(NSError *error) {
                NSLog(@"删除失败 %@",error);
                
            }];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
        [selct addAction:alertAction];
        [selct addAction:cancelAction];
        [self presentViewController:selct animated:YES completion:nil];
        return;
        
        
    }];
    

    return @[deleteRowAction];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[[ChangePromotionViewController alloc] init] animated:YES];
}

@end
