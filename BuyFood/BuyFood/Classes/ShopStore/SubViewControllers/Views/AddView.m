//
//  AddView.m
//  CashIn【提现】
//
//  Created by 黄栋春 on 16/6/28.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "AddView.h"
#import "Masonry.h"

@implementation AddView

+ (instancetype)initAddView
{
    return [[self alloc] init];
}

- (void)setUpContentView
{
    self.titleLabel = [[UILabel alloc] init];
//    self.titleLabel.text = @"姓名";
    self.titleLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.equalTo(@(60));
        make.height.equalTo(@(30));
    }];
    self.textField = [[UITextField alloc] init];
//    self.textField.placeholder = @"请输入姓名";
    self.textField.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    self.textField.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(5);
        make.top.equalTo(self.titleLabel);
        make.width.equalTo(@(SCREEN_WIDTH - 30 - 60));
        make.height.equalTo(self.titleLabel);
    }];
    self.line = [[UILabel alloc] init];
    self.line.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1];
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 10));
        make.height.equalTo(@(1));
    }];
}

- (void)setTitleLabelText:(NSString* )titleText andTextFieldPlaceholder:(NSString* )placeholder andTextFieldText:(NSString* )textFieldText;
{
    self.titleLabel.text = titleText;
    self.textField.placeholder = placeholder;
    self.textField.text = textFieldText;
}

@end
