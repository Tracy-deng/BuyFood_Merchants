//
//  ownSlovedTableViewCell.m
//  BuyFood
//
//  Created by dave-n1 on 16/6/22.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "ownSlovedTableViewCell.h"

@implementation ownSlovedTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _pushAddTimeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_pushAddTimeBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 13"] forState:(UIControlStateNormal)];
        [_pushAddTimeBtn setTitle:@"买家取消" forState:(UIControlStateNormal)];;
        _pushAddTimeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_pushAddTimeBtn];
        [_pushAddTimeBtn setTitleColor:greenColor forState:(UIControlStateNormal)];;
        [_pushAddTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(37);
            make.left.equalTo(self.contentView).offset(85);
            make.width.equalTo(@(0.4*SCREEN_WIDTH));
            make.height.equalTo(@20);
            
        }];
        
        
        
        
        _addOrderBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addOrderBtn.layer.masksToBounds = YES;
        _addOrderBtn.layer.cornerRadius = 32;
        _addOrderBtn.backgroundColor = [UIColor colorWithWhite:0.704 alpha:1.000];
        [_addOrderBtn setTitle:@"已取消" forState:(UIControlStateNormal)];
        _addOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_addOrderBtn];
        [_addOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(35);
            make.right.equalTo(self.contentView).offset(-10);
            make.width.height.equalTo(@64);
        }];
        
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
