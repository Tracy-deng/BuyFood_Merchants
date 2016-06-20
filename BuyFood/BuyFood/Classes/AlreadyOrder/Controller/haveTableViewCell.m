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
