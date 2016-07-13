//
//  ShopThreeCate.m
//  BuyFood
//
//  Created by dave-n1 on 16/7/12.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ShopThreeCate.h"

@implementation ShopThreeCate

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _nameLabel = [UILabel new];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(2);
            make.top.equalTo(self.contentView).offset(10);
            make.height.equalTo(@30);
            make.width.equalTo(@80);
        }];
    }
    
    return self;
}

- (void)setModel:(ModlistModel *)model
{
    _nameLabel.text = model.subcategoryname;
}

@end
