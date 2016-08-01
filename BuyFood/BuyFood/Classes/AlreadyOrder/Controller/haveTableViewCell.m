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
        
      
        _addOrderBtn = [[UILabel alloc]init];;
        _addOrderBtn.layer.masksToBounds = YES;
        _addOrderBtn.layer.cornerRadius = 32;
        _addOrderBtn.backgroundColor = greenColor;
        _addOrderBtn.text = @"已接单";
        _addOrderBtn.textColor = [UIColor whiteColor];
        _addOrderBtn.textAlignment = NSTextAlignmentCenter;
        _addOrderBtn.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_addOrderBtn];
        [_addOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
        self.addOrderBtn.text = @"已接单";
    }else if ([model.orderstatus isEqualToString:@"10"]){
        self.addOrderBtn.text = @"配送中";
    }else if ([model.orderstatus isEqualToString:@"12"])
    {
        self.addOrderBtn.text = @"已完成";
    }
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
