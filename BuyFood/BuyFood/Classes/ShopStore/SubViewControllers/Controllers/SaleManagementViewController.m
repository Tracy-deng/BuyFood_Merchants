//
//  SaleManagementViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "SaleManagementViewController.h"
#import "PromotionManagementViewController.h"
#import "SecondsKillManagementViewController.h"
#import "GroupPurchaseManagementViewController.h"
#import "OutdoorActivitiesManagementViewController.h"
#import "FightGroupsManagementViewController.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"

//#define Start_X 0.0f           // 第一个按钮的X坐标
//#define Start_Y 0.0f           // 第一个按钮的Y坐标
//#define Width_Space 0.0f        // 2个按钮之间的横间距
//#define Height_Space 0.0f      // 竖间距
////#define Button_Height 122.0f    // 高
//#define Button_Width self.view.frame.size.width/2 //宽

@interface SaleManagementViewController ()<UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) NSArray* btnTitleArray;
//@property (nonatomic, strong) NSArray* btnBackColorArray;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) ShopsUserInfo* shopinfo;


@end

@implementation SaleManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"活动管理";
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    [self createTableView];
    self.shopinfo = [ShopsUserInfoTool account];
    
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 去掉多余的cell
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.shopinfo.markettypeid isEqualToString:@"1"])
    {
        return 1;
    }
    else
    {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.shopinfo.markettypeid isEqualToString:@"1"])
    {
        static NSString* ID = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        cell.textLabel.text = @"促销";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else
    {
        static NSString* ID = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row)
        {
            case 0:
                 cell.textLabel.text = @"促销";
                break;
            case 1:
                 cell.textLabel.text = @"秒杀";
                break;
            case 2:
                 cell.textLabel.text = @"团购";
                break;
            case 3:
                 cell.textLabel.text = @"户外活动";
                break;
            case 4:
                 cell.textLabel.text = @"拼团";
                break;
            
            default:
                break;
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.shopinfo.markettypeid isEqualToString:@"1"])
    {
        [self.navigationController pushViewController:[[PromotionManagementViewController alloc] init] animated:YES];
    }
    else
    {
        switch (indexPath.row)
        {
            case 0:
                [self.navigationController pushViewController:[[PromotionManagementViewController alloc] init] animated:YES];
                break;
            case 1:
                [self.navigationController pushViewController:[[SecondsKillManagementViewController alloc] init] animated:YES];
                break;
            case 2:
                [self.navigationController pushViewController:[[GroupPurchaseManagementViewController alloc] init] animated:YES];
                break;
            case 3:
                [self.navigationController pushViewController:[[OutdoorActivitiesManagementViewController alloc] init] animated:YES];
                break;
            case 4:
                [self.navigationController pushViewController:[[FightGroupsManagementViewController alloc] init] animated:YES];
                break;
            default:
                break;
        }
    }
}

/**
- (void)setUpFiveBtn
{
    [self setUpFiveBtn];
    UIView* btnView = [[UIView alloc] init];
    [btnView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(77);
        make.width.mas_equalTo(self.view.mas_width);
        make.height.mas_equalTo(@(3 * Button_Width));
    }];
    self.btnTitleArray = @[@"促销",
                           @"秒杀",
                           @"团购",
                           @"户外活动",
                           @"拼团"];
    self.btnBackColorArray = @[
                               [UIColor colorWithRed:227/255.0 green:117/255.0 blue:48/255.0 alpha:1],
                               [UIColor colorWithRed:247/255.0 green:198/255.0 blue:39/255.0 alpha:1],
                               [UIColor colorWithRed:14/255.0 green:195/255.0 blue:21/255.0 alpha:1],
                               [UIColor colorWithRed:53/255.0 green:183/255.0 blue:26/255.0 alpha:0.42],
                               [UIColor colorWithRed:247/255.0 green:198/255.0 blue:39/255.0 alpha:1]
                               ];
    for (int i = 0 ; i < self.btnTitleArray.count; i++) {
        NSInteger index = i % 2;
        NSInteger page = i / 2;
        // 圆角按钮
        UIButton *aBt = [UIButton buttonWithType:UIButtonTypeCustom];
        aBt.tag = i;
        aBt.frame = CGRectMake(index * (Button_Width + Width_Space) + Start_X, page  * (Button_Width + Height_Space)+Start_Y, Button_Width, Button_Width);
        [aBt setTitle:self.btnTitleArray[i] forState:UIControlStateNormal];
        [aBt setBackgroundColor:self.btnBackColorArray[i]];
        [aBt addTarget:self action:@selector(aBtClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:aBt];
    }
}

- (void)aBtClick:(UIButton* )sender
{
    switch (sender.tag)
    {
        case 0:
            NSLog(@"0");
            [self.navigationController pushViewController:[[PromotionManagementViewController alloc] init] animated:YES];
            break;
        case 1:
            NSLog(@"1");
            [self.navigationController pushViewController:[[SecondsKillManagementViewController alloc] init] animated:YES];
            break;
        case 2:
            NSLog(@"2");
            [self.navigationController pushViewController:[[GroupPurchaseManagementViewController alloc] init] animated:YES];
            break;
        case 3:
            NSLog(@"3");
            [self.navigationController pushViewController:[[OutdoorActivitiesManagementViewController alloc] init] animated:YES];
            break;
        case 4:
            NSLog(@"4");
            [self.navigationController pushViewController:[[FightGroupsManagementViewController alloc] init] animated:YES];
            break;
        default:
            break;
    }
}
*/

@end
