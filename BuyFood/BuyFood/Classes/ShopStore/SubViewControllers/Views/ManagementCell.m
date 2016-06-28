//
//  ManagementCell.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ManagementCell.h"

@interface ManagementCell ()

@property (nonatomic, strong) UIImageView* shopsImage;
@property (nonatomic, strong) UILabel* shopsName;
@property (nonatomic, strong) UILabel* shopsWeight;
@property (nonatomic, strong) UILabel* shopsSpecifications;
@property (nonatomic, strong) UILabel* shopsOriginalPriceTitle;
@property (nonatomic, strong) UILabel* shopsOriginalPrice;
@property (nonatomic, strong) UILabel* shopsPromotionPriceTitle;
@property (nonatomic, strong) UILabel* shopsPromotionPrice;

@end

@implementation ManagementCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    ManagementCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[ManagementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    /**
     UIImageView* shopsImage;
     UILabel* shopsName;
     UILabel* shopsWeight;
     UILabel* shopsSpecifications;
     UILabel* shopsOriginalPriceTitle;
     UILabel* shopsOriginalPrice;
     UILabel* shopsPromotionPriceTitle;
     UILabel* shopsPromotionPrice;
     */
    self.shopsImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.shopsImage];
    [self.shopsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(self.contentView.frame.size.width * 0.07));
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.17);
        make.height.equalTo(self.shopsImage.mas_width);
    }];
    
    self.shopsName = [[UILabel alloc] init];
    self.shopsName.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    self.shopsName.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self.contentView addSubview:self.shopsName];
    [self.shopsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.30);
        make.height.mas_equalTo(self.shopsName.mas_width).multipliedBy(0.20);
    }];
    
    self.shopsWeight = [[UILabel alloc] init];
    self.shopsWeight.textAlignment = NSTextAlignmentCenter;
    self.shopsWeight.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    self.shopsWeight.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    [self.contentView addSubview:self.shopsWeight];
    [self.shopsWeight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopsName);
        make.top.mas_equalTo(self.shopsName.mas_bottom).offset(15);
        make.width.equalTo(@(self.contentView.frame.size.width * 0.30 * 0.60));
        make.height.equalTo(self.shopsName);
    }];
    
    self.shopsSpecifications = [[UILabel alloc] init];
    self.shopsWeight.textAlignment = NSTextAlignmentLeft;
    self.shopsSpecifications.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    self.shopsSpecifications.font = [UIFont fontWithName:@"PingFangSC-Regular" size:18];
    [self.contentView addSubview:self.shopsSpecifications];
    [self.shopsSpecifications mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopsWeight.mas_right);
        make.top.equalTo(self.shopsWeight);
        make.width.equalTo(@(self.contentView.frame.size.width * 0.30 * 0.35));
        make.height.equalTo(self.shopsWeight);
    }];
    
    self.shopsOriginalPrice = [[UILabel alloc] init];
    self.shopsOriginalPrice.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    self.shopsOriginalPrice.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self.contentView addSubview:self.shopsOriginalPrice];
    [self.shopsOriginalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.shopsName);
        make.width.equalTo(@(self.contentView.frame.size.width * 0.29 * 0.50));
        make.height.equalTo(self.shopsName);
    }];
    
    self.shopsOriginalPriceTitle = [[UILabel alloc] init];
    self.shopsOriginalPriceTitle.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    self.shopsOriginalPriceTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self.contentView addSubview:self.shopsOriginalPriceTitle];
    [self.shopsOriginalPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.shopsOriginalPrice.mas_left).offset(-5);
        make.top.equalTo(self.shopsName);
        make.width.equalTo(@(self.contentView.frame.size.width * 0.29 * 0.50));
        make.height.equalTo(self.shopsName);
    }];
    
    self.shopsPromotionPrice = [[UILabel alloc] init];
    self.shopsPromotionPrice.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    self.shopsPromotionPrice.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self.contentView addSubview:self.shopsPromotionPrice];
    [self.shopsPromotionPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.shopsWeight);
        make.width.equalTo(@(self.contentView.frame.size.width * 0.30 * 0.40));
        make.height.equalTo(self.shopsName);
    }];
    
    self.shopsPromotionPriceTitle = [[UILabel alloc] init];
    self.shopsPromotionPriceTitle.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    self.shopsPromotionPriceTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self.contentView addSubview:self.shopsPromotionPriceTitle];
    [self.shopsPromotionPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopsOriginalPriceTitle);
        make.top.equalTo(self.shopsWeight);
        make.width.equalTo(@(self.contentView.frame.size.width * 0.29 * 0.60));
        make.height.equalTo(self.shopsOriginalPriceTitle);
    }];
}

/**
 UIImageView* shopsImage;
 UILabel* shopsName;
 UILabel* shopsWeight;
 UILabel* shopsSpecifications;
 UILabel* shopsOriginalPriceTitle;
 UILabel* shopsOriginalPrice;
 UILabel* shopsPromotionPriceTitle;
 UILabel* shopsPromotionPrice;
 */
- (void)setShopsImageName:(NSString* )shopsImageName andShopsNameLabel:(NSString* )shopsName andShopsWeight:(NSString* )shopsWeight andShopsSpecifications:(NSString* )shopsSpecifications andShopsOriginalPriceTitle:(NSString* )shopsOriginalPriceTitle andShopsOriginalPrice:(NSString* )shopsOriginalPrice andShopsPromotionPriceTitle:(NSString* )shopsPromotionPriceTitle andShopsPromotionPrice:(NSString* )shopsPromotionPrice
{
    self.shopsImage.image = [UIImage imageNamed:shopsImageName];
    self.shopsName.text = shopsName;
    self.shopsWeight.text = shopsWeight;
    self.shopsSpecifications.text = shopsSpecifications;
    self.shopsOriginalPriceTitle.text = shopsOriginalPriceTitle;
    self.shopsOriginalPrice.text = shopsOriginalPrice;
    self.shopsPromotionPriceTitle.text = shopsPromotionPriceTitle;
    self.shopsPromotionPrice.text = shopsPromotionPrice;
}


@end
