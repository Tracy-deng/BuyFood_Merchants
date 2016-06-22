//
//  BalanceAccountCell.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BalanceAccountCell.h"

@interface BalanceAccountCell ()

/** 提现金额 */
@property (nonatomic, strong) UILabel* AccountMoney;
/** 提现时间 */
@property (nonatomic, strong) UILabel* AccountTime;
/** 提现卡种 */
@property (nonatomic, strong) UILabel* AccountCard;

@end

@implementation BalanceAccountCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    BalanceAccountCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[BalanceAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    self.AccountMoney = [[UILabel alloc] init];
    self.AccountMoney.textColor = HDCColor(102, 102, 102);
    self.AccountMoney.font = [UIFont fontWithName:@"PingFangSC-Medium" size:30];
    [self.contentView addSubview:self.AccountMoney];
    [self.AccountMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.30);
        make.height.mas_equalTo(self.AccountMoney.mas_width).multipliedBy(0.38);
    }];
    
    self.AccountTime = [[UILabel alloc] init];
//    [self.AccountTime setBackgroundColor:[UIColor redColor]];
    self.AccountTime.textAlignment = NSTextAlignmentRight;
    self.AccountTime.textColor = HDCColor(153, 153, 153);
    self.AccountTime.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [self.contentView addSubview:self.AccountTime];
    [self.AccountTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(6);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.17);
        make.height.mas_equalTo(self.AccountTime.mas_width).multipliedBy(0.26);
    }];

    self.AccountCard = [[UILabel alloc] init];
//    [self.AccountCard setBackgroundColor:[UIColor redColor]];
    self.AccountCard.textAlignment = NSTextAlignmentRight;
    self.AccountCard.textColor = HDCColor(153, 153, 153);
    self.AccountCard.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [self.contentView addSubview:self.AccountCard];
    [self.AccountCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.30);
        make.height.mas_equalTo(self.AccountCard.mas_width).multipliedBy(0.20);
    }];
}

- (void)setUpAccountMoneyLabel:(NSString* )accountMoney andAccountTimeLabel:(NSString* )accountTime andAccountCardLabel:(NSString* )accountCard
{
    self.AccountMoney.text = [NSString stringWithFormat:@"-%@",accountMoney];
    self.AccountTime.text = accountTime;
    self.AccountCard.text = accountCard;
}

@end
