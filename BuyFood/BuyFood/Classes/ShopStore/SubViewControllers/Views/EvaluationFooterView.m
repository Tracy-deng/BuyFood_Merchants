//
//  EvaluationFooterView.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/30.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "EvaluationFooterView.h"

@implementation EvaluationFooterView

+ (instancetype)initFootView
{
    return [[self alloc] init];
}

- (void)setUpContentView
{
    self.headerImage = [[UIImageView alloc] init];
    [self addSubview:self.headerImage];
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.15);
        make.height.equalTo(self.headerImage.mas_width);
    }];
    
    self.userName = [[UILabel alloc] init];
    self.userName.textColor = HDCColor(102, 102, 102);
    self.userName.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImage.mas_right).offset(20);
        make.top.equalTo(self.headerImage);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.25);
        make.height.mas_equalTo(self.userName.mas_width).multipliedBy(0.33);
    }];
    
    self.evaluate = [[UILabel alloc] init];
    self.evaluate.textColor = HDCColor(102, 102, 102);
    self.evaluate.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    [self addSubview:self.evaluate];
    [self.evaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userName.mas_right).offset(40);
        make.top.equalTo(self.headerImage);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.10);
        make.height.mas_equalTo(self.evaluate.mas_width).multipliedBy(0.50);
    }];
    self.evaluateContent = [[UILabel alloc] init];
    self.evaluateContent.textColor = HDCColor(102, 102, 102);
    self.evaluateContent.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    [self addSubview:self.evaluateContent];
    [self.evaluateContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.45);
        make.height.equalTo(self.evaluate);
    }];
    self.evaluateTime = [[UILabel alloc] init];
    self.evaluateTime.textAlignment = NSTextAlignmentCenter;
    self.evaluateTime.textColor = HDCColor(102, 102, 102);
    self.evaluateTime.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    [self addSubview:self.evaluateTime];
    [self.evaluateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.headerImage);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.20);
        make.height.equalTo(self.evaluate);
    }];
    self.replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.replyBtn setBackgroundImage:[UIImage imageNamed:@"rectangle1Copy2"] forState:UIControlStateNormal];
    [self.replyBtn setTitle:@"回复" forState:UIControlStateNormal];
    self.replyBtn.titleLabel.textColor = HDCColor(250, 250, 250);
    self.replyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    [self addSubview:self.replyBtn];
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.bottom.equalTo(self.evaluateContent);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.18);
        make.height.equalTo(self.replyBtn.mas_width).multipliedBy(0.35);
    }];
}

- (void)setFooterViewContentWithHeaderImage:(NSString* )imageName andUserName:(NSString* )userName andEvaluate:(NSString* )evaluate andEvaluateContent:(NSString* )evaluateContent andEvaluateTime:(NSString* )evaluateTime
{
    self.headerImage.image = [UIImage imageNamed:imageName];
    self.userName.text = userName;
    self.evaluate.text = evaluate;
    self.evaluateContent.text = evaluateContent;
    self.evaluateTime.text = evaluateTime;
}


@end
