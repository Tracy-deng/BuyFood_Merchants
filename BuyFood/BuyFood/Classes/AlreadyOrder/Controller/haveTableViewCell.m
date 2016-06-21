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
        
        self.contentView.backgroundColor = HDCColor(238, 238, 238);
        
        UIView *greenView = [[UIView alloc]init];
        [self.contentView addSubview:greenView];
        greenView.backgroundColor = greenColor;
        greenView.layer.masksToBounds = YES;
        greenView.layer.cornerRadius = 2;
        [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(4.5);
            make.left.equalTo(self.contentView).offset(5);
            make.right.equalTo(self.contentView).offset(-5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
        
        UIView *whiteView = [[UIView alloc]init];
        [greenView addSubview:whiteView];
        whiteView.backgroundColor = [UIColor whiteColor];
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(greenView).offset(7);
            make.left.equalTo(greenView);
            make.right.equalTo(greenView);
            make.bottom.equalTo(greenView);
        }];
        
        UIView *lineView = [UIView new];
        [whiteView addSubview:lineView];
        lineView.backgroundColor = [UIColor blackColor];
        lineView.alpha = 0.1;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(whiteView);
            make.right.equalTo(whiteView);
            make.height.equalTo(@1.5);
            make.bottom.equalTo(whiteView.mas_bottom).offset(-30);
        }];
        
        
#pragma mark -- UI控件的布局
        
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:30];
        _numberLabel.text = @"#54";
        [whiteView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(whiteView).offset(5);
            make.left.equalTo(whiteView).offset(20);
            make.width.equalTo(@50);;
            make.height.equalTo(@42);
        }];
    
        
        _orderNumLabel = [[UILabel alloc]init];
        _orderNumLabel.textColor = [UIColor grayColor];
        _orderNumLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _orderNumLabel.text = @"订单号 145443455";
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        [whiteView addSubview:_orderNumLabel];
        [_orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_numberLabel);
            make.left.equalTo(_numberLabel.mas_right).offset(12);
            make.height.equalTo(@20);
            make.right.equalTo(whiteView).offset(-20);
        }];
        
        _timeLabel = [UILabel new];
        _timeLabel.text = @"下单时间 11 -6   09:00";
        _timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [whiteView addSubview:_timeLabel];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor grayColor];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_orderNumLabel.mas_bottom).offset(29);
            make.left.equalTo(whiteView).offset(80);
            make.height.equalTo(@20);
            make.right.equalTo(whiteView).offset(100);
        }];
        
        _addressLabel = [UILabel new];
        _addressLabel.textColor = [UIColor grayColor];
        _addressLabel.text = @"紫东国际创意园e1栋3楼";
        [whiteView addSubview:_addressLabel];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_timeLabel.mas_bottom).offset(2);
            make.left.height.equalTo(_timeLabel);
            make.right.equalTo(whiteView).offset(80);
        }];
        
        
        _addOrderBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addOrderBtn.layer.masksToBounds = YES;
        _addOrderBtn.layer.cornerRadius = 32;
        _addOrderBtn.backgroundColor = greenColor;
        [_addOrderBtn setTitle:@"已接单" forState:(UIControlStateNormal)];
        _addOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [whiteView addSubview:_addOrderBtn];
        [_addOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_orderNumLabel.mas_bottom);
            make.right.equalTo(whiteView).offset(-10);
            make.width.height.equalTo(@64);
        }];
        
        _allLabel = [UILabel new];
        _allLabel.text = @"合计";
        _allLabel.textColor = [UIColor grayColor];
        _allLabel.font = [UIFont systemFontOfSize:12];
        [whiteView addSubview:_allLabel];
        [_allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView).offset(2);
            make.left.equalTo(whiteView).offset(17);
            make.height.equalTo(@30);
            make.width.equalTo(@30);
        }];
        
        _moneyLabel = [UILabel new];
        _moneyLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:17];
        _moneyLabel.text = @"¥56";
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        [whiteView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_allLabel);
            make.left.equalTo(_allLabel.mas_right).offset(5);
            make.height.equalTo(@30);
            make.width.equalTo(@200);
        }];
        
        _detailBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_detailBtn setTitle:@"查看详情" forState:(UIControlStateNormal)];
        [_detailBtn setTitleColor:greenColor forState:(UIControlStateNormal)];
        [whiteView addSubview:_detailBtn];
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_moneyLabel);
            make.right.equalTo(whiteView).offset(-10);
            make.width.equalTo(@60);
            make.height.equalTo(@30);
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
