//
//  AddShopsCell.m
//  BuyFood
//
//  Created by 黄栋春 on 16/7/26.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "AddShopsCell.h"

@implementation AddShopsCell

- (instancetype)initWithInputCellStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.top.mas_equalTo(self.contentView.mas_top).offset(15);
            make.width.equalTo(@100);
            make.height.equalTo(@30);
        }];
        
        self.contentTextField = [[UITextField alloc] init];
        self.contentTextField.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
        self.contentTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        [self.contentView addSubview:self.contentTextField];
        [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel.mas_right).offset(20);
            make.top.equalTo(self.titleLabel);
            make.width.equalTo(@150);
            make.height.equalTo(@35);
        }];
    }
    return self;
}

- (instancetype)initWithChooseCellStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.chooseLabel = [[UILabel alloc] init];
        self.chooseLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
        self.chooseLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        [self.contentView addSubview:self.chooseLabel];
        [self.chooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(10);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.equalTo(@100);
            make.height.equalTo(@30);
        }];
        
        self.chooseContentLabel = [[UILabel alloc] init];
        self.chooseContentLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
        self.chooseContentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
        [self.contentView addSubview:self.chooseContentLabel];
        [self.chooseContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.self.chooseLabel.mas_right).offset(15);
            make.top.equalTo(self.chooseLabel);
            make.width.equalTo(@200);
            make.height.equalTo(self.self.chooseLabel);
        }];
    }
    return self;
}

- (void)setTitleLabel:(NSString* )title andContentTextFieldPlaceholder:(NSString* )contentTextFieldPlaceholder
{
    self.titleLabel.text = title;
    self.contentTextField.placeholder = contentTextFieldPlaceholder;
}

- (void)setChooseTitleLabel:(NSString* )title andContentLabel:(NSString* )contentText;
{
    self.chooseLabel.text = title;
    self.chooseContentLabel.text = contentText;
}



@end
