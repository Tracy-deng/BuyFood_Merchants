//
//  EvaluateCell.m
//  评价
//
//  Created by 黄栋春 on 16/6/30.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "EvaluateCell.h"
#import "UIView+HDCExtension.h"
#import "Masonry.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation EvaluateCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    EvaluateCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[EvaluateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setBackgroundColor:[UIColor clearColor]];
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
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rectangle"]];
    imageView.userInteractionEnabled = YES;
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(25);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.87);
        make.height.equalTo(@(SCREEN_HEIGHT * 0.16));
    }];
    
     self.textView = [[UITextView alloc] init];
    [self.textView setBackgroundColor:[UIColor clearColor]];
    [imageView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(1);
        make.top.mas_equalTo(imageView.mas_top).offset(10);
        make.width.mas_equalTo(self.contentView.mas_width).multipliedBy(0.855);
        make.height.equalTo(@(SCREEN_HEIGHT * 0.14));
    }];
}

@end
