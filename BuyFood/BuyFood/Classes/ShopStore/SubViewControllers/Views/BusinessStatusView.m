//
//  BusinessStatusView.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/23.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BusinessStatusView.h"
#import "ShopsUserInfoTool.h"
#import "ShopsUserInfo.h"
#import "UIImageView+WebCache.h"

@interface BusinessStatusView ()

/** 营业状态*/
@property (nonatomic, strong) UILabel* businessStatus;

/** 状态标签 */
@property (nonatomic, strong) UILabel* businessStatusLabel;

@property (nonatomic, strong) ShopsUserInfo *userInfo;

@end

@implementation BusinessStatusView

+ (instancetype)initBusinessStatusView
{
    return [[self alloc] init];
}

- (void)creatHeaderContentView
{
    self.userInfo = [ShopsUserInfoTool account];
    [self setBackgroundColor:HDCColor(250, 250, 250)];
    self.businessHeaderImageView = [[UIImageView alloc] init];
    [self.businessHeaderImageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.pic]];
    [self addSubview:self.businessHeaderImageView];
    [self.businessHeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(18);
       make.width.height.equalTo(@(50));
    }];
    
    self.businessHeaderImageView.layer.masksToBounds = YES;
    self.businessHeaderImageView.layer.cornerRadius = 50 * 0.5;
    self.businessHeaderImageView.layer.borderWidth = 1.0;
    self.businessHeaderImageView.layer.borderColor=[[UIColor whiteColor] CGColor];//边框颜色
    
    
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
- (void)setBusinessStatus:(NSString* )businessStatus andBusinessTime:(NSString* )businessTime andBusinessStatusLabel:(NSString* )businessStatusLabel
{
    [self.businessTime setTitle:[NSString stringWithFormat:@"营业时间：%@",businessTime] forState:UIControlStateNormal];
    self.businessStatus.text = businessStatus;
    self.businessStatusLabel.text = businessStatusLabel;
}
@end
