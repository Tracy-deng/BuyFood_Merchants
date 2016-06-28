//
//  CardCell.m
//  CashIn【提现】
//
//  Created by 黄栋春 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "CardCell.h"

@interface CardCell ()

@property (nonatomic, strong) UIImageView* backGroundImageView;
@property (nonatomic, strong) UILabel* bankName;
@property (nonatomic, strong) UILabel* cardType;
@property (nonatomic, strong) UILabel* cardNumber;

@end

@implementation CardCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    CardCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.layer.cornerRadius = 10;
        cell.layer.masksToBounds = YES;
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
    self.backGroundImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.backGroundImageView];
    [self.backGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(self.contentView.mas_height);
    }];
    
    self.bankName = [[UILabel alloc] init];
    self.bankName.textColor = [UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1];
    self.bankName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [self.backGroundImageView addSubview:self.bankName];
    [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundImageView.mas_left).offset(40);
        make.top.mas_equalTo(self.backGroundImageView.mas_top).offset(20);
        make.width.mas_equalTo(self.backGroundImageView.mas_width).multipliedBy(0.40);
        make.height.mas_equalTo(self.bankName.mas_width).multipliedBy(0.15);
    }];
    
    self.cardType = [[UILabel alloc] init];
    self.cardType.textColor = [UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1];
    self.cardType.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.backGroundImageView addSubview:self.cardType];
    [self.cardType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankName);
        make.top.mas_equalTo(self.bankName.mas_bottom).offset(5);
        make.width.mas_equalTo(self.backGroundImageView.mas_width).multipliedBy(0.15);
        make.height.mas_equalTo(self.cardType.mas_width).multipliedBy(0.43);
    }];
    
    self.cardNumber = [[UILabel alloc] init];
    self.cardNumber.textColor = [UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1];
    self.cardNumber.font = [UIFont fontWithName:@"PingFangSC-Regular" size:24];
    [self.backGroundImageView addSubview:self.cardNumber];
    [self.cardNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankName);
        make.top.mas_equalTo(self.cardType.mas_bottom).offset(30);
        make.width.mas_equalTo(self.backGroundImageView.mas_width).multipliedBy(0.80);
        make.height.mas_equalTo(self.cardNumber.mas_width).multipliedBy(0.10);
    }];
}

- (void)setUpBackGroundImageName:(NSString* )backGroundImage andBankName:(NSString* )bankName andCardType:(NSString* )cardType andCardNumber:(NSString* )cardNumber
{
    self.backGroundImageView.image = [UIImage imageNamed:backGroundImage];
    self.bankName.text = bankName;
    self.cardType.text = cardType;
    self.cardNumber.text = cardNumber;
}

@end
