//
//  CommunityShopRegisterViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/7/9.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "CommunityShopRegisterViewController.h"
#import "RealnameViewController.h"
#import "RegisterCell.h"
#import "CCLocationManager.h"
#import "RequestTool.h"
#import "ClassModel.h"
#import "ResultsModel.h"
#import "MJExtension.h"
#import "MHActionSheet.h"

@interface CommunityShopRegisterViewController ()<UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate>
{
    CLLocationManager *locationmanager;
}

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) RegisterCell* cell;
@property (nonatomic, strong) UILabel* locationAddress;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) NSArray* classModelArray;
@property (nonatomic, assign) NSInteger selectClassIndex;
@property (nonatomic, strong) NSString* marketname;
@property (nonatomic, strong) NSString* telephone;
@property (nonatomic, strong) NSString* address;

@end

@implementation CommunityShopRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.911 alpha:1.000];
    [self setNavLeftBtn];
    [self createTableView];
    [self setShopsImageAndNextBtn];
    if (IS_IOS8) {
        [UIApplication sharedApplication].idleTimerDisabled = TRUE;
        locationmanager = [[CLLocationManager alloc] init];
        [locationmanager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        locationmanager.delegate = self;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __block __weak CommunityShopRegisterViewController *wself = self;
    
    if (IS_IOS8) {
        
        [[CCLocationManager shareLocation]getCity:^(NSString *cityString) {
            [wself setLabelText:cityString];
            
        }];
    }
}
-(void)setLabelText:(NSString *)text
{
    _locationAddress.text = text;
}
/** 设置导航栏左边按钮 */
- (void)setNavLeftBtn
{
    self.navigationItem.title = @"社区店注册";
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

#pragma tableViewDelegate DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [RegisterCell cellWithTableView:tableView];
    self.cell.contentTextField.tag = indexPath.row;
    if (indexPath.row == 0)
    {
        [self.cell setLeftTitleLabel:@"店铺名称:" andContentTextFieldPlaceholder:@"请输入店铺名称"];
    }
    else if (indexPath.row == 1)
    {
        [self.cell setLeftTitleLabel:@"联系电话:" andContentTextFieldPlaceholder:@"请输入联系电话"];
    }
    else if (indexPath.row == 2)
    {
        self.cell.contentTextField.hidden = YES;
        self.cell.leftTitleLabel.text = @"定位地址:";
        self.locationAddress = [[UILabel alloc] init];
        [self.cell.contentView addSubview:self.locationAddress];
        [self.locationAddress mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cell.leftTitleLabel.mas_right).offset(5);
            make.top.equalTo(self.cell.leftTitleLabel);
            make.width.equalTo(@180);
            make.height.equalTo(@30);
        }];
    }
    else
    {
        [self.cell setLeftTitleLabel:@"详细地址:" andContentTextFieldPlaceholder:@"请输入店铺详细地址"];
    }
    [self.cell.contentTextField addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    return  self.cell;
}

- (void)setShopsImageAndNextBtn
{
    UIButton* nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setBackgroundColor:greenColor];
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@50);
        make.width.equalTo(self.view);
    }];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"picture"]];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(30);
        make.bottom.mas_equalTo(nextBtn.mas_top).offset(- 50);
        make.width.equalTo(@(SCREEN_WIDTH - 30 * 2));
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.25);
    }];
    // 1.创建Tap手势
    UITapGestureRecognizer* tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    // 2.设置手势的属性
    // 设置需要触发手势的点击数
    tapGR.numberOfTapsRequired = 1;
    
    // 设置需要触发手势的触点的个数
    tapGR.numberOfTouchesRequired = 1;
    
    // 3.将手势与具体的视图绑定在一起
    [self.imageView addGestureRecognizer:tapGR];
}


- (void)tap:(UITapGestureRecognizer* )tapGesture
{
    HDCLog(@"添加图片...");
}

- (void)nextBtnClick:(UIButton* )sender
{
    HDCLog(@"下一步...");
}
- (void)changeValue:(UITextField *)textField
{
    HDCLog(@"%@", textField.text);
    switch (textField.tag)
    {
        case 0:
            self.marketname = textField.text;
            break;
        case 1:
            self.telephone = textField.text;
            break;
        case 3:
            self.address = textField.text;
            break;
        default:
            break;
    }
}



@end
