//
//  ManagementCell.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ManagementCell.h"
#import "UIImageView+WebCache.h"
@interface ManagementCell ()
/** 商品图片 */
@property (nonatomic, strong) UIImageView* shopsImage;
/** 商品名称 */
@property (nonatomic, strong) UILabel* shopsName;
/** 商品原价标题 */
@property (nonatomic, strong) UILabel* shopsOriginalPriceTitle;
/** 商品原价 */
@property (nonatomic, strong) UILabel* shopsOriginalPrice;
/** 商品促销价标题 */
@property (nonatomic, strong) UILabel* shopsPromotionPriceTitle;
/** 商品促销价 */
@property (nonatomic, strong) UILabel* shopsPromotionPrice;
/** 活动时间 */
@property (nonatomic, strong) UILabel *time;

@end

@implementation ManagementCell
#pragma 促销管理自定义cell
+ (instancetype)cellWithSalesPromotionTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    ManagementCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[ManagementCell alloc] initWithSalesPromotionTableViewStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithSalesPromotionTableViewStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUpalesPromotionTableViewContentView];
    }
    return self;
}

- (void)setUpalesPromotionTableViewContentView
{
    /** 商品图片 */
    self.shopsImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.shopsImage];
    [self.shopsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(self.contentView.frame.size.width * 0.07));
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.17);
        make.height.equalTo(self.shopsImage.mas_width);
    }];
    /** 商品名称 */
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
    /** 商品重量 */
    self.shopsWeight = [[UILabel alloc] init];
    self.shopsWeight.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    self.shopsWeight.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.contentView addSubview:self.shopsWeight];
    self.shopsWeight.textAlignment = NSTextAlignmentLeft;
    [self.shopsWeight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopsName);
        make.top.mas_equalTo(self.shopsName.mas_bottom).offset(15);
        make.width.equalTo(@(45));
        make.height.equalTo(self.shopsName);
    }];
    /** 商品单位 */
    self.shopsSpecifications = [[UILabel alloc] init];
    self.shopsSpecifications.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    self.shopsSpecifications.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.contentView addSubview:self.shopsSpecifications];
    [self.shopsSpecifications mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopsWeight.mas_right);
        make.top.equalTo(self.shopsWeight);
        make.width.equalTo(@(40));
        make.height.equalTo(self.shopsWeight);
    }];
    /** 商品原价 */
    self.shopsOriginalPrice = [[UILabel alloc] init];
    self.shopsOriginalPrice.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    self.shopsOriginalPrice.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [self.contentView addSubview:self.shopsOriginalPrice];
    self.shopsOriginalPrice.textAlignment = NSTextAlignmentRight;
    [self.shopsOriginalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.shopsName);
        make.width.equalTo(@(self.contentView.frame.size.width * 0.18));
        make.height.equalTo(self.shopsName);
    }];
    /** 商品原价标题 */
    self.shopsOriginalPriceTitle = [[UILabel alloc] init];
    self.shopsOriginalPriceTitle.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    self.shopsOriginalPriceTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [self.contentView addSubview:self.shopsOriginalPriceTitle];
    self.shopsOriginalPriceTitle.textAlignment = NSTextAlignmentRight;
    [self.shopsOriginalPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.shopsOriginalPrice.mas_left).offset(-2);
        make.top.equalTo(self.shopsName);
        make.width.equalTo(@(50));
        make.height.equalTo(self.shopsName);
    }];
    /** 商品促销价 */
    self.shopsPromotionPrice = [[UILabel alloc] init];
    self.shopsPromotionPrice.textColor = [UIColor redColor];
    self.shopsPromotionPrice.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [self.contentView addSubview:self.shopsPromotionPrice];
    self.shopsPromotionPrice.textAlignment = NSTextAlignmentRight;
    [self.shopsPromotionPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shopsOriginalPrice);
        make.top.equalTo(self.shopsWeight);
        make.width.equalTo(@(self.contentView.frame.size.width * 0.18));
        make.height.equalTo(self.shopsName);
    }];
    /** 商品促销价标题 */
    self.shopsPromotionPriceTitle = [[UILabel alloc] init];
    self.shopsPromotionPriceTitle.textColor = [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1];
    self.shopsPromotionPriceTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [self.contentView addSubview:self.shopsPromotionPriceTitle];
    self.shopsPromotionPriceTitle.textAlignment = NSTextAlignmentRight;
    [self.shopsPromotionPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shopsOriginalPriceTitle);
        make.top.equalTo(self.shopsWeight);
        make.width.equalTo(@(50));
        make.height.equalTo(self.shopsOriginalPriceTitle);
    }];
}
- (void)setShopsImage:(NSString * )shopsImage andShopsNameLabel:(NSString* )shopsName andShopsWeight:(NSString* )shopsWeight andShopsSpecifications:(NSString* )shopsSpecifications andShopsOriginalPriceTitle:(NSString* )shopsOriginalPriceTitle andShopsOriginalPrice:(NSString* )shopsOriginalPrice andShopsPromotionPriceTitle:(NSString* )shopsPromotionPriceTitle andShopsPromotionPrice:(NSString* )shopsPromotionPrice
{
    [self.shopsImage sd_setImageWithURL:[NSURL URLWithString:shopsImage]];
    self.shopsName.text = shopsName;
    self.shopsWeight.text = shopsWeight;
    self.shopsSpecifications.text = shopsSpecifications;
    self.shopsOriginalPriceTitle.text = shopsOriginalPriceTitle;
    self.shopsOriginalPrice.text = shopsOriginalPrice;
    self.shopsPromotionPriceTitle.text = shopsPromotionPriceTitle;
    self.shopsPromotionPrice.text = shopsPromotionPrice;
}

#pragma 其他活动管理的自定义cell
+ (instancetype)cellWithOtherTableView:(UITableView *)tableView
{
    static NSString *ID = @"otherStatus";
    ManagementCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[ManagementCell alloc] initWithOtherTableViewStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithOtherTableViewStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUpOtherTableViewContentView];
    }
    return self;
}

- (void)setUpOtherTableViewContentView
{
    /** 商品图片 */
    self.shopsImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.shopsImage];
    [self.shopsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(self.contentView.frame.size.width * 0.07));
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.17);
        make.height.equalTo(self.shopsImage.mas_width);
    }];
    /** 商品名称 */
    self.shopsName = [[UILabel alloc] init];
    self.shopsName.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    self.shopsName.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self.contentView addSubview:self.shopsName];
    [self.shopsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopsImage.mas_right).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.30);
        make.height.mas_equalTo(self.shopsName.mas_width).multipliedBy(0.20);
    }];
    /** 商品活动价标题 */
    self.shopsPromotionPriceTitle = [[UILabel alloc] init];
    self.shopsPromotionPriceTitle.textColor = HDCColor(102, 102, 102);
    self.shopsPromotionPriceTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [self.contentView addSubview:self.shopsPromotionPriceTitle];
    [self.shopsPromotionPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopsName);
        make.top.mas_equalTo(self.shopsName.mas_bottom).offset(15);
        make.width.equalTo(@(40));
        make.height.equalTo(@(25));
    }];
    /** 商品活动价 */
    self.shopsPromotionPrice = [[UILabel alloc] init];
    self.shopsPromotionPrice.textColor = [UIColor redColor];
    self.shopsPromotionPrice.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self.contentView addSubview:self.shopsPromotionPrice];
    [self.shopsPromotionPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopsPromotionPriceTitle.mas_right).offset(1);
        make.top.equalTo(self.shopsPromotionPriceTitle);
        make.width.equalTo(@(40));
        make.height.equalTo(@(25));
    }];
    
    /** 商品原价标题 */
    self.shopsOriginalPriceTitle = [[UILabel alloc] init];
    self.shopsOriginalPriceTitle.textColor = HDCColor(200, 200, 200);
    self.shopsOriginalPriceTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:10];
    [self.contentView addSubview:self.shopsOriginalPriceTitle];
    [self.shopsOriginalPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopsPromotionPrice.mas_right).offset(5);
        make.top.equalTo(self.shopsPromotionPriceTitle);
        make.width.equalTo(@(25));
        make.height.equalTo(self.shopsPromotionPriceTitle);
    }];
    /** 商品原价 */
    self.shopsOriginalPrice = [[UILabel alloc] init];
    self.shopsOriginalPrice.textColor = HDCColor(200, 200, 200);
    self.shopsOriginalPrice.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [self.contentView addSubview:self.shopsOriginalPrice];
    [self.shopsOriginalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shopsOriginalPriceTitle.mas_right).offset(1);
        make.top.equalTo(self.shopsPromotionPrice);
        make.width.equalTo(self.shopsPromotionPrice);
        make.height.equalTo(self.shopsPromotionPrice);
    }];
    /** 商品单位 */
    self.shopsSpecifications = [[UILabel alloc] init];
    self.shopsSpecifications.textColor = HDCColor(200, 200, 200);
    self.shopsSpecifications.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [self.contentView addSubview:self.shopsSpecifications];
    [self.shopsSpecifications mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-5);
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.width.equalTo(@(35));
        make.height.equalTo(@(20));
    }];
    /** 商品重量 */
    self.shopsWeight = [[UILabel alloc] init];
    self.shopsWeight.textAlignment = NSTextAlignmentRight;
    self.shopsWeight.textColor = HDCColor(200, 200, 200);
    self.shopsWeight.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [self.contentView addSubview:self.shopsWeight];
    [self.shopsWeight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.shopsSpecifications.mas_left).offset(0);
        make.top.equalTo(self.shopsSpecifications);
        make.width.equalTo(@(50));
        make.height.equalTo(self.shopsSpecifications);
    }];
    /** 活动时间 */
    self.time = [[UILabel alloc] init];
    self.time.textAlignment = NSTextAlignmentRight;
    self.time.textColor = [UIColor redColor];
    self.time.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-12);
        make.top.equalTo(self.shopsOriginalPriceTitle);
        make.width.equalTo(@(90));
        make.height.equalTo(@(25));
    }];
}

- (void)setModelList:(OutDoorModelList *)modelList
{
    [self.shopsImage sd_setImageWithURL:[NSURL URLWithString:modelList.pic]];
    self.shopsName.text = modelList.outname;
    self.shopsPromotionPriceTitle.text = @"报名费:";
    self.shopsPromotionPrice.text = [@"¥" stringByAppendingString:modelList.newprice];
    self.shopsOriginalPriceTitle.text = @"人数:";
    self.shopsOriginalPrice.text = [modelList.personcount stringByAppendingString:@"人"];
    NSString *timeStr = modelList.outtime;
    NSRange range = [timeStr rangeOfString:@"T"];
    NSString *time = [timeStr substringToIndex:range.location];
    self.time.text = time;
    
}

- (void)setOtherShopsImage:(NSString * )shopsImage andShopsNameLabel:(NSString* )shopsName andShopsWeight:(NSString* )shopsWeight andShopsSpecifications:(NSString* )shopsSpecifications andShopsOriginalPriceTitle:(NSString* )shopsOriginalPriceTitle andShopsOriginalPrice:(NSString* )shopsOriginalPrice andShopsPromotionPriceTitle:(NSString* )shopsPromotionPriceTitle andShopsPromotionPrice:(NSString* )shopsPromotionPrice andTime:(NSString *)time
{
    [self.shopsImage sd_setImageWithURL:[NSURL URLWithString:shopsImage]];
    self.shopsName.text = shopsName;
    self.shopsWeight.text = shopsWeight;
    self.shopsSpecifications.text = shopsSpecifications;
    self.shopsOriginalPriceTitle.text = shopsOriginalPriceTitle;
    self.shopsOriginalPrice.text = shopsOriginalPrice;
    self.shopsPromotionPriceTitle.text = shopsPromotionPriceTitle;
    self.shopsPromotionPrice.text = shopsPromotionPrice;
    self.time.text = time;
}

@end
