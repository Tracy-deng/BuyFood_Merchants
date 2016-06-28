//
//  SecondsKillCell.m
//  挖萝卜
//
//  Created by 黄栋春 on 16/6/26.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "SecondsKillCell.h" 

@interface SecondsKillCell ()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* contentLabel;

@end

@implementation SecondsKillCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    SecondsKillCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[SecondsKillCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.top.mas_equalTo(self.contentView.mas_top).offset(15);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textColor = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1];
    self.contentLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:20];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(30);
        make.top.equalTo(self.titleLabel);
        make.width.equalTo(self.titleLabel);
        make.height.equalTo(self.titleLabel);
    }];
}

- (void)setTitleLabel:(NSString* )title andContentLabel:(NSString* )contentText
{
    self.titleLabel.text = title;
    self.contentLabel.text = contentText;
}

@end
