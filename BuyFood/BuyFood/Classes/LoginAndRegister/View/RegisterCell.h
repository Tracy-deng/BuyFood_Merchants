//
//  RegisterCell.h
//  BuyFood
//
//  Created by 黄栋春 on 16/7/10.
//  Copyright © 2016年 huangdongchun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterCell : UITableViewCell
/** 左边的标题 */
@property (nonatomic, strong) UILabel* leftTitleLabel;
/** 前三行的textField */
@property (nonatomic, strong) UITextField* contentTextField;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setLeftTitleLabel:(NSString* )leftTitleLabel andContentTextFieldPlaceholder:(NSString* )textFieldPlaceholder andContectText:(NSString* )contentText;
@end
