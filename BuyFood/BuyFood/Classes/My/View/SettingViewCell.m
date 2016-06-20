//
//  SettingViewCell.m
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/14.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import "SettingViewCell.h"

@implementation SettingViewCell

//+ (instancetype)cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *ID = @"status";
//    SettingViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
////    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
////    SettingViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell)
//    {
//        cell = [[SettingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    return cell;
//}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"status";
    SettingViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[SettingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setContentView];
    }
    return self;
}

- (void)setContentView
{
    if (self.tag1 == 0)
    {
        self.switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(self.contentView.width * 0.8, self.contentView.height * 0.15, self.contentView.width * 0.14, 20)];
        [self.contentView addSubview:self.switchBtn];
    }
    if (self.tag1 == 2)
    {
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.width * 0.8 + 15, self.contentView.height * 0.2, self.contentView.width * 0.2, 30)];
        nameLabel.text = @"张三";
        nameLabel.textColor = HDCColor(153, 153, 153);
        [self.contentView addSubview:nameLabel];
    }
}

- (void)setTitleStr:(NSString* )titleStr
{
    self.textLabel.text = titleStr;
    self.textLabel.textColor = HDCColor(102, 102, 102);
}

@end
