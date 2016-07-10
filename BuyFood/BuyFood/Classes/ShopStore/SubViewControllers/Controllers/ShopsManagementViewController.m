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
@interface ShopsManagementViewController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *selectedTableView; // 选择控制器
@property (nonatomic, strong) UITableView *mainTableView; //
@property (nonatomic, strong) NSArray *selectArray;
@end

@implementation ShopsManagementViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"text" object:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"商品管理";
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.915 alpha:1.000]];
    [self creatTableView];
    
    /**
     *  接受返回的分类的通知
     *
     *  @return
     */
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:@"text" object:nil];
    
    _selectArray = [NSArray arrayWithObjects:@"蔬菜",@"水果" ,nil];
    
}

- (void)creatTableView
{
    _selectedTableView = [[UITableView alloc]init];
    [self.view addSubview:_selectedTableView];
    _selectedTableView.backgroundColor = [UIColor colorWithWhite:0.875 alpha:1.000];
    [_selectedTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@(SCREEN_HEIGHT));
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
        make.left.equalTo(self.selectedTableView.mas_right).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
    addBtn.layer.masksToBounds = YES;
    addBtn.layer.cornerRadius = 5;
    [addBtn addTarget:self action:@selector(didAddBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton * reorderBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    reorderBtn.backgroundColor = greenColor;
    [reorderBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.view addSubview:reorderBtn];
    [reorderBtn setTitle:@"排序" forState:(UIControlStateNormal)];
    [reorderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addBtn);
        make.right.equalTo(self.view).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
    [reorderBtn addTarget:self action:@selector(reordeBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    reorderBtn.layer.masksToBounds = YES;
    reorderBtn.layer.cornerRadius = 5;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_selectedTableView]) {
        return [[ShopManager shareInstance]dataArraySupperInit].count;
    }else
        
        return 3;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:_selectedTableView]) {
        return self.selectArray.count;
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
        UIButton * hotBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [hotBtn setTitle:@"热销" forState:(UIControlStateNormal)];
        [headView addSubview:hotBtn];
        hotBtn.frame = CGRectMake(10, 10, 30, 30);
        [hotBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
      
        
        return headView;
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
        
        cell.textLabel.text  = [[ShopManager shareInstance]dataArraySupperInit] [indexPath.row];
        cell.backgroundColor = [UIColor colorWithWhite:0.875 alpha:1.000];
        [tableView setSeparatorColor:[UIColor whiteColor]];
    // cell 选中的颜色
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        return cell;

    }else{
        
        ShopTableViewCell * shopCell = [_mainTableView dequeueReusableCellWithIdentifier:@"reuse"];
        shopCell.backgroundColor = [UIColor colorWithWhite:0.915 alpha:1.000];
        [tableView setSeparatorColor:[UIColor colorWithWhite:0.745 alpha:1.000]];
        shopCell.selectedBackgroundView = [[UIView alloc]initWithFrame:shopCell.frame];
        shopCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        return shopCell;
    }
    

}

- (void)didAddBtn:(UIButton *)sender
{
    GoodsViewController *goodsVC = [[GoodsViewController alloc]init];
    [self.navigationController pushViewController:goodsVC animated:YES];
}
/**
 *  收到通知 增加分类
 *
 *  @param notification
 */
- (void)notification:(NSNotification *)notification
{
    NSDictionary *dic = [notification userInfo];
    
    [[ShopManager shareInstance] addArrayWithString:dic[@"userInfo"]];


    [self.selectedTableView reloadData];
}

// 点击 mainTableView 进入商品详情
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_mainTableView])
    {
        ShopDetailViewController *detailVC =  [[ShopDetailViewController alloc]init];
        [self.navigationController pushViewController:detailVC animated:YES];
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
        
        return 0;
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



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

@end
