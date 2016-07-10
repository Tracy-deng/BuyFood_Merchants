//
//  OrdinaryBusinessRegisterViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/7/9.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OrdinaryBusinessRegisterViewController.h"
#import "RealnameViewController.h"
#import "RegisterCell.h"
#import "ClassModel.h"
#import "FoodMarketModel.h"
#import "CCLocationManager.h"
#import "MHActionSheet.h"
#import "RequestTool.h"
#import "ResultsModel.h"
#import "MJExtension.h"

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)

@interface OrdinaryBusinessRegisterViewController ()<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
{
    CLLocationManager *locationmanager;
    
}
@property (nonatomic, strong) RegisterCell* cell;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* classModelArray;
@property (nonatomic, strong) NSArray* foodMarketModelArray;
@property (nonatomic, strong) NSIndexPath* indexPathNew;
/** 后两行的按钮 */
@property (nonatomic, strong) UIButton* contentBtn;
@property (nonatomic, strong) UILabel* classLabel;
@property (nonatomic, strong) UILabel* foodMarketLabel;

@end

@implementation OrdinaryBusinessRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavLeftBtn];
    self.view.backgroundColor = [UIColor colorWithWhite:0.911 alpha:1.000];
    [self createTableView];
}

/** 设置导航栏左边按钮 */
- (void)setNavLeftBtn
{
    self.navigationItem.title = @"普通商家注册";
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"icon_left_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* laftBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = laftBarItem;
}
/** 返回按钮 */
- (void)backBtnClick:(UIButton* )sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 去掉多余的cell
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.50);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [RegisterCell cellWithTableView:tableView];
    if (indexPath.row == 0)
    {
        [self.cell setLeftTitleLabel:@"店铺名称:" andContentTextFieldPlaceholder:@"请输入店铺名称" andContectText:nil];
    }
    else if (indexPath.row == 1)
    {
        [self.cell setLeftTitleLabel:@"联系电话:" andContentTextFieldPlaceholder:@"请输入联系电话" andContectText:nil];
    }
    else if (indexPath.row == 2)
    {
        [self.cell setLeftTitleLabel:@"详细地址:" andContentTextFieldPlaceholder:@"请输入店铺详细地址" andContectText:nil];
    }
    else if (indexPath.row == 3)
    {
        self.cell.contentTextField.hidden = YES;
        self.cell.leftTitleLabel.text = @"分类名称:";
        self.contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentBtn setImage:[UIImage imageNamed:@"shopsImage"] forState:UIControlStateNormal];
        [self.contentBtn addTarget:self action:@selector(fourBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.cell.contentView addSubview:self.contentBtn];
        [self.contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.cell.contentView.mas_right).offset(-5);
            make.top.equalTo(self.cell.contentView.mas_top).offset(5);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
        
        self.classLabel = [[UILabel alloc] init];
        [self.cell.contentView addSubview:self.classLabel];
        [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cell.leftTitleLabel.mas_right).offset(5);
            make.top.equalTo(self.cell.leftTitleLabel);
            make.width.equalTo(@180);
            make.height.equalTo(@30);
        }];
    }
    else
    {
        self.cell.contentTextField.hidden = YES;
        self.cell.leftTitleLabel.text = @"所属菜场:";
        self.contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentBtn setImage:[UIImage imageNamed:@"shopsImage"] forState:UIControlStateNormal];
        [self.contentBtn addTarget:self action:@selector(fiveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.cell.contentView addSubview:self.contentBtn];
        [self.contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.cell.contentView.mas_right).offset(-5);
            make.top.equalTo(self.cell.contentView.mas_top).offset(5);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
        
        self.foodMarketLabel = [[UILabel alloc] init];
        [self.cell.contentView addSubview:self.foodMarketLabel];
        [self.foodMarketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cell.leftTitleLabel.mas_right).offset(5);
            make.top.equalTo(self.cell.leftTitleLabel);
            make.width.equalTo(@180);
            make.height.equalTo(@30);
        }];
    }

    return self.cell;
}

- (void)fourBtnClick:(UIButton* )sender
{
    [RequestTool shopsListAll:nil success:^(ResultsModel *result) {
        self.classModelArray = [ClassModel mj_objectArrayWithKeyValuesArray:result.ModelList];
        NSMutableArray* array = [NSMutableArray array];
        for (ClassModel* classModel in self.classModelArray)
        {
            [array addObject:classModel.categoryname];
        }
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"分类选择" style:MHSheetStyleWeiChat itemTitles:array];
        actionSheet.cancleTitle = @"取消选择";
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
         {
             self.classLabel.text = title;
         }];

    } failure:^(NSError *error) {
        ;
    }];
    
}
- (void)fiveBtnClick:(UIButton* )sender
{
    NSArray* array = @[@"蔬菜",
                       @"水果",
                       @"蔬菜水果",
                       @"家禽"];
    MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"选择菜场" style:MHSheetStyleWeiChat itemTitles:array];
    actionSheet.cancleTitle = @"取消选择";
    [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title)
     {
         self.foodMarketLabel.text = title;
     }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
/** 获取经纬度 */
- (void)getLonAndlat
{
    
}
@end
