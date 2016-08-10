//
//  pushTableViewCell.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "pushTableViewCell.h"
#import "orderStatus.h"
@implementation pushTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _pushAddTimeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_pushAddTimeBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 13"] forState:(UIControlStateNormal)];
        [_pushAddTimeBtn setTitle:@"送达时间 11-07 09:00" forState:(UIControlStateNormal)];;
        _pushAddTimeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_pushAddTimeBtn];
        [_pushAddTimeBtn setTitleColor:greenColor forState:(UIControlStateNormal)];;
        [_pushAddTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(37);
            make.left.equalTo(self.orderNumLabel);
            make.width.equalTo(@(0.4*SCREEN_WIDTH));
            make.height.equalTo(@20);
            
        }];
        

        
        
        _addOrderLabel = [[UILabel alloc]init];
        _addOrderLabel.layer.masksToBounds = YES;
        _addOrderLabel.layer.cornerRadius = 32;
        _addOrderLabel.backgroundColor = [UIColor colorWithWhite:0.704 alpha:1.000];
        _addOrderLabel.text = @"配送中";
        _addOrderLabel.font = [UIFont systemFontOfSize:11];
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
    self.addOrderLabel.text = [[orderStatus shareBillStatus]getOrderStatus:model.orderstatus];
    
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
