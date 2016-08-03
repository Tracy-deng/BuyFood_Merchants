//
//  BrandShopManagementViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/8/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BrandShopManagementViewController.h"
#import "AddClassViewController.h"

@interface BrandShopManagementViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *selectedTableView; // 选择控制器
@property (nonatomic, strong) UITableView *mainTableView; //

@end

@implementation BrandShopManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"商品管理";
    [self.view setBackgroundColor:WhiteColor];
    [self createSelectTableViewAndMainTableView];
}

- (void)createSelectTableViewAndMainTableView
{
    _selectedTableView = [[UITableView alloc]init];
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
    HDCLog(@"添加商品");
}

- (void)addClassBtn:(UIButton *)sender
{
    HDCLog(@"添加分类");
    [self.navigationController pushViewController:[[AddClassViewController alloc] init] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = @"111";
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_mainTableView])
    {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = [UIColor colorWithWhite:0.915 alpha:1.000];
        headView.frame = CGRectMake(0, 0, 100, 40);
        
        UILabel *headLabel = [UILabel new];
        headLabel.text = @"分类名称";
        [headView addSubview:headLabel];
        headLabel.frame = CGRectMake(10, 10, 100, 30);
        headLabel.textColor = [UIColor colorWithWhite:0.286 alpha:1.000];
        
        return headView;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_mainTableView])
    {
        return 40;
    }
    return 0;
}

// 每个tableView 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_selectedTableView])
    {
        return 50;
    }
    else
    {
        return 100;
    }
}

@end
