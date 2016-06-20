//
//  ComplaintOrderCell.m
//  BuyFood
//
//  Created by 黄栋春 on 16/6/20.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ComplaintOrderCell.h"

@interface ComplaintOrderCell()

/** 订单编号 */
@property (nonatomic, strong) UILabel* orderNumLabel;
/** 订单号 */
@property (nonatomic, strong) UILabel* orderNumberLabel;
/** 送达时间 */
@property (nonatomic, strong) UIButton* getTimeBtn;
/** 下单时间 */
@property (nonatomic, strong) UILabel* orderTimeLabel;
/** 下单地址 */
@property (nonatomic, strong) UILabel* orderAddressLabel;

@end

@implementation ComplaintOrderCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    ComplaintOrderCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[ComplaintOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    // 设置订单编号 orderNumLabel
    self.orderNumLabel = [[UILabel alloc] init];
    self.orderNumLabel.textColor = HDCColor(102, 102, 102);
    self.orderNumLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:25];
    [self.contentView addSubview:self.orderNumLabel];
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.14);
        make.height.mas_equalTo(self.orderNumLabel.mas_width).multipliedBy(0.6);
    }];
    
    // 订单号 orderNumberLabel
    self.orderNumberLabel = [[UILabel alloc] init];
    self.orderNumberLabel.textColor = HDCColor(153, 153, 153);
    self.orderNumberLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self.contentView addSubview:self.orderNumberLabel];
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumLabel.mas_top);
        make.left.equalTo(self.orderNumLabel.mas_right).offset(10);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.35);
        make.height.mas_equalTo(self.orderNumberLabel.mas_width).multipliedBy(0.17);
    }];
    // 送达时间 getTimeBtn
    self.getTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.getTimeBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 13"] forState:UIControlStateNormal];
    self.getTimeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.getTimeBtn setTitleColor:HDCColor(35, 189, 52) forState:UIControlStateNormal];
    [self.contentView addSubview:self.getTimeBtn];
    [self.getTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumberLabel.mas_bottom).offset(5);
        make.left.equalTo(self.orderNumberLabel);
        
        //        make.width.mas_offset([self boundingRectWithSize:self.getTimeBtn.titleLabel.text Font:self.getTimeBtn.titleLabel.font Size:self.getTimeBtn.size].width);
        //        make.height.mas_offset([self boundingRectWithSize:self.getTimeBtn.titleLabel.text Font:self.getTimeBtn.titleLabel.font Size:self.getTimeBtn.size].height);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.30);
        make.height.mas_equalTo(self.orderNumberLabel.mas_width).multipliedBy(0.15);
    }];
    
    // 下单时间 orderTimeLabel
    self.orderTimeLabel = [[UILabel alloc] init];
    self.orderTimeLabel.textColor = HDCColor(102, 102, 102);
    self.orderTimeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self.contentView addSubview:self.orderTimeLabel];
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderNumberLabel.mas_bottom).offset(29);
        make.left.equalTo(self.orderNumberLabel.mas_left);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.50);
        make.height.mas_equalTo(self.orderTimeLabel.mas_width).multipliedBy(0.12);
    }];
    // 下单地址 orderAddressLabel
    self.orderAddressLabel = [[UILabel alloc] init];
    self.orderAddressLabel.textColor = HDCColor(102, 102, 102);
    self.orderAddressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    [self.contentView addSubview:self.orderAddressLabel];
    [self.orderAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderTimeLabel.mas_bottom).offset(2);
        make.left.equalTo(self.orderNumberLabel.mas_left);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.50);
        make.height.mas_equalTo(self.orderTimeLabel.mas_width).multipliedBy(0.12);
    }];
}

- (void)setOrderNumLabelText:(NSString* )orderNumLabelText andOrderNumberLabelText:(NSString* )orderNumberLabelText andGetTimeBtnText:(NSString* )getTimeBtnText andOrderTimeLabelText:(NSString* )orderTimeLabelText andOrderAddressLabelText:(NSString* )orderAddressLabelText
{
    self.orderNumLabel.text = orderNumLabelText;
    self.orderNumberLabel.text = orderNumberLabelText;
    [self.getTimeBtn setTitle:getTimeBtnText forState:UIControlStateNormal];
    self.orderTimeLabel.text = orderTimeLabelText;
    self.orderAddressLabel.text = orderAddressLabelText;
}

@end
