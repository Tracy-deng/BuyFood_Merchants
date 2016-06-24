//
//  MyBillSpendingCell.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/24.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "MyBillSpendingCell.h"

@interface MyBillSpendingCell ()

/** 用户头像 */
@property (nonatomic, strong) UIImageView* userHeaderImageView;
/** 用户名称 */
@property (nonatomic, strong) UILabel* userName;
/** 订单 */
@property (nonatomic, strong) UILabel* order;
/** 时间 */
@property (nonatomic, strong) UILabel* time;
/** 金钱数 */
@property (nonatomic, strong) UILabel* money;

@end

@implementation MyBillSpendingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"MyBillSpendingCell";
    MyBillSpendingCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[MyBillSpendingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUpContentView];
    }
    return self;
}

- (void)setUpContentView
{
    self.userHeaderImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.userHeaderImageView];
    [self.userHeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@20);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.15);
        make.height.equalTo(self.userHeaderImageView.mas_width);
    }];
    self.userName = [[UILabel alloc] init];
    self.userName.textColor = HDCColor(102, 102, 102);
    self.userName.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self.contentView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userHeaderImageView);
        make.left.mas_equalTo(self.userHeaderImageView.mas_right).offset(20);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.15);
        make.height.mas_equalTo(self.userName.mas_width).multipliedBy(0.5);
    }];
    self.order = [[UILabel alloc] init];
    self.order.textColor = HDCColor(153, 153, 153);
    self.order.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    [self.contentView addSubview:self.order];
    [self.order mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.equalTo(self.userName);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.22);
        make.height.mas_equalTo(self.order.mas_width).multipliedBy(0.306);
    }];
    self.time = [[UILabel alloc] init];
    self.time.textColor = HDCColor(153, 153, 153);
    self.time.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userHeaderImageView.mas_top).offset(-2);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.11);
        make.height.equalTo(self.order);
    }];
    self.money = [[UILabel alloc] init];
    self.money.textAlignment = NSTextAlignmentRight;
    self.money.textColor = HDCColor(102, 102, 102);
    self.money.font = [UIFont fontWithName:@"PingFangSC-Medium" size:24];
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.right.equalTo(self.time);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.29);
        make.height.mas_equalTo(self.money.mas_width).multipliedBy(0.35);
    }];
}

- (void)setuserHeaderImageName:(NSString* )userHeaderImageName andUserName:(NSString* )userName andOrderText:(NSString* )order andTimeLabel:(NSString* )time andMoneyText:(NSString* )money;
{
    [self.userHeaderImageView setImage:[UIImage imageNamed:userHeaderImageName]];
    self.userName.text = userName;
    self.order.text = order;
    self.time.text = time;
    self.money.text = money;
}


@end
