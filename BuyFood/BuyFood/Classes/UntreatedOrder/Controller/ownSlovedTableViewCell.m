//
//  ownSlovedTableViewCell.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ownSlovedTableViewCell.h"

@implementation ownSlovedTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _pushAddTimeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_pushAddTimeBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 13"] forState:(UIControlStateNormal)];
        [_pushAddTimeBtn setTitle:@"买家取消" forState:(UIControlStateNormal)];;
        _pushAddTimeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_pushAddTimeBtn];
        [_pushAddTimeBtn setTitleColor:greenColor forState:(UIControlStateNormal)];;
        [_pushAddTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(37);
            make.left.equalTo(self.orderNumLabel);
            make.width.equalTo(@(0.4*SCREEN_WIDTH));
            make.height.equalTo(@20);
            
        }];
        
        
        
        
        _addOrderLabel = [[UILabel alloc]init];;
        _addOrderLabel.layer.masksToBounds = YES;
        _addOrderLabel.layer.cornerRadius = 32;
        _addOrderLabel.backgroundColor = [UIColor colorWithWhite:0.704 alpha:1.000];
        _addOrderLabel.text = @"已取消";
        _addOrderLabel.font = [UIFont systemFontOfSize:13];
        _addOrderLabel.textColor = [UIColor whiteColor];
        _addOrderLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_addOrderLabel];
        [_addOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(35);
            make.right.equalTo(self.contentView).offset(-10);
            make.width.height.equalTo(@64);
        }];
        
        
    }
    return self;
}

- (void)setModel:(OrderMarketModel *)model
{
    self.orderNumLabel.text = model.orderno;
    self.timeLabel.text = model.ordertime;
    self.addressLabel.text = model.useraddress;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.markettotalmoney];
    if ([model.orderstatus isEqualToString:@"3"])
    {
        self.addOrderLabel.text = @"已接单";
    }else if ([model.orderstatus isEqualToString:@"10"]){
        self.addOrderLabel.text = @"配送中";
    }else if ([model.orderstatus isEqualToString:@"12"])
    {
        self.addOrderLabel.text = @"已完成";
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
