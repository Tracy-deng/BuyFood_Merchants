//
//  SetPriceAdviceCell.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/26.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "SetPriceAdviceCell.h"

@interface SetPriceAdviceCell ()

@property (nonatomic, strong) UILabel* shopsName;
@property (nonatomic, strong) UIImageView* downOrUpImage;

@property (nonatomic, strong) UILabel* buyMoney;
@property (nonatomic, strong) UILabel* averagePrice;

@end

@implementation SetPriceAdviceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    SetPriceAdviceCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[SetPriceAdviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    self.shopsName = [[UILabel alloc] init];
    self.shopsName.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    self.shopsName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.contentView addSubview:self.shopsName];
    [self.shopsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.15);
        make.height.mas_equalTo(self.shopsName.mas_width).multipliedBy(0.65);
    }];
    
//    self.downOrUpImage = [[UIImageView alloc] init];
//    [self.contentView addSubview:self.downOrUpImage];
//    [self.downOrUpImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.contentView.mas_centerX);
//        make.top.mas_equalTo(self.contentView).offset(15);
//        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.04);
//        make.height.mas_equalTo(self.downOrUpImage.mas_width).multipliedBy(1.12);
//    }];
    
    self.buyMoney = [[UILabel alloc] init];
    self.buyMoney.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    self.buyMoney.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.contentView addSubview:self.buyMoney];
    [self.buyMoney mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.shopsName);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.18);
        make.height.equalTo(self.shopsName);
    }];
    
    self.averagePrice = [[UILabel alloc] init];
    self.averagePrice.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    self.averagePrice.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.contentView addSubview:self.averagePrice];
    [self.averagePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.shopsName);
        make.width.equalTo(self.buyMoney);
        make.height.equalTo(self.shopsName);
    }];
    
}

- (void)setModel:(PricingGuidanceModel *)model
{
    self.shopsName.text = model.productname;
    self.buyMoney.text = [NSString stringWithFormat:@"%@元/份",model.inprice];
    self.averagePrice.text = [NSString stringWithFormat:@"%@元/份",model.avgprice];
}

//- (void)setTitleLabel:(NSString* )title andBuyMoneyLabel:(NSString* )buyMoneyLabel andAveragePrice:(NSString* )averagePrice andDownOrImageName:(NSString* )imageName
//{
//    self.shopsName.text = title;
//    self.buyMoney.text = [NSString stringWithFormat:@"%@/份",buyMoneyLabel];
//    self.averagePrice.text = [NSString stringWithFormat:@"%@/份",averagePrice];;
//    self.downOrUpImage.image = [UIImage imageNamed:imageName];
//}
@end
