//
//  ChooseBusinessTimeView.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/23.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ChooseBusinessTimeView.h"

@interface ChooseBusinessTimeView ()

@property (nonatomic, strong) UILabel* timeLabel;

@end

@implementation ChooseBusinessTimeView


+ (instancetype)initChooseBusinessTimeView
{
    return [[self alloc] init];
}

- (void)creatChooseBusinessTimeView
{
    [self setBackgroundColor:HDCColor(250, 250, 250)];
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = HDCColor(102, 102, 102);
    self.timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(25);
        make.centerY.mas_equalTo(self.centerY);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.25);
        make.height.mas_equalTo(self.timeLabel.mas_width).multipliedBy(0.35);
    }];
    self.businessTime = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.businessTime setTitleColor:HDCColor(35, 188, 49) forState:UIControlStateNormal];
    self.businessTime.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [self addSubview:self.businessTime];
    [self.businessTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-57);
        make.top.equalTo(self.timeLabel);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.25);
        make.height.equalTo(self.timeLabel);
    }];
}

- (void)setTimeLabelText:(NSString* )timeLabelText andBusinessTimeTitle:(NSString* )businessTimeTitle
{
    self.timeLabel.text = timeLabelText;
    [self.businessTime setTitle:businessTimeTitle forState:UIControlStateNormal];
}

@end
