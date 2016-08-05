//
//  BrandShopManagementViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/8/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BrandShopManagementViewController.h"
#import "AddClassViewController.h"
#import "RequestTool.h"
#import "GetBrandsAndCommunityClassifyParams.h"
#import "ResultsModel.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "GetProductParams.h"
#import "MBProgressHUD.h"
#import "CtcategoryModelList.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AddShopsViewController.h"
#import "ShopsModelList.h"
#import "ShopsManagementCell.h"

@interface BrandShopManagementViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *selectedTableView; // 选择控制器
@property (nonatomic, strong) UITableView *mainTableView; //

@property (nonatomic, strong) ShopsUserInfo *userInfo;


@end

@implementation BrandShopManagementViewController
{
    NSMutableArray *selectedDataSource; //左侧的分类数据
    NSMutableArray *mainDataSource; //商品数据
    NSMutableArray *hotDataSource; //热销数据
    NSString *mainTableHeaderTitle; //主tableView的区头
    NSString *threecategoryid; //分类id
    BOOL isSelect; //是否选择标记
    NSInteger isChoose;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"商品管理";
    [self.view setBackgroundColor:WhiteColor];
    [self createSelectTableViewAndMainTableView];
    
    self.userInfo = [ShopsUserInfoTool account];
    
    isSelect = NO;
    
    self.mainTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshAllDataSource];
    }];
    
    isChoose = 1;
    [self defaultPrepareDataSource];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification) name:@"twoViewController" object:nil];
}

- (void)notification
{
    if (isChoose == 1)
    {
        [self prepareHotDataSource];
    }
    else
    {
        [self prepareMainTableViewDataSource];
    }
}


- (void)refreshAllDataSource
{
    if (isChoose == 1)
    {
        [self prepareHotDataSource];
    }
    else
    {
        [self prepareMainTableViewDataSource];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self prepareSelectedTableViewDataSource];
}

/** 获取左侧的分类列表 */
- (void)prepareSelectedTableViewDataSource
{
    GetBrandsAndCommunityClassifyParams *params = [[GetBrandsAndCommunityClassifyParams alloc] init];
    params.userid = self.userInfo.marketuserid;
    [RequestTool searchCtcategory:params success:^(ResultsModel *result)
    {
        if ([result.totalcount isEqualToString:@"0"])
        {
            [MBProgressHUD showError:@"数据获取失败"];
        }
        else
        {
            selectedDataSource = [NSMutableArray array];
            selectedDataSource = [CtcategoryModelList mj_objectArrayWithKeyValuesArray:result.ModelList];
            [MBProgressHUD showSuccess:@"数据获取成功"];
            [self.selectedTableView reloadData];
            [self.mainTableView reloadData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"获取列表失败"];
    }];
}
/** 获取右侧的商品列表 */
- (void)prepareMainTableViewDataSource
{
//    [MBProgressHUD showMessage:@"数据正在加载中..."];
    GetProductParams* params = [[GetProductParams alloc] init];
    params.marketuserid = self.userInfo.marketuserid;
    params.threecategoryid = threecategoryid;
    params.pagesize = @"0";
    params.page = @"0";
    [RequestTool getProduct:params success:^(ResultsModel *result) {
        HDCLog(@"普通 == result.totalcount == %@", result.totalcount);
        if ([result.totalcount isEqualToString:@"0"])
        {
            [mainDataSource removeAllObjects];
//            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"暂无数据"];
        }
        else
        {
            mainDataSource = [NSMutableArray array];
            mainDataSource = [ShopsModelList mj_objectArrayWithKeyValuesArray:result.ModelList];
//            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"数据加载成功"];
        }
        [self.mainTableView reloadData];
        [self.mainTableView.header endRefreshing];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"数据加载失败"];
        [self.mainTableView.header endRefreshing];
    }];
}

/** 加载热销商品 */
- (void)prepareHotDataSource
{
//    [MBProgressHUD showMessage:@"热销数据正在加载中..."];
    GetProductParams* params = [[GetProductParams alloc] init];
    ShopsUserInfo* shopsInfo = [ShopsUserInfoTool account];
    params.marketuserid = shopsInfo.marketuserid;
    params.threecategoryid = @"0";
    params.Productlabel = @"热销";
    params.pagesize = @"0";
    params.page = @"0";
    [RequestTool getProduct:params success:^(ResultsModel *result) {
        HDCLog(@"热销 == result.totalcount == %@", result.totalcount);
        if ([result.totalcount isEqualToString:@"0"])
        {
            [mainDataSource removeAllObjects];
//            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"暂无数据"];
        }
        else
        {
            mainDataSource = [NSMutableArray array];
            mainDataSource = [ShopsModelList mj_objectArrayWithKeyValuesArray:result.ModelList];
//            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"数据加载成功"];
        }
        
        [self.mainTableView reloadData];
        
        [self.mainTableView.header endRefreshing];
    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"数据加载失败"];
        [self.mainTableView.header endRefreshing];
    }];
}

- (void)createSelectTableViewAndMainTableView
{
    _selectedTableView = [[UITableView alloc]init];
    [_selectedTableView setBackgroundColor:[UIColor whiteColor]];
    _selectedTableView.delegate = self;
    _selectedTableView.dataSource = self;
    [self.view addSubview:_selectedTableView];
    _selectedTableView.backgroundColor = [UIColor colorWithWhite:0.875 alpha:1.000];
    [_selectedTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
        make.width.equalTo(@80);
        make.height.equalTo(@(SCREEN_HEIGHT));
    }];
    _selectedTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _mainTableView = [[UITableView alloc]init];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    [self.view addSubview:_mainTableView];
    _mainTableView.backgroundColor = [UIColor colorWithWhite:0.915 alpha:1.000];
    [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(_selectedTableView.mas_right);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT - 200));
    }];
    
    UIButton * addShopsBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    addShopsBtn.backgroundColor = greenColor;
    [addShopsBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:addShopsBtn];
    [addShopsBtn setTitle:@"添加商品" forState:(UIControlStateNormal)];
    [addShopsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.left.equalTo(self.selectedTableView.mas_right).offset(10);
        make.width.equalTo(@(0.25*SCREEN_WIDTH));
        make.height.equalTo(@40);
    }];
    addShopsBtn.layer.masksToBounds = YES;
    addShopsBtn.layer.cornerRadius = 5;
    [addShopsBtn addTarget:self action:@selector(addShopsBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton * addClassBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    addClassBtn.backgroundColor = greenColor;
    [addClassBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:addClassBtn];
    [addClassBtn setTitle:@"添加分类" forState:(UIControlStateNormal)];
    [addClassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addShopsBtn);
        make.right.equalTo(self.view).offset(-10);
        make.width.equalTo(@(0.26*SCREEN_WIDTH));
        make.height.equalTo(@40);
    }];
    [addClassBtn addTarget:self action:@selector(addClassBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    addClassBtn.layer.masksToBounds = YES;
    addClassBtn.layer.cornerRadius = 5;
}

- (void)addShopsBtn:(UIButton *)sender
{
    AddShopsViewController *addShopsViewController = [[AddShopsViewController alloc] init];
    
    [self.navigationController pushViewController:addShopsViewController animated:YES];
}

- (void)addClassBtn:(UIButton *)sender
{
    [self.navigationController pushViewController:[[AddClassViewController alloc] init] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.selectedTableView])
    {
        return selectedDataSource.count + 1;
    }
    else
    {
        return mainDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.selectedTableView])
    {
        static NSString* ID = @"selectedCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"热销";
        }
        else
        {
            CtcategoryModelList *modelList = selectedDataSource[indexPath.row - 1];
            cell.textLabel.text = modelList.threecategoryname;
        }
        return cell;
    }
    else
    {
        ShopsManagementCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:@"ShopsManagementCell"];
        if (!cell)
        {
            cell = [[ShopsManagementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopsManagementCell"];
        }
        ShopsModelList *modelList = mainDataSource[indexPath.row];
        cell.modelList = modelList;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_mainTableView])
    {
        UIView *mainHeadView = [[UIView alloc]init];
        mainHeadView.backgroundColor = [UIColor colorWithWhite:0.915 alpha:1.000];
        mainHeadView.frame = CGRectMake(0, 0, 100, 40);
        
        UILabel *headLabel = [UILabel new];
        if (isSelect == NO)
        {
            headLabel.text = @"热销";
        }
        else
        {
            headLabel.text = mainTableHeaderTitle;
        }
        [headLabel setFont:[UIFont systemFontOfSize:14]];
        [mainHeadView addSubview:headLabel];
        [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(mainHeadView.mas_left).offset(10);
            make.centerY.mas_equalTo(mainHeadView.mas_centerY);
            make.width.equalTo(@(100));
            make.height.equalTo(@(30));
        }];
        headLabel.textColor = [UIColor colorWithWhite:0.286 alpha:1.000];
        
        return mainHeadView;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_mainTableView])
    {
        return 45;
    }
    return 0;
}

// 每个tableView 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_selectedTableView])
    {
        return 45;
    }
    else
    {
        return 100;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.selectedTableView])
    {
        isSelect = YES;
        isChoose = indexPath.row + 1;
        
        if (indexPath.row == 0)
        {
            mainTableHeaderTitle = @"热销";
            [self prepareHotDataSource];
        }
        else
        {
            CtcategoryModelList *modelList = selectedDataSource[indexPath.row - 1];
            mainTableHeaderTitle = modelList.threecategoryname;
            threecategoryid = modelList.threecategoryid;
            [self prepareMainTableViewDataSource];
        }
        [self.mainTableView reloadData];
    }
}

- (void)defaultPrepareDataSource
{
    if (isChoose == 1)
    {
        [self prepareHotDataSource];
    }
}


@end
