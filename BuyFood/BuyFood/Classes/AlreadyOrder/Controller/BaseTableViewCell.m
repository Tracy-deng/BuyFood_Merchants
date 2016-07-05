//
//  BaseTableViewCell.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/21.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = HDCColor(238, 238, 238);
        
        _greenView = [[UIView alloc]init];
        [self.contentView addSubview:_greenView];
        _greenView.backgroundColor = greenColor;
        _greenView.layer.masksToBounds = YES;
        _greenView.layer.cornerRadius = 2;
        [_greenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(4.5);
            make.left.equalTo(self.contentView).offset(5);
            make.right.equalTo(self.contentView).offset(-5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        }];
        
        _whiteView = [[UIView alloc]init];
        [_greenView addSubview:_whiteView];
        _whiteView.backgroundColor = [UIColor whiteColor];
        [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_greenView).offset(7);
            make.left.equalTo(_greenView);
            make.right.equalTo(_greenView);
            make.bottom.equalTo(_greenView);
        }];
        
        _lineView = [UIView new];
        [_whiteView addSubview:_lineView];
        _lineView.backgroundColor = [UIColor blackColor];
        _lineView.alpha = 0.1;
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_whiteView);
            make.right.equalTo(_whiteView);
            make.height.equalTo(@1.5);
            make.bottom.equalTo(_whiteView.mas_bottom).offset(-30);
        }];
        
        
#pragma mark -- UI控件的布局
        
        _numberLabel = [[UILabel alloc]init];
        _numberLabel.textColor = HDCColor(102, 102, 102);
        _numberLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:30];
        _numberLabel.text = @"#54";
        [_whiteView addSubview:_numberLabel];
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_whiteView).offset(5);
            make.left.equalTo(_whiteView).offset(20);
            make.width.equalTo(@50);;
            make.height.equalTo(@42);
        }];
        
        
        _orderNumLabel = [[UILabel alloc]init];
        _orderNumLabel.textColor = [UIColor grayColor];
        _orderNumLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        _orderNumLabel.text = @"订单号 145443455";
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        [_whiteView addSubview:_orderNumLabel];
        [_orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_numberLabel);
            make.left.equalTo(_numberLabel.mas_right).offset(12);
            make.height.equalTo(@20);
            make.right.equalTo(_whiteView).offset(-20);
        }];
        
        _timeLabel = [UILabel new];
        _timeLabel.text = @"下单时间 11 -6   09:00";
        _timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [_whiteView addSubview:_timeLabel];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = [UIColor grayColor];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_orderNumLabel.mas_bottom).offset(29);
            make.left.equalTo(_whiteView).offset(80);
            make.height.equalTo(@20);
            make.right.equalTo(_whiteView).offset(100);
        }];
        
        _addressLabel = [UILabel new];
        _addressLabel.textColor = [UIColor grayColor];
        _addressLabel.text = @"紫东国际创意园e1栋3楼";
        [_whiteView addSubview:_addressLabel];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_timeLabel.mas_bottom).offset(2);
            make.left.height.equalTo(_timeLabel);
            make.right.equalTo(_whiteView).offset(80);
        }];
        
    
        
        _allLabel = [UILabel new];
        _allLabel.text = @"合计";
        _allLabel.textColor = [UIColor grayColor];
        _allLabel.font = [UIFont systemFontOfSize:12];
        [_whiteView addSubview:_allLabel];
        [_allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_lineView).offset(2);
            make.left.equalTo(_whiteView).offset(17);
            make.height.equalTo(@30);
            make.width.equalTo(@30);
        }];
        
        _moneyLabel = [UILabel new];
        _moneyLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:17];
        _moneyLabel.text = @"¥56";
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        [_whiteView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_allLabel);
            make.left.equalTo(_allLabel.mas_right).offset(5);
            make.height.equalTo(@30);
            make.width.equalTo(@200);
        }];
        
        _detailBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_detailBtn setTitle:@"查看详情" forState:(UIControlStateNormal)];
        [_detailBtn setTitleColor:greenColor forState:(UIControlStateNormal)];
        [_whiteView addSubview:_detailBtn];
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_moneyLabel);
            make.right.equalTo(_whiteView).offset(-10);
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
