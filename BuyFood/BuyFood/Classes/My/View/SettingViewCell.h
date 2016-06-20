//
//  SettingViewCell.h
//  购菜App-商家版
//
//  Created by 黄栋春 on 16/6/14.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewCell : UITableViewCell

@property (nonatomic, strong) UISwitch* switchBtn;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, assign) NSInteger tag1;



+ (instancetype)cellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
//+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setTitleStr:(NSString* )titleStr;

@end
