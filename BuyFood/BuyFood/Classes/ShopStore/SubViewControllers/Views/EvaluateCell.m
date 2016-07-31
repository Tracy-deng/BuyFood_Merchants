//
//  EvaluateCell.m
//  评价
//
//  Created by 黄栋春 on 16/6/30.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "EvaluateCell.h"
#import "JADEMethods.h"
#import "UIImageView+WebCache.h"
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation EvaluateCell
{
    NSIndexPath *_currentEditingIndexthPath;
    CGFloat height1;
    NSString *chartId;
    CGFloat height2;
    UILabel *ReplayLabel;
    NSString *replay;
}

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
    /** 头像 */
    self.headerImage = [[UIImageView alloc] init];
    [self addSubview:self.headerImage];
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.15);
        make.height.equalTo(self.headerImage.mas_width);
    }];
    /** 用户昵称 */
    self.userName = [[UILabel alloc] init];
    self.userName.textColor = HDCColor(102, 102, 102);
    self.userName.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [self addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImage.mas_right).offset(20);
        make.top.equalTo(self.headerImage);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.25);
        make.height.mas_equalTo(self.userName.mas_width).multipliedBy(0.33);
    }];
    /** 评价 好评-中评-差评 */
    self.evaluate = [[UILabel alloc] init];
    self.evaluate.textColor = HDCColor(102, 102, 102);
    self.evaluate.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    [self addSubview:self.evaluate];
    [self.evaluate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userName.mas_right).offset(20);
        make.centerY.equalTo(self.userName.mas_centerY);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.10);
        make.height.mas_equalTo(self.evaluate.mas_width).multipliedBy(0.50);
    }];
    /** 评价内容 */
    self.evaluateContent = [[UILabel alloc] init];
    self.evaluateContent.numberOfLines = 0;
    self.evaluateContent.textColor = HDCColor(102, 102, 102);
    self.evaluateContent.font = [UIFont systemFontOfSize:14*JADESCREENSCALE];
    [self addSubview:self.evaluateContent];
    
    /** 评价时间 */
    self.evaluateTime = [[UILabel alloc] init];
    self.evaluateTime.textAlignment = NSTextAlignmentCenter;
    self.evaluateTime.textColor = HDCColor(102, 102, 102);
    self.evaluateTime.font = [UIFont fontWithName:@"PingFangSC-Light" size:14*JADESCREENSCALE];
    [self addSubview:self.evaluateTime];
    [self.evaluateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.top.equalTo(self.evaluate);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.25);
        make.height.equalTo(self.evaluate);
    }];
    //回复内容
    ReplayLabel = [[UILabel alloc]init];
    ReplayLabel.font = [UIFont systemFontOfSize:14*JADESCREENSCALE];
    ReplayLabel.numberOfLines = 0;
    [self addSubview:ReplayLabel];
    
    
    /** 回复按钮 */
    self.replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.replyBtn setBackgroundImage:[UIImage imageNamed:@"rectangle1Copy2"] forState:UIControlStateNormal];
    [self.replyBtn setTitle:@"回复" forState:UIControlStateNormal];
    self.replyBtn.titleLabel.textColor = HDCColor(250, 250, 250);
    self.replyBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
    [self addSubview:self.replyBtn];
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.18);
        make.height.equalTo(self.replyBtn.mas_width).multipliedBy(0.35);
    }];
    [self.replyBtn addTarget:self action:@selector(replay:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setModel:(jadeModel *)model
{
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.userName.text = model.showname;
    if ([model.score intValue] == 1)
    {
        self.evaluate.text = @"好评";
    }
    else if ([model.score intValue] == 2)
    {
        self.evaluate.text = @"中评";
    }
    else
    {
        self.evaluate.text = @"差评";
    }
    height1 = [JADEMethods getHeightByWidth:JADESIZE.width-10*JADESCREENSCALE title:model.charcontent font:[UIFont systemFontOfSize:14*JADESCREENSCALE]];
    
    replay = [NSString stringWithFormat:@"%@%@",@"商家回复：",model.charcontent2];
    height2 = [JADEMethods getHeightByWidth:JADESIZE.width-60*JADESCREENSCALE title:replay font:[UIFont systemFontOfSize:14*JADESCREENSCALE]];
    _evaluateContent.frame = CGRectMake(5*JADESCREENSCALE,60,JADESIZE.width-10*JADESCREENSCALE , height1);
    if (model.charcontent2.length>=1) {
        self.replyBtn.hidden = YES;
        ReplayLabel.text = replay;
        ReplayLabel.frame = CGRectMake(30*JADESCREENSCALE, 70+height1, JADESIZE.width-60*JADESCREENSCALE, height2);
    }
    else
    {
        chartId =  model.chartid;
    }
    
    _evaluateContent.text = model.charcontent;
}
-(void)replay:(UIButton *)sender
{
    NSDictionary *dic = @{@"indexpath":_currentEditingIndexthPath,@"charID":chartId};
    NSLog(@"%@",dic);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Replay" object:dic];
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _currentEditingIndexthPath = indexPath;
}

@end
