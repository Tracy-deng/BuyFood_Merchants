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
#import "ShopInfoViewController.h"
#import "LoginViewController.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"
#import "UIImageView+WebCache.h"
#import "RequestTool.h"
#import "BusinessStatusParams.h"
#import "ResultsModel.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray* sourceArray;
@property (nonatomic, strong) ShopsUserInfo* shopsUserInfo;



@end

@implementation SettingViewController
{
    UIImageView *navBarHairlineImageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(68, 192, 88)];
    /** 设置去掉导航条下面的线*/
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    // 解决navigationBar影响tableView的问题
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.shopsUserInfo = [ShopsUserInfoTool account];
    // 设置表头视图
    [self setUpHeaderView];
    // 设置tableView
    [self setTableView];
    
    self.sourceArray = @[@"自动接单",
                         @"投诉订单",
                         @"联系市场经理",
                         @"店铺信息",
                         @"修改密码",
                         @"意见反馈",
                         @"清除缓存",
                         @"退出登录"];
}
/** 设置去掉导航条下面的线 */
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews)
    {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView)
        {
            return imageView;
        }
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    navBarHairlineImageView.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}
/** 设置表头视图 */
- (void)setUpHeaderView
{
    // 设置店铺头像
    UIImageView* headerImageView = [[UIImageView alloc] init];

    if (self.shopsUserInfo.pic.length == 0)
    {
        [headerImageView setImage:[UIImage imageNamed:@"oval1"]];
    }
    else
    {
        [headerImageView sd_setImageWithURL:[NSURL URLWithString:self.shopsUserInfo.pic]];
    }
    [self.view addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(@(64));
        make.width.height.equalTo(@(self.view.width * 0.15));
    }];
    headerImageView.layer.masksToBounds = YES;
    headerImageView.layer.cornerRadius = self.view.width * 0.15 * 0.5;
    headerImageView.layer.borderWidth = 1.0;
    headerImageView.layer.borderColor=[[UIColor whiteColor] CGColor];//边框颜色
    
    
    // 设置店铺名称
    UILabel *shopName = [[UILabel alloc] init];
    [shopName setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    [shopName setTextColor:HDCColor(246, 246, 246)];
    if (self.shopsUserInfo.marketname.length == 0)
    {
        shopName.text = @"店铺名称";
    }
    else
    {
        shopName.text = self.shopsUserInfo.marketname;
    }
    shopName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:shopName];
    [shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(headerImageView.mas_bottom).offset(5);
        make.width.equalTo(@(self.view.width * 0.50));
        make.height.equalTo(@(20));
    }];
    
    // 设置店家手机号码
    UILabel *phoneNum = [[UILabel alloc] init];
    [phoneNum setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    [phoneNum setTextColor:HDCColor(246, 246, 246)];
    phoneNum.text = self.shopsUserInfo.telephone;
    phoneNum.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phoneNum];
    [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(shopName.mas_bottom).offset(3);
        make.width.height.equalTo(shopName);
    }];
}

/** 设置tableView */
- (void)setTableView
{
    UIView* tableViewBackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height * 0.33, self.view.width, self.view.height - self.view.height * 0.33)];
    tableViewBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableViewBackView];
    UITableView *tableView = [[UITableView alloc] init];
    [tableView setBackgroundColor:[UIColor whiteColor]];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableViewBackView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(tableViewBackView);
        make.height.equalTo(@(self.view.height - self.view.height * 0.330 - 49));
    }];
    
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
            if ([self.shopsUserInfo.status isEqualToString:@"1"])
            {
                switchBtn.on = NO;
            }
            else if ([self.shopsUserInfo.status isEqualToString:@"4"])
            {
                switchBtn.on = YES;
            }
            [switchBtn addTarget:self action:@selector(switchBtnClick:) forControlEvents:UIControlEventValueChanged];
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

- (void)switchBtnClick:(UISwitch *)sender
{
    if(sender.isOn)
    {
        BusinessStatusParams *params = [[BusinessStatusParams alloc] init];
        params.status = @"4";
        params.marketuserid = self.shopsUserInfo.marketuserid;
        [RequestTool autoGetOrder:params success:^(ResultsModel *result)
        {
            [MBProgressHUD showMessage:@"开启自动接单中..."];
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"开启成功"];
            self.shopsUserInfo.status = @"4";
            [ShopsUserInfoTool saveAccount:self.shopsUserInfo];
            HDCLog(@"修改营业状态:%@", self.shopsUserInfo.status);
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"开启失败"];
            sender.on = NO;
        }];

    }
    else
    {
        [MBProgressHUD showMessage:@"关闭接单中..."];
        BusinessStatusParams *params = [[BusinessStatusParams alloc] init];
        params.status = @"1";
        params.marketuserid = self.shopsUserInfo.marketuserid;
        [RequestTool autoGetOrder:params success:^(ResultsModel *result) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"关闭成功"];
            self.shopsUserInfo.status = @"1";
            [ShopsUserInfoTool saveAccount:self.shopsUserInfo];
            HDCLog(@"修改营业状态:%@", self.shopsUserInfo.status);
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"关闭失败"];
            sender.on=YES;
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1)
    {
        [self.navigationController pushViewController:[[ComplaintOrderViewController alloc] init] animated:YES];
    }
    if (indexPath.row == 2)
    {
        UIWebView*callWebview =[[UIWebView alloc] init];//self.shopsUserInfo.telephone2
        NSString *tellPhone = [@"tel:" stringByAppendingString:self.shopsUserInfo.telephone2];
        NSURL *telURL =[NSURL URLWithString:tellPhone];// 貌似tel:// 或者 tel: 都行
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.view addSubview:callWebview];
    }
    if (indexPath.row == 3)
    {
        [self.navigationController pushViewController:[[ShopInfoViewController alloc] init] animated:YES];
    }
    if (indexPath.row == 4)
    {
        [self.navigationController pushViewController:[[ChangePasswordViewController alloc] init] animated:YES];
    }
    if (indexPath.row == 5)
    {
        [self.navigationController pushViewController:[[FeedBackViewController alloc] init] animated:YES];
    }
    if (indexPath.row == 6)
    {
        //            清除缓存
        [MBProgressHUD showMessage:@"正在清理缓存..."];
        
        // 几秒后消失
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 移除HUD
            [MBProgressHUD hideHUD];
            
            // 提醒有没有新版本
            [MBProgressHUD showSuccess:@"清理成功"];
        });
    }
    if (indexPath.row == 7)
    {
        [self restoreRootViewController:[[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]];
    }
}

/** 切换根视图 */
- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    typedef void (^Animation)(void);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}




@end
