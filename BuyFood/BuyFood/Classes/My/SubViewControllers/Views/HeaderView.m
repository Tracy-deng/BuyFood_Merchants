//
//  HeaderView.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "HeaderView.h"
#import "Line.h"

@interface HeaderView ()

/** 订单号 */
@property (nonatomic, strong) UILabel* orderNumberLabel;
/** 送达时间 */
@property (nonatomic, strong) UIButton* getTimeBtn;
/** 下单时间 */
@property (nonatomic, strong) UILabel* orderTimeLabel;
/** 下单地址 */
@property (nonatomic, strong) UILabel* orderAddressLabel;

@end

@implementation HeaderView

+ (instancetype)initWithHeaderView
{
    return [[self alloc] init];
}

- (void)setUpContentView
{

    
    // 订单号 orderNumberLabel
    self.orderNumberLabel = [[UILabel alloc] init];
    self.orderNumberLabel.textColor = HDCColor(153, 153, 153);
    self.orderNumberLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self addSubview:self.orderNumberLabel];
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(74);
        make.left.equalTo(self.mas_left).offset(50);
        make.width.mas_equalTo(@300);
        make.height.mas_equalTo(@25);
    }];
    // 送达时间 getTimeBtn
    self.getTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getTimeBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 13"] forState:UIControlStateNormal];
    self.getTimeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.getTimeBtn setTitleColor:HDCColor(35, 189, 52) forState:UIControlStateNormal];
    [self addSubview:self.getTimeBtn];
    [self.getTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumberLabel.mas_bottom).offset(5);
        make.left.equalTo(self.orderNumberLabel);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.30);
        make.height.mas_equalTo(self.orderNumberLabel.mas_width).multipliedBy(0.10);
    }];
    // 下单时间 orderTimeLabel
    self.orderTimeLabel = [[UILabel alloc] init];
    self.orderTimeLabel.textColor = HDCColor(102, 102, 102);
    self.orderTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self addSubview:self.orderTimeLabel];
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumberLabel.mas_bottom).offset(29);
        make.left.equalTo(self.orderNumberLabel.mas_left);
        make.width.mas_equalTo(@300);
        make.height.mas_equalTo(@25);
    }];
    // 下单地址 orderAddressLabel
    self.orderAddressLabel = [[UILabel alloc] init];
    self.orderAddressLabel.textColor = HDCColor(102, 102, 102);
    self.orderAddressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self addSubview:self.orderAddressLabel];
    self.orderAddressLabel.numberOfLines = 0;
    [self.orderAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderTimeLabel.mas_bottom).offset(2);
        make.left.equalTo(self.orderNumberLabel.mas_left);
        make.width.mas_equalTo(@280);
        make.height.mas_equalTo(@40);
    }];
    /** 分割线 HDCColor(224, 224, 224)*/  
    UILabel* line = [[UILabel alloc] init];
    [line setBackgroundColor:HDCColor(224, 224, 224)];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderAddressLabel.mas_bottom).offset(5);
        make.left.equalTo(self.mas_left).offset(5);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.95);
        make.height.equalTo(@1);
    }];
    
    /** 设置订单详情label */
    UILabel* infoLabel = [[UILabel alloc] init];
    infoLabel.textColor = HDCColor(102, 102, 102);
    infoLabel.text = @"订单详情";
    infoLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(30);
        make.width.equalTo(@100);//mas_equalTo(self.mas_width).multipliedBy(0.15)
        make.height.equalTo(@20);//mas_equalTo(infoLabel.width).multipliedBy(0.16)
    }];
}
- (void)setOrderNumberLabelText:(NSString* )orderNumberLabelText andGetTimeBtnText:(NSString* )getTimeBtnText andOrderTimeLabelText:(NSString* )orderTimeLabelText andOrderAddressLabelText:(NSString* )orderAddressLabelText
{

    self.orderNumberLabel.text = orderNumberLabelText;
    [self.getTimeBtn setTitle:getTimeBtnText forState:UIControlStateNormal];
    self.getTimeBtn.hidden = YES;
    self.orderTimeLabel.text = orderTimeLabelText;
    self.orderAddressLabel.text = orderAddressLabelText;
}


@end
