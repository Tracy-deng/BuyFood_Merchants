//
//  ShopTableViewCell.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/27.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ShopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _foodImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopsImage"]];
        [self.contentView addSubview:_foodImageView];
        [_foodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.contentView).offset(8);
            make.left.equalTo(self.contentView).offset(8);
            make.width.equalTo(@60);
            make.height.equalTo(@60);
        }];
        
        _hotImageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shopsImage"]];
        [self.contentView addSubview:_hotImageview];
        [_hotImageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_foodImageView);
            make.left.equalTo(_foodImageView.mas_right).offset(10);
            make.width.equalTo(@18);
            make.height.equalTo(@18);
            
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
            make.height.equalTo(@25);
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

- (void)setProductModel:(ModlistModel *)productModel
{
    // 商品图片
    [_foodImageView sd_setImageWithURL:[NSURL URLWithString:productModel.productpic] placeholderImage:nil];
    
    // 商品名称
    _nameLabel.text = productModel.productname;
    
    
   // 标签图片
    if ([productModel.productlabel isEqualToString:@"热销"]) {
        _hotImageview.image  = [UIImage imageNamed:@"hot"];
    }
    // 单位
    NSString *unit = productModel.productunit;
    
   // 价格
    NSInteger priceNum = [productModel.productoutprice integerValue];
    _priceLabel.text = [NSString stringWithFormat:@"%ld/%@", priceNum,unit ];;
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
