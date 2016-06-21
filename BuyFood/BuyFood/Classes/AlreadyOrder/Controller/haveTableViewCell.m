//
//  haveTableViewCell.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/20.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "haveTableViewCell.h"

@implementation haveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
      
        _addOrderBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addOrderBtn.layer.masksToBounds = YES;
        _addOrderBtn.layer.cornerRadius = 32;
        _addOrderBtn.backgroundColor = greenColor;
        [_addOrderBtn setTitle:@"已接单" forState:(UIControlStateNormal)];
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
