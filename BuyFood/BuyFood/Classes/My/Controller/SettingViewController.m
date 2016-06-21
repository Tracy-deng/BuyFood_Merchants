//
//  SettingViewController.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "SettingViewController.h"
#import "TagLabels.h"
#import "ComplaintOrderViewController.h"
#import "ChangePasswordViewController.h"
#import "FeedBackViewController.h"
//#import "ShopInfoViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray* sourceArray;


@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(46, 192, 70)];
    /** 设置去掉导航条下面的线*/
    
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.hidden = YES;
    // 解决navigationBar影响tableView的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置表头视图
    [self setUpHeaderView];
    // 设置tableView
    [self setTableView];
    
    self.sourceArray = @[@"震动提示",
                         @"投诉订单",
                         @"联系市场经理",
                         @"店铺信息",
                         @"修改密码",
                         @"意见反馈",
                         @"清除缓存",
                         @"退出登录"];
}
/** 设置表头视图 */
- (void)setUpHeaderView
{
    // 设置标题头
    UILabel* title = [[UILabel alloc] init];
    title.text = @"我的";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(self.view.height * 0.04);
        make.width.mas_offset(@50);
        make.height.mas_offset(@20);
    }];
    // 设置店铺头像
    UIImageView* headerImageView = [[UIImageView alloc] init];
    [headerImageView setFrame:CGRectMake(self.view.width * 0.06, self.view.height * 0.11, self.view.width * 0.19, self.view.height * 0.11)];
    [headerImageView setImage:[UIImage imageNamed:@"oval1"]];
    [self.view addSubview:headerImageView];
    // 设置店铺名称
    TagLabels* shopName = [TagLabels initTaglabel];
    [shopName createLabelText:@"天天果蔬" andLabelX:self.view.width * 0.288 andLabelY:headerImageView.y + 10 andLabelHeight:self.view.height * 0.04 andLabelWidth:self.view.width * 0.25 andLabelTextStytle:@"PingFangSC-Regular" andLabelFontsize:18 andtextColor:HDCColor(246, 246, 246)];
    [self.view addSubview:shopName];
    // 设置店家手机号码
    UIImageView* phoneImageView = [[UIImageView alloc] init];
    [phoneImageView setFrame:CGRectMake(self.view.width * 0.31, self.view.height * 0.18, self.view.width * 0.05, self.view.height * 0.03)];
    [phoneImageView setImage:[UIImage imageNamed:@"screenSmartphoneSimpleLineIcons"]];
    [self.view addSubview:phoneImageView];
    TagLabels* phoneNum = [TagLabels initTaglabel];
    [phoneNum createLabelText:@"12345678998" andLabelX:self.view.width * 0.36 andLabelY:phoneImageView.y andLabelHeight:self.view.height * 0.03 andLabelWidth:self.view.width * 0.35 andLabelTextStytle:@"PingFangSC-Regular" andLabelFontsize:14 andtextColor:HDCColor(240, 240, 240)];
    [self.view addSubview:phoneNum];
}

/** 设置tableView */
- (void)setTableView
{
    UIView* tableViewBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height * 0.27, self.view.width, self.view.height - self.view.height * 0.27)];
    tableViewBackView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tableViewBackView];
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, tableViewBackView.width, tableViewBackView.height - 50) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    // 去掉多余的cell
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableViewBackView addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"status";
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.textColor = HDCColor(102, 102, 102);
        cell.textLabel.text = self.sourceArray[indexPath.row];
        if (indexPath.row == 0)
        {
            UISwitch* switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.width * 0.8, cell.contentView.height * 0.15, cell.contentView.width * 0.14, self.view.height * 0.04)];
            [cell.contentView addSubview:switchBtn];
        }
        else if (indexPath.row == 2)
        {
            UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width * 0.8 + 15, cell.contentView.height * 0.2, cell.contentView.width * 0.2, self.view.height * 0.04)];
            nameLabel.text = @"张三";
            nameLabel.textColor = HDCColor(153, 153, 153);
            [cell.contentView addSubview:nameLabel];
        }
        else if (indexPath.row == self.sourceArray.count - 1)
        {
            cell.textLabel.text = @"退出登录";
            cell.textLabel.textColor = HDCColor(233, 91, 30);
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        [self.navigationController pushViewController:[[ComplaintOrderViewController alloc] init] animated:YES];
    }
    if (indexPath.row == 3)
    {
//        [self.navigationController pushViewController:[[ShopInfoViewController alloc] init] animated:YES];
    }
    if (indexPath.row == 4)
    {
        [self.navigationController pushViewController:[[ChangePasswordViewController alloc] init] animated:YES];
    }
    if (indexPath.row == 5)
    {
        [self.navigationController pushViewController:[[FeedBackViewController alloc] init] animated:YES];
    }
}


@end
