//
//  TakeMoneyCell.m
//  BuyFood
//
//  Created by 黄栋春 on 16/7/1.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "TakeMoneyCell.h"

@interface TakeMoneyCell ()
@property (nonatomic, strong) UILabel* titleLabel;



@end

@implementation TakeMoneyCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    TakeMoneyCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[TakeMoneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = HDCColor(102, 102, 102);
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.width.equalTo(@(65));
        make.height.equalTo(@(30));
    }];
    
    self.inputText = [[UITextField alloc] init];
    self.inputText.textColor = HDCColor(102, 102, 102);
    self.inputText.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [self.contentView addSubview:self.inputText];
    [self.inputText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(5);
        make.top.equalTo(self.titleLabel);
        make.width.equalTo(@(200));
        make.height.equalTo(@(30));
    }];
}
- (void)setUpTitleText:(NSString* )titleLabel andInputTextPlaceholder:(NSString* )placeholder andInputText:(NSString* )inputText;
{
    self.titleLabel.text = titleLabel;
    self.inputText.placeholder = placeholder;
    self.inputText.text = inputText;
}
@end
