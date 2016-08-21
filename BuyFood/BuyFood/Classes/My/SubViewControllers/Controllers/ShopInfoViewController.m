//
//  ShopInfoViewController.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopInfoViewController.h"
#import "ShopsUserInfo.h"
#import "ShopsUserInfoTool.h"

@interface ShopInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* sourceArray;
@property (nonatomic, strong) NSArray* detailTextLabel;
@property (nonatomic, strong) ShopsUserInfo* shopsUserInfo;

@end

@implementation ShopInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:HDCColor(238, 238, 238)];
    self.shopsUserInfo = [ShopsUserInfoTool account];
    self.title = @"店铺信息";
    [self setUpTableView];
    self.sourceArray = @[@"店铺名称",
                         @"店铺编号",
                         @"店铺地址",
                         @"店铺电话"
                         ];
    self.detailTextLabel = @[self.shopsUserInfo.marketname,
                             self.shopsUserInfo.marketuserid,
                             self.shopsUserInfo.detailaddress,
                             self.shopsUserInfo.telephone];
}

- (void)setUpTableView
{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_HEIGHT));
    }];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.sourceArray[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    cell.textLabel.textColor = HDCColor(102, 102, 102);
    cell.detailTextLabel.text = self.detailTextLabel[indexPath.row];
    cell.detailTextLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    cell.detailTextLabel.textColor = HDCColor(153, 153, 153);
    return cell;
}




@end
