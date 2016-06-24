//
//  EvaluationHeaderView.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "EvaluationHeaderView.h"

@interface EvaluationHeaderView ()

/** 接单数量 */
@property (nonatomic, strong) UILabel* orderNumber;
/** 好评率*/
@property (nonatomic, strong) UILabel* greatEvaluation;

@end

@implementation EvaluationHeaderView

+ (instancetype)initEvaluationHeaderView
{
    return [[self alloc] init];
}

- (void)creatHeaderContentView
{
    self.orderNumber = [[UILabel alloc] init];
    self.orderNumber.font = [UIFont fontWithName:@"DINCondensed-Bold" size:30];
    self.orderNumber.textAlignment = NSTextAlignmentCenter;
    self.orderNumber.textColor = greenColor;
    [self addSubview:self.orderNumber];
    [self.orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(80);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.11);
        make.height.mas_equalTo(self.orderNumber.mas_width).multipliedBy(0.9);
    }];
    
    self.greatEvaluation = [[UILabel alloc] init];
    self.greatEvaluation.textAlignment = NSTextAlignmentCenter;
    self.greatEvaluation.font = [UIFont fontWithName:@"DINCondensed-Bold" size:30];
    self.greatEvaluation.textColor = greenColor;
    [self addSubview:self.greatEvaluation];
    [self.greatEvaluation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderNumber);
        make.right.mas_equalTo(self.mas_right).offset(-80);
        make.width.equalTo(self.orderNumber);
        make.height.equalTo(self.orderNumber);
    }];
    
    UILabel* orderNumber = [[UILabel alloc] init];
    orderNumber.text = @"接单数量";
    orderNumber.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    orderNumber.textColor = HDCColor(153, 153, 153);
    [self addSubview:orderNumber];
    [orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderNumber.mas_bottom).offset(5);
        make.centerX.equalTo(self.orderNumber.mas_centerX);
        make.width.equalTo(self.mas_width).multipliedBy(0.15);
        make.height.equalTo(orderNumber.mas_width).multipliedBy(0.3);
    }];
    UILabel* goodEvaluation = [[UILabel alloc] init];
    goodEvaluation.text = @"好评率";
    goodEvaluation.textAlignment = NSTextAlignmentCenter;
    goodEvaluation.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    goodEvaluation.textColor = HDCColor(153, 153, 153);
    [self addSubview:goodEvaluation];
    [goodEvaluation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderNumber);
        make.centerX.equalTo(self.greatEvaluation.mas_centerX);
        make.width.equalTo(orderNumber);
        make.height.equalTo(orderNumber);
    }];
}

- (void)setOrderNumberLabel:(NSString* )orderNumber andGreatEvaluationLabel:(NSString* )greatEvaluation
{
    self.orderNumber.text = orderNumber;
    self.greatEvaluation.text = greatEvaluation;
}
@end
