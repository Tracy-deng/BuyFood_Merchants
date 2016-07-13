//
//  PromotionTextFieldViewCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/14.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromotionTextFieldViewCell : UITableViewCell

@property (nonatomic, strong) UITextField* contentTextField;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setTitleLabel:(NSString* )title andContentTextFieldPlaceholder:(NSString* )contentTextFieldPlaceholder;

@end
