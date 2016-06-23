//
//  BusinessStatusView.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/23.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BusinessStatusView.h"

@interface BusinessStatusView ()

/** 营业状态*/
@property (nonatomic, strong) UILabel* businessStatus;

/** 商家头像 */
@property (nonatomic, strong) UIImageView* businessHeaderImageView;
/** 状态标签 */
@property (nonatomic, strong) UILabel* businessStatusLabel;
@end

@implementation BusinessStatusView

+ (instancetype)initBusinessStatusView
{
    return [[self alloc] init];
}

- (void)creatHeaderContentView
{
    [self setBackgroundColor:HDCColor(250, 250, 250)];
    self.businessHeaderImageView = [[UIImageView alloc] init];
    [self addSubview:self.businessHeaderImageView];
    [self.businessHeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(18);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.15);
        make.height.mas_equalTo(self.businessHeaderImageView.mas_width);
    }];
    self.businessStatus = [[UILabel alloc] init];
    self.businessStatus.textColor = HDCColor(35, 188, 49);
    self.businessStatus.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self addSubview:self.businessStatus];
    [self.businessStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.businessHeaderImageView);
        make.left.mas_equalTo(self.businessHeaderImageView.mas_right).offset(17);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.30);
        make.height.mas_equalTo(self.businessHeaderImageView.mas_width).multipliedBy(0.46);
    }];
    self.businessTime = [[UIButton alloc] init];
    self.businessTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.businessTime setTitleColor:HDCColor(153, 153, 153) forState:UIControlStateNormal];
    self.businessTime.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self addSubview:self.businessTime];
    [self.businessTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.businessStatus.mas_bottom).offset(15);
        make.left.equalTo(self.businessStatus);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.45);
        make.height.mas_equalTo(self.businessStatus.mas_width).multipliedBy(0.11);
    }];
    UILabel* btnLine = [[UILabel alloc] init];
    [btnLine setBackgroundColor:HDCColor(153, 153, 153)];
    [self addSubview:btnLine];
    [btnLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.businessTime.mas_bottom).offset(0.5);
        make.left.equalTo(self.businessStatus);
        make.width.equalTo(self.businessTime);
        make.height.equalTo(@1);
    }];
    UILabel* dividerLine = [[UILabel alloc] init];
    [dividerLine setBackgroundColor:HDCColor(153, 153, 153)];
    [self addSubview:dividerLine];
    [dividerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnLine.mas_bottom).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(13);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.93);
        make.height.equalTo(@1);
    }];
    self.businessStatusLabel = [[UILabel alloc] init];
    self.businessStatusLabel.textColor = HDCColor(153, 153, 153);
    self.businessStatusLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self addSubview:self.businessStatusLabel];
    [self.businessStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-8);
        make.left.equalTo(self.businessHeaderImageView);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.55);
        make.height.mas_equalTo(self.businessStatus.mas_width).multipliedBy(0.15);
    }];
}
- (void)setHeaderImageViewName:(NSString* )headerImageViewName andBusinessStatus:(NSString* )businessStatus andBusinessTime:(NSString* )businessTime andBusinessStatusLabel:(NSString* )businessStatusLabel
{
    self.businessHeaderImageView.image = [UIImage imageNamed:headerImageViewName];
    [self.businessTime setTitle:[NSString stringWithFormat:@"营业时间：%@",businessTime] forState:UIControlStateNormal];
    self.businessStatus.text = businessStatus;
    self.businessStatusLabel.text = businessStatusLabel;
}
@end
