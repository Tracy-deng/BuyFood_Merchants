//
//  ShopsManagementCell.m
//  BuyFood
//
//  Created by 黄栋春 on 16/8/4.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopsManagementCell.h"
#import "UIImageView+WebCache.h"

@implementation ShopsManagementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _foodImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopsImage"]];
        [self.contentView addSubview:_foodImageView];
        [_foodImageView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.equalTo(self.contentView).offset(8);
            make.width.equalTo(@60);
            make.height.equalTo(@60);
        }];
        
        _hotImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopsImage"]];
        [self.contentView addSubview:_hotImageview];
        [_hotImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_foodImageView);
            make.left.equalTo(_foodImageView.mas_right).offset(10);
            make.width.equalTo(@15);
            make.height.equalTo(@15);
            
        }];
        
        _nameLabel = [UILabel new];
        _nameLabel.text = @"新鲜的大白菜";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_hotImageview.mas_right).offset(7);
            make.top.equalTo(_hotImageview);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@20);
        }];
        
        _priceLabel = [UILabel new];
        _priceLabel.text = @"12.00 / 份";
        _priceLabel.textColor = greenColor;
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).offset(10);
            make.left.equalTo(_nameLabel);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@25);
        }];
    }
    return self;
}

- (void)setModelList:(ShopsModelList *)modelList
{
    // 商品图片
    [_foodImageView sd_setImageWithURL:[NSURL URLWithString:modelList.productpic] placeholderImage:nil];
    // 商品名称
    _nameLabel.text = modelList.productname;
    // 标签图片
    if ([modelList.productlabel isEqualToString:@"热销"]) {
        _hotImageview.image  = [UIImage imageNamed:@"hot"];
    }
    else if([modelList.productlabel isEqualToString:@"促销"])
    {
        _hotImageview.image  = [UIImage imageNamed:@"sales"];
    }
    else if([modelList.productlabel isEqualToString:@"普通"])
    {
        _hotImageview.image  = [UIImage imageNamed:@"nomel"];
    }
    // 单位
    NSString *unit = modelList.productunit;
    
    // 价格
    NSInteger priceNum = [modelList.productoutprice integerValue];
    _priceLabel.text = [NSString stringWithFormat:@"%ld/%@", (long)priceNum,unit ];;
}

@end
