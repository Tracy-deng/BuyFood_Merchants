//
//  ShopsManagementViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopsManagementViewController.h"
#import "ShopTableViewCell.h"
@interface ShopsManagementViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *selectedTableView; // 选择控制器
@property (nonatomic, strong) UITableView *mainTableView; //
@end

@implementation ShopsManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"商品管理";
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.795 alpha:1.000]];
    [self creatTableView];
}

- (void)creatTableView
{
    _selectedTableView = [[UITableView alloc]init];
    [self.view addSubview:_selectedTableView];
    _selectedTableView.backgroundColor = [UIColor colorWithWhite:0.795 alpha:1.000];
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
        make.height.equalTo(@(SCREEN_HEIGHT));
    }];
    
    
    
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.selectedTableView.tableFooterView = view;
    self.mainTableView.tableFooterView = view;
    
    
    [self.mainTableView registerClass:[ShopTableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_selectedTableView]) {
        return 3;
    }else
        
        return 3;
    
}


// 设置分区 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_mainTableView]) {
        
        return 40;
    }else
        
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([tableView isEqual:_mainTableView]) {
        
        return 60;
        
    }else
        
        return 0;
}

// 添加区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:_mainTableView]) {
        
        UIView *headView = [[UIView alloc]init];

        headView.backgroundColor = [UIColor colorWithWhite:0.795 alpha:1.000];
        
        headView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 100, 40);
        UIButton * hotBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [hotBtn setTitle:@"热销" forState:(UIControlStateNormal)];
        [headView addSubview:hotBtn];
        hotBtn.frame = CGRectMake(10, 10, 30, 30);
        [hotBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        UIButton *  changeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [changeBtn setTitle:@"修改" forState:(UIControlStateNormal)];
        [changeBtn setTitleColor:greenColor forState:(UIControlStateNormal)];
        [headView addSubview:changeBtn];
        [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(hotBtn);
            make.right.equalTo(headView).offset(-5);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
        
        return headView;
    }
    
    return 0;
    
}

// 添加区尾
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if ([tableView isEqual:_mainTableView]) {
        
        UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 100, 40)];
        
        UIButton * addBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        addBtn.backgroundColor = greenColor;
        [addBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [footView addSubview:addBtn];
        [addBtn setTitle:@"添加" forState:(UIControlStateNormal)];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footView).offset(10);
            make.left.equalTo(footView).offset(10);
            make.width.equalTo(@80);
            make.height.equalTo(@30);
        }];
        addBtn.layer.masksToBounds = YES;
        addBtn.layer.cornerRadius = 4;
        footView.backgroundColor = [UIColor colorWithWhite:0.865 alpha:1.000];
        
        UIButton * reorderBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        reorderBtn.backgroundColor = greenColor;
        [reorderBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [footView addSubview:reorderBtn];
        [reorderBtn setTitle:@"排序" forState:(UIControlStateNormal)];
        [reorderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footView).offset(10);
            make.right.equalTo(footView).offset(-10);
            make.width.equalTo(@80);
            make.height.equalTo(@30);
        }];
        reorderBtn.layer.masksToBounds = YES;
        reorderBtn.layer.cornerRadius = 4;
        
        return footView;
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
        
        cell.backgroundColor = [UIColor colorWithWhite:0.795 alpha:1.000];
        [tableView setSeparatorColor:[UIColor whiteColor]];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        return cell;

    }else{
        
        ShopTableViewCell * shopCell = [_mainTableView dequeueReusableCellWithIdentifier:@"reuse"];
        shopCell.backgroundColor = [UIColor colorWithWhite:0.915 alpha:1.000];
        [tableView setSeparatorColor:[UIColor colorWithWhite:0.745 alpha:1.000]];
        return shopCell;
    }
        
    
    


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_selectedTableView])
    {
        return 50;
    }else
        
        return 100;
    
}


@end
