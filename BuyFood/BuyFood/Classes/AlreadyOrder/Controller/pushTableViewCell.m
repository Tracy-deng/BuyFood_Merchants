//
//  pushTableViewCell.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "pushTableViewCell.h"

@implementation pushTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _pushAddTimeLabel = [UILabel new];
        _pushAddTimeLabel.layer.masksToBounds = YES;
        _pushAddTimeLabel.text = @"送达时间 11-07 09:00";
        _pushAddTimeLabel.layer.cornerRadius = 3;
        [self.contentView addSubview:_pushAddTimeLabel];
        _pushAddTimeLabel.font = [UIFont systemFontOfSize:13];
        _pushAddTimeLabel.textColor = greenColor;
        [_pushAddTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(35);
            make.left.equalTo(self.contentView).offset(86);
            make.right.equalTo(self.contentView).offset(110);
            make.height.equalTo(@30);
            
        }];
        
        
        _addOrderBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addOrderBtn.layer.masksToBounds = YES;
        _addOrderBtn.layer.cornerRadius = 32;
        _addOrderBtn.backgroundColor = [UIColor colorWithWhite:0.704 alpha:1.000];
        [_addOrderBtn setTitle:@"配送中" forState:(UIControlStateNormal)];
        _addOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_addOrderBtn];
        [_addOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(35);
            make.right.equalTo(self.contentView).offset(-10);
            make.width.height.equalTo(@64);
        }];
        
               
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
