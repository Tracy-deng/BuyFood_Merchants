//
//  OrderListCell.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "OrderListCell.h"

@interface OrderListCell ()
/** 菜名 */
@property (nonatomic, strong) UILabel* foodName;
/** 数量 */
@property (nonatomic, strong) UILabel* number;
/** 价格 */
@property (nonatomic, strong) UILabel* money;

@end

@implementation OrderListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    OrderListCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBackgroundColor:[UIColor clearColor]];
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
    self.foodName = [[UILabel alloc] init];
    self.foodName.textColor = HDCColor(102, 102, 102);
    self.foodName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    [self.contentView addSubview:self.foodName];
    [self.foodName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(30);
        make.width.equalTo(@51);
        make.height.equalTo(@24);
    }];
    self.number = [[UILabel alloc] init];
    self.number.textColor = HDCColor(102, 102, 102);
    self.number.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    [self.contentView addSubview:self.number];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.foodName);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.width.equalTo(@51);
        make.height.equalTo(@24);
    }];
    self.money = [[UILabel alloc] init];
    self.money.textColor = HDCColor(102, 102, 102);
    self.money.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    [self.contentView addSubview:self.money];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.foodName);
        make.left.mas_equalTo(self.contentView.mas_right).offset(-60);
        make.width.equalTo(@51);
        make.height.equalTo(@24);
    }];
}
- (void)setUpFoodNameLabel:(NSString* )foodName andNumberLabel:(NSString* )number andMoneyLabel:(NSString* )money
{
    self.foodName.text = foodName;
    self.number.text = number;
    self.money.text = money;
}
@end
