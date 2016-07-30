//
//  FooterView.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "FooterView.h"

@interface FooterView ()
/** 分割线*/
@property (nonatomic, strong) UILabel* line;
/** 合计金额 */
@property (nonatomic, strong) UILabel* totalMoney;
/** 订单号 */
@property (nonatomic, strong) UILabel* orderNum;
/** 订单号码*/
@property (nonatomic, strong) UILabel* orderNumber;

@end

@implementation FooterView

+ (instancetype)initWithFooterView
{
    return [[self alloc] init];
}

- (void)setUpContentView
{
    self.line = [[UILabel alloc] init];
    [self.line setBackgroundColor:HDCColor(224, 224, 224)];
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(5);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.95);
        make.height.equalTo(@1);
    }];

    self.totalMoney = [[UILabel alloc] init];
    self.totalMoney.textColor = HDCColor(153, 153, 153);
    self.totalMoney.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    [self addSubview:self.totalMoney];
    [self.totalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.line.mas_bottom).offset(5);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    self.orderNumber = [[UILabel alloc] init];
    self.orderNumber.textColor = HDCColor(153, 153, 153);
    self.orderNumber.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    [self addSubview:self.orderNumber];
    self.orderNumber.textAlignment = NSTextAlignmentRight;
    [self.orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.totalMoney);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.width.equalTo(@180);
        make.height.equalTo(@20);
    }];

}
- (void)setUpMoneyLabel:(NSString* )money andOrderNumberLabel:(NSString* )orderNumber
{
    self.totalMoney.text = [NSString stringWithFormat:@"合计:%@",money];
    self.orderNumber.text = [NSString stringWithFormat:@"订单号后四位: %@",orderNumber];
}
@end
