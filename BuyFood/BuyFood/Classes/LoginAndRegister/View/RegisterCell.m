//
//  RegisterCell.m
//  BuyFood
//
//  Created by 黄栋春 on 16/7/10.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "RegisterCell.h"


@implementation RegisterCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    RegisterCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[RegisterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    self.leftTitleLabel = [[UILabel alloc] init];
    [self addSubview:self.leftTitleLabel];
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    self.contentTextField = [[UITextField alloc] init];
    [self addSubview:self.contentTextField];
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTitleLabel.mas_right).offset(5);
        make.top.equalTo(self.leftTitleLabel);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
}

- (void)setLeftTitleLabel:(NSString* )leftTitleLabel andContentTextFieldPlaceholder:(NSString* )textFieldPlaceholder 
{
    self.leftTitleLabel.text = leftTitleLabel;
    self.contentTextField.placeholder = textFieldPlaceholder;
}

@end
