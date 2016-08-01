//
//  ShopsManagementViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopsManagementViewController.h"
#import "ShopTableViewCell.h"
#import "ShopManager.h"
#import "GoodsViewController.h"
#import "ShopDetailViewController.h"
#import "ThreeCatego.h"
#import "RequestTool.h"
#import "ShopsSecAndThirdClassParams.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "ResultsModel.h"
#import "MJExtension.h"
#import "ShopThreeCate.h"
#import "ModlistModel.h"
#import "GetProductParams.h"
#import "LoadView.h"
#import "MJRefresh.h"

@interface ShopsManagementViewController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
{
    NSString * threeProductId; // 传入的三级id
    NSString * twoProductId;  // 传入的二级id
    BOOL toAddVC;
    NSString * headTitle;
    NSInteger isSelcted;
    NSString * twoID;
}
@property (nonatomic, strong) UITableView *selectedTableView; // 选择控制器
@property (nonatomic, strong) UITableView *mainTableView; //
@property (nonatomic, strong) NSMutableArray * selectArray; // 选择数据源
@property (nonatomic, strong) NSMutableArray * productMainDataArray; // 主页面的数据源
@property (nonatomic, strong) ModlistModel *modlst;
/** */
@property (nonatomic, strong) UIButton *headButton;

@end

@implementation ShopsManagementViewController

{
    NSMutableDictionary<NSString *, NSMutableArray<ModlistModel *> *> *billData;
}

- (NSMutableArray *)productMainDataArray
{
    if (_productMainDataArray == nil) {
        self.productMainDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _productMainDataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"商品管理";
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.915 alpha:1.000]];
    [self creatTableView];

    
    [self.selectedTableView registerClass:[ShopThreeCate class] forHeaderFooterViewReuseIdentifier:@"head"];
    billData = [NSMutableDictionary new];
    [self configureData];

    
    self.mainTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [self selfReloadData];
    }];
    

}
- (void)selfReloadData
{
    if (isSelcted == 1) {
        [self getHotDataBase];
    }else if (isSelcted == 2){
        [self getMainTableDataSource];
    }else if (isSelcted == 3){
        [self getHeaderViewSource];
    }
}
// 当页面出现的时候 从添加页面返回 刷新数据
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (toAddVC) {
        
        [self.productMainDataArray removeAllObjects];
        [self selfReloadData];
        return;
    }else{
        [self.productMainDataArray removeAllObjects];
        [self getHotDataBase];
        return;
    }
}

// 数据请求 左控制器数据
- (void)configureData
{
    ShopsSecAndThirdClassParams* params = [[ShopsSecAndThirdClassParams alloc] init];
    ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];
    params.categoryid = shopsInfo.categoryid;
    [RequestTool shopsSecAndThirdClass:params success:^(ResultsModel *result) {
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        dataArray  = [ThreeCatego mj_objectArrayWithKeyValuesArray:result.ModelList];
        for (ThreeCatego *modle in dataArray) {
            
            for (NSDictionary *dic in modle.ModelList) {
                NSString *subCate = dic[@"subcategoryid"];
                HDCLog(@"subcategoryid == %@",subCate);
                if (![billData.allKeys containsObject:subCate]){
                    [billData setObject:[NSMutableArray new] forKey:subCate];
                }
                self.modlst = [[ModlistModel alloc]init];
                self.modlst.subcategoryid  = subCate;
                self.modlst.subcategoryname = dic[@"subcategoryname"];
                HDCLog(@"subcategoryname == %@",self.modlst.subcategoryname);
                self.modlst.threecategoryid = dic[@"threecategoryid"];
                HDCLog(@"threecategoryid == %@",self.modlst.threecategoryid);
                self.modlst.threecategoryname = dic[@"threecategoryname"];
                HDCLog(@"threecategoryname == %@",self.modlst.threecategoryname);
                NSMutableArray<ModlistModel *> *date = [billData objectForKey:subCate];
                [date addObject:self.modlst];
            }
            NSLog(@"%@",billData);
            [self.mainTableView reloadData];
            [self.selectedTableView reloadData];
            
        }
    } failure:^(NSError *error) {
        ;
    }];
}

// 右边的数据请求
- (void)getMainTableDataSource
{

    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    GetProductParams* params = [[GetProductParams alloc] init];
    ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];
    params.categoryid = shopsInfo.categoryid;
    params.marketuserid = shopsInfo.marketuserid;
    params.subcategoryid = twoProductId;
    params.threecategoryid = threeProductId;
    params.pagesize = @"0";
    params.page = @"0";
    [RequestTool getProduct:params success:^(ResultsModel *result) {
        [self.productMainDataArray removeAllObjects];
        for (NSDictionary *Pdic in result.ModelList) {
            ModlistModel *model = [[ModlistModel alloc]init];
            [model setValuesForKeysWithDictionary:Pdic];
            [self.productMainDataArray addObject:model];
        }
        [self.mainTableView reloadData];
        [loadView stopAnimation];
        [self.mainTableView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"error");
        [loadView stopAnimation];
    }];
    
    
}
/**
 *  请求热销数据
 *
 */
- (void)getHotDataBase
{
    headTitle = @"热销";
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    GetProductParams* params = [[GetProductParams alloc] init];
    ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];
    params.categoryid = shopsInfo.categoryid;
    params.marketuserid = shopsInfo.marketuserid;
    params.subcategoryid = 0;
    params.threecategoryid = 0;
    params.Productlabel = @"热销";
    params.pagesize = @"0";
    params.page = @"0";
    [RequestTool getProduct:params success:^(ResultsModel *result) {
        [self.productMainDataArray removeAllObjects];
        for (NSDictionary *Pdic in result.ModelList) {
            ModlistModel *model = [[ModlistModel alloc]init];
            [model setValuesForKeysWithDictionary:Pdic];
            [self.productMainDataArray addObject:model];
        }
        [self.mainTableView reloadData];
        [loadView stopAnimation];
        [self.mainTableView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"error");
        [loadView stopAnimation];
    }];
}

/**
 *  请求区头数据
 */

- (void)getHeaderViewSource
{
    LoadView *loadView = [LoadView new];
    [loadView startAnimation];
    GetProductParams* params = [[GetProductParams alloc] init];
    ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];
    params.categoryid = shopsInfo.categoryid;
    params.marketuserid = shopsInfo.marketuserid;
    params.subcategoryid = twoID;
    params.pagesize = @"0";
    params.page = @"0";
    [RequestTool getProduct:params success:^(ResultsModel *result) {
        [self.productMainDataArray removeAllObjects];
        for (NSDictionary *Pdic in result.ModelList) {
            ModlistModel *model = [[ModlistModel alloc]init];
            [model setValuesForKeysWithDictionary:Pdic];
            [self.productMainDataArray addObject:model];
        }
        [self.mainTableView reloadData];
        [loadView stopAnimation];
        [self.mainTableView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"error");
        [loadView stopAnimation];
    }];

    
}
- (void)didHeadBtn:(UIButton *)sender
{
    NSLog(@"点击热销按钮");
    sender.backgroundColor = HDCColor(217, 217, 217);
    isSelcted = 1;
    [self getHotDataBase];
}


// 对获得数据排序  小的在前
-(NSArray *)getSortedKeys:(NSMutableDictionary *)dictionary
{
    NSArray *keys = [dictionary.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *first = obj1;
        NSString *second = obj2;
        int firstValue = [first intValue];
        int secondValue = [second intValue];
        if (firstValue < secondValue) {
            return NSOrderedAscending;
        }else if(firstValue > secondValue){
            return NSOrderedDescending;
        }else{
            return NSOrderedSame;
        }
    }];
    return keys;
}
- (void)creatTableView
{
    
     self.headButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.headButton setTitle:@"热销" forState:(UIControlStateNormal)];
    self.headButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.headButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.headButton.backgroundColor = HDCColor(215, 215, 215);
    self.headButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.headButton];
    [self.headButton addTarget:self action:@selector(didHeadBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@50);
    }];
    
    _selectedTableView = [[UITableView alloc]init];
    [self.view addSubview:_selectedTableView];
    _selectedTableView.backgroundColor = [UIColor colorWithWhite:0.875 alpha:1.000];
    [_selectedTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headButton.mas_bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@(SCREEN_HEIGHT -64 - 50));
    }];
    _selectedTableView.delegate = self;
    _selectedTableView.dataSource = self;
    
    _mainTableView = [[UITableView alloc]init];
    [self.view addSubview:_mainTableView];
    _mainTableView.backgroundColor = [UIColor colorWithWhite:0.915 alpha:1.000];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(_selectedTableView.mas_right);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 200));
    }];
    
    
    
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    self.selectedTableView.tableFooterView = view;
    self.mainTableView.tableFooterView = view;
    
    [self.mainTableView registerClass:[ShopTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    
    UIButton * addBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    addBtn.backgroundColor = greenColor;
    [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:addBtn];
    [addBtn setTitle:@"添加" forState:(UIControlStateNormal)];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.left.equalTo(self.selectedTableView.mas_right).offset(30);
        make.width.equalTo(@(0.5*SCREEN_WIDTH));
        make.height.equalTo(@40);
    }];
    addBtn.layer.masksToBounds = YES;
    addBtn.layer.cornerRadius = 5;
    [addBtn addTarget:self action:@selector(didAddBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton * reorderBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    reorderBtn.backgroundColor = greenColor;
    reorderBtn.hidden = YES;
    [reorderBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:reorderBtn];
    [reorderBtn setTitle:@"排序" forState:(UIControlStateNormal)];
    [reorderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addBtn);
        make.right.equalTo(self.view).offset(-10);
        make.width.equalTo(@(0.26*SCREEN_WIDTH));
        make.height.equalTo(@40);
    }];
    [reorderBtn addTarget:self action:@selector(reordeBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    reorderBtn.layer.masksToBounds = YES;
    reorderBtn.layer.cornerRadius = 5;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_selectedTableView]) {
        
        NSArray *keys = [self getSortedKeys:billData];
        NSString *catego = [keys objectAtIndex:section];
        
        return [[billData objectForKey:catego]count];
    }else
        
        return self.productMainDataArray.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:_selectedTableView]) {
        
        return   billData.allKeys.count;
        
    }else{
        return 1;
    }
}


// 添加区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:_mainTableView]) {
        
        UIView *headView = [[UIView alloc]init];
        
        headView.backgroundColor = [UIColor colorWithWhite:0.915 alpha:1.000];
        headView.frame = CGRectMake(0, 0, 100, 40);
        
        UILabel *headLabel = [UILabel new];
        headLabel.text = headTitle;
        [headView addSubview:headLabel];
        headLabel.frame = CGRectMake(10, 10, 100, 30);
        headLabel.textColor = [UIColor colorWithWhite:0.286 alpha:1.000];
        
       
        
        return headView;
    }else if([tableView isEqual:_selectedTableView]){
        
        NSArray *sortKeys = [self getSortedKeys:billData];
        if (sortKeys.count != 0) {
            NSString *catego = [sortKeys objectAtIndex:section];
            ShopThreeCate * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
            headView.frame = CGRectMake(0, 0, 100, 50);
//            headView.backgroundColor = [UIColor colorWithWhite:0.950 alpha:0.8000];
            headView.model = [[billData objectForKey:catego] firstObject];
            
            __block typeof (self) weakself = self;
            
            headView.touch = ^{
                
                NSArray *keys = [self getSortedKeys:billData];

                if (keys.count != 0) {
                    
                    twoID = [keys objectAtIndex:section];
                    headTitle = [[billData objectForKey:catego] firstObject].subcategoryname;
                }
                isSelcted = 3;
                [weakself getHeaderViewSource];
            };
            return headView;
            
        }
        
    }
    
    return 0;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:_selectedTableView]) {
        
        static NSString *identifier = @"test";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier
                    ];
        }
        NSArray *keys = [self getSortedKeys:billData];
        if (keys.count != 0) {
            
            NSString *catego = [keys objectAtIndex:indexPath.section];
            ModlistModel *model = [[billData objectForKey:catego]objectAtIndex:indexPath.row];
            cell.textLabel.text = model.threecategoryname;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = HDCColor(215, 215, 215);
        [tableView setSeparatorColor:[UIColor whiteColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        // cell 选中的颜色
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        return cell;
        
    }else{
        
        ShopTableViewCell * shopCell = [_mainTableView dequeueReusableCellWithIdentifier:@"reuse"];
        shopCell.backgroundColor = [UIColor colorWithWhite:0.915 alpha:1.000];
        [tableView setSeparatorColor:[UIColor colorWithWhite:0.745 alpha:1.000]];
        shopCell.selectedBackgroundView = [[UIView alloc]initWithFrame:shopCell.frame];
        shopCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        ModlistModel * model = self.productMainDataArray[indexPath.row];
        shopCell.productModel = model;
       
        return shopCell;
    }
}

- (void)didAddBtn:(UIButton *)sender
{
    GoodsViewController *goodsVC = [[GoodsViewController alloc]init];
    goodsVC.goodsDic = billData;
    [self.navigationController pushViewController:goodsVC animated:YES];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    toAddVC = YES;
    // 点击 mainTableView 进入商品详情
    if([tableView isEqual:_mainTableView])
    {
        ShopDetailViewController *detailVC =  [[ShopDetailViewController alloc]init];
        detailVC.detailModel = self.productMainDataArray[indexPath.row];
        detailVC.goodsDic = billData;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else{// 点击selectedTableView切换数据
        HDCLog(@"indexPath.row === %ld", indexPath.row);
        // 点击  传入三级id  mainTableView 获取数据
        isSelcted = 2;
        [self.productMainDataArray removeAllObjects];
        NSArray *keys = [self getSortedKeys:billData];
        if (keys.count != 0) {
            
            NSString *catego = [keys objectAtIndex:indexPath.section];
            ModlistModel *model = [[billData objectForKey:catego]objectAtIndex:indexPath.row];
            threeProductId = model.threecategoryid;
            twoProductId = model.subcategoryid;
            headTitle = model.threecategoryname;
            [self getMainTableDataSource];
        }
    }
}
// 每个tableView 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_selectedTableView])
    {
        return 50;
    }else
        
        return 100;
    
}

#pragma mark - - 设置分区 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_mainTableView]) {
        
        return 40;
    }else
        
        return 50;
}



#pragma mark -- 让_mainTableView 进入编辑 并且排序
- (void)reordeBtn:(UIButton *)sender
{
    if (_mainTableView.editing == YES) {
        
        [self.mainTableView setEditing:NO animated:YES];
    }else{
        [self.mainTableView setEditing:YES animated:YES];
    }
    
}

//#pragma mark 提交编辑操作时会调用这个方法(删除，添加)
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    // 删除操作
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // 1.删除数据
//        [self.productMainDataArray removeObjectAtIndex:indexPath.row];
//        
//        // 2.更新UITableView UI界面
////         [tableView reloadData];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}
//
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//    [self.productMainDataArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
//}

@end
